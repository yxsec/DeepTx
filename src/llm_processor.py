#!/usr/bin/env python3
"""
Enhanced Multi-Modal Transaction Analysis with User-Friendly Output
Uses smart token limits and provides simplified security assessment
"""

import os
import json
import re
from typing import Dict, Any, List
from openai import OpenAI
import os

# Validate API key
api_key = os.environ.get("OPENAI_API_KEY")
if not api_key:
    raise ValueError("OPENAI_API_KEY environment variable is required")

client = OpenAI(
    api_key=api_key,
    base_url=os.environ.get("OPENAI_BASE_URL", "https://api.openai.com/v1")
)

def load_json(path: str) -> Dict[str, Any]:
    """Load JSON file"""
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return json.load(f)
    except Exception as e:
        print(f"Error loading {path}: {e}")
        return {}

def load_text(path: str) -> str:
    """Load text file"""
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return f.read()
    except Exception as e:
        print(f"Error loading {path}: {e}")
        return ""

def load_csv(path: str) -> List[Dict[str, Any]]:
    """Load CSV file"""
    try:
        import pandas as pd
        df = pd.read_csv(path)
        return df.to_dict('records')
    except Exception as e:
        print(f"Error loading {path}: {e}")
        return []

def create_full_embeddings(texts: List[str], model: str = "text-embedding-ada-002") -> List[List[float]]:
    """Create embeddings for full text content without truncation"""
    try:
        response = client.embeddings.create(
            model=model,
            input=texts
        )
        return [emb.embedding for emb in response.data]
    except Exception as e:
        print(f"Error creating embeddings: {e}")
        return []

def extract_full_code_content(code_snippets: List[Dict[str, Any]]) -> str:
    """Extract complete code content from all snippets"""
    full_code_content = []
    
    for snippet in code_snippets:
        # Include complete function code
        full_code = snippet.get("code", "")
        if full_code:
            full_code_content.append(full_code)
        
        # Also include signature separately for better representation
        signature = snippet.get("signature", "")
        if signature and signature not in full_code:
            full_code_content.append(signature)
    
    return "\n\n".join(full_code_content)

def estimate_tokens(text: str) -> int:
    """Rough token estimation (1 token ≈ 4 characters)"""
    return len(text) // 4

def create_full_input_embeddings(data: Dict[str, Any]) -> Dict[str, Any]:
    """Create embeddings using 4-category analysis with smart token limits"""
    embedding_data = {}
    texts_to_embed = []
    text_labels = []
    
    # Token limits for different content types
    MAX_BEHAVIOR_TOKENS = 4000  # ~16KB
    MAX_CONTEXT_TOKENS = 1500   # ~6KB
    MAX_UI_TOKENS = 1000        # ~4KB
    MAX_MALICIOUS_TOKENS = 500  # ~2KB
    TOTAL_MAX_TOKENS = 7000     # ~28KB total
    
    current_total_tokens = 0
    
    # 1. BEHAVIOR ANALYSIS
    print("  Processing behavior analysis for embedding...")
    behavior_data = data.get("behavior_analysis", {})
    
    # Call chain
    call_chain = behavior_data.get("call_chain", [])
    if call_chain:
        call_text = json.dumps(call_chain, indent=2)
        call_tokens = estimate_tokens(call_text)
        if call_tokens <= MAX_BEHAVIOR_TOKENS // 2 and (current_total_tokens + call_tokens) <= TOTAL_MAX_TOKENS:
            texts_to_embed.append(call_text)
            text_labels.append("behavior_call_chain")
            current_total_tokens += call_tokens
            print(f"    ✓ Adding call chain: {len(call_text)} characters ({call_tokens} tokens)")
        else:
            print(f"    ⚠ Call chain too large ({call_tokens} tokens), skipping")
    
    # Code analysis
    code_analysis = behavior_data.get("code_analysis", [])
    if code_analysis:
        code_text = json.dumps(code_analysis, indent=2)
        code_tokens = estimate_tokens(code_text)
        if code_tokens <= MAX_BEHAVIOR_TOKENS // 2 and (current_total_tokens + code_tokens) <= TOTAL_MAX_TOKENS:
            texts_to_embed.append(code_text)
            text_labels.append("behavior_code_analysis")
            current_total_tokens += code_tokens
            print(f"    ✓ Adding code analysis: {len(code_text)} characters ({code_tokens} tokens)")
        else:
            print(f"    ⚠ Code analysis too large ({code_tokens} tokens), skipping")
    
    # Asset flows
    asset_flows = behavior_data.get("asset_flows", [])
    if asset_flows:
        asset_text = json.dumps(asset_flows, indent=2)
        asset_tokens = estimate_tokens(asset_text)
        if asset_tokens <= MAX_BEHAVIOR_TOKENS // 4 and (current_total_tokens + asset_tokens) <= TOTAL_MAX_TOKENS:
            texts_to_embed.append(asset_text)
            text_labels.append("behavior_asset_flows")
            current_total_tokens += asset_tokens
            print(f"    ✓ Adding asset flows: {len(asset_text)} characters ({asset_tokens} tokens)")
        else:
            print(f"    ⚠ Asset flows too large ({asset_tokens} tokens), skipping")
    
    # 2. CONTEXT ANALYSIS (Gas)
    print("  Processing context analysis for embedding...")
    context_data = data.get("context_analysis", {})
    if context_data:
        context_text = json.dumps(context_data, indent=2)
        context_tokens = estimate_tokens(context_text)
        if context_tokens <= MAX_CONTEXT_TOKENS and (current_total_tokens + context_tokens) <= TOTAL_MAX_TOKENS:
            texts_to_embed.append(context_text)
            text_labels.append("context_gas_analysis")
            current_total_tokens += context_tokens
            print(f"    ✓ Adding gas analysis: {len(context_text)} characters ({context_tokens} tokens)")
        else:
            print(f"    ⚠ Gas analysis too large ({context_tokens} tokens), skipping")
    
    # 3. UI ANALYSIS (JavaScript)
    print("  Processing UI analysis for embedding...")
    ui_data = data.get("ui_analysis", {})
    if ui_data.get("js_code_present", False):
        js_sample = ui_data.get("js_sample", "")
        if js_sample:
            js_tokens = estimate_tokens(js_sample)
            if js_tokens <= MAX_UI_TOKENS and (current_total_tokens + js_tokens) <= TOTAL_MAX_TOKENS:
                texts_to_embed.append(js_sample)
                text_labels.append("ui_javascript_analysis")
                current_total_tokens += js_tokens
                print(f"    ✓ Adding JavaScript analysis: {len(js_sample)} characters ({js_tokens} tokens)")
            else:
                print(f"    ⚠ JavaScript too large ({js_tokens} tokens), skipping")
    
    # 4. MALICIOUS DATABASE REPORT (only if has meaningful data)
    print("  Processing malicious database report for embedding...")
    malicious_data = data.get("malicious_database_report", {})
    if malicious_data and malicious_data.get("has_meaningful_data", False):
        malicious_text = json.dumps(malicious_data, indent=2)
        malicious_tokens = estimate_tokens(malicious_text)
        if malicious_tokens <= MAX_MALICIOUS_TOKENS and (current_total_tokens + malicious_tokens) <= TOTAL_MAX_TOKENS:
            texts_to_embed.append(malicious_text)
            text_labels.append("malicious_database_report")
            current_total_tokens += malicious_tokens
            print(f"    ✓ Adding malicious database report: {len(malicious_text)} characters ({malicious_tokens} tokens)")
        else:
            print(f"    ⚠ Malicious database report too large ({malicious_tokens} tokens), skipping")
    else:
        print(f"    ⚠ Malicious database has no meaningful data, skipping")
    
    # Create embeddings for all content
    if texts_to_embed:
        print(f"  Creating embeddings for {len(texts_to_embed)} content pieces (total: {current_total_tokens} tokens)...")
        embeddings = create_full_embeddings(texts_to_embed)
        
        if embeddings:
            # Organize embeddings by type
            for label, embedding in zip(text_labels, embeddings):
                embedding_data[label] = {
                    "vector": embedding,
                    "dimension": len(embedding),
                    "text_length": len(texts_to_embed[text_labels.index(label)]),
                    "content_type": label
                }
            
            # Summary statistics
            total_chars = sum(len(text) for text in texts_to_embed)
            embedding_data["summary"] = {
                "total_embeddings": len(embeddings),
                "total_characters": total_chars,
                "total_tokens": current_total_tokens,
                "content_types": text_labels,
                "embedding_model": "text-embedding-ada-002",
                "smart_limits_applied": True,
                "limits": {
                    "max_behavior_tokens": MAX_BEHAVIOR_TOKENS,
                    "max_context_tokens": MAX_CONTEXT_TOKENS,
                    "max_ui_tokens": MAX_UI_TOKENS,
                    "max_malicious_tokens": MAX_MALICIOUS_TOKENS,
                    "total_max_tokens": TOTAL_MAX_TOKENS
                }
            }
            
            print(f"  ✓ Created {len(embeddings)} embeddings from {total_chars:,} total characters ({current_total_tokens} tokens)")
        else:
            print("  ✗ Failed to create embeddings")
    else:
        print("  No content available for embedding")
    
    return embedding_data

def process_transaction_data(dir_path: str) -> Dict[str, Any]:
    """Process all transaction data from output directory with 4 categories"""
    print(f"Processing transaction data from: {dir_path}")
    
    # 1. BEHAVIOR ANALYSIS
    print("  1. Loading behavior analysis data...")
    
    # Call chain (trace)
    trace_path = os.path.join(dir_path, "decoded_trace.json")
    trace_data = load_json(trace_path)
    call_chain = []
    if trace_data:
        for call in trace_data.get("calls", [])[:15]:  # Limit to first 15 calls
            call_chain.append({
                "type": call.get("type", "unknown"),
                "from": call.get("from", ""),
                "to": call.get("to", ""),
                "value": call.get("value", "0"),
                "method": call.get("method", "")
            })
    
    # Code analysis
    code_path = os.path.join(dir_path, "code.txt")
    code_text = load_text(code_path)
    code_analysis = []
    if code_text:
        # Extract security-relevant functions
        security_patterns = [
            r'function\s+\w*transfer\w*\s*\([^)]*\)[^{]*\{[^}]*\}',
            r'function\s+\w*approve\w*\s*\([^)]*\)[^{]*\{[^}]*\}',
            r'function\s+\w*call\w*\s*\([^)]*\)[^{]*\{[^}]*\}',
            r'function\s+\w*require\w*\s*\([^)]*\)[^{]*\{[^}]*\}',
            r'function\s+\w*assert\w*\s*\([^)]*\)[^{]*\{[^}]*\}'
        ]
        
        for pattern in security_patterns:
            matches = re.findall(pattern, code_text, re.IGNORECASE | re.DOTALL)
            for match in matches[:3]:  # Limit to 3 matches per pattern
                code_analysis.append({
                    "code": match,
                    "signature": match.split('{')[0].strip(),
                    "type": "security_function"
                })
    
    # Asset flows
    asset_path = os.path.join(dir_path, "asset_flows.csv")
    asset_flows = load_csv(asset_path)
    
    # State changes
    state_path = os.path.join(dir_path, "state_changes.csv")
    state_changes = load_csv(state_path)
    
    # 2. CONTEXT ANALYSIS (Gas)
    print("  2. Loading context analysis (gas) data...")
    gas_path = os.path.join(dir_path, "gas_usage.csv")
    gas_data = load_csv(gas_path)
    
    # Gas analysis summary
    gas_analysis = {}
    if gas_data:
        total_gas_used = sum(float(record.get("gas_used", 0)) for record in gas_data)
        total_gas_allocated = sum(float(record.get("gas_allocated", 0)) for record in gas_data)
        gas_efficiency = (total_gas_used / total_gas_allocated * 100) if total_gas_allocated > 0 else 0
        
        gas_analysis = {
            "total_gas_used": total_gas_used,
            "total_gas_allocated": total_gas_allocated,
            "gas_efficiency_percent": round(gas_efficiency, 2),
            "total_calls": len(gas_data),
            "average_gas_per_call": round(total_gas_used / len(gas_data), 2) if gas_data else 0
        }
    
    # 3. UI ANALYSIS (JavaScript)
    print("  3. Loading UI analysis data...")
    js_path = os.path.join(dir_path, "js.txt")
    ui_analysis = {}
    if os.path.exists(js_path):
        js_text = load_text(js_path)
        if js_text:
            ui_analysis = {
                "js_code_present": True,
                "js_code_length": len(js_text),
                "js_sample": js_text[:500] if len(js_text) > 500 else js_text
            }
    else:
        ui_analysis = {"js_code_present": False}
    
    # 4. MALICIOUS DATABASE REPORT
    print("  4. Loading malicious database report...")
    security_path = os.path.join(dir_path, "security_report.json")
    malicious_report = load_json(security_path)
    
    # Check if malicious database has meaningful data
    malicious_indicators = {
        "malicious_addresses": malicious_report.get("malicious_addresses", []),
        "code_patterns": malicious_report.get("code_patterns", []),
        "url_check": malicious_report.get("url_check", []),
        "js_patterns": malicious_report.get("js_patterns", [])
    }
    
    # Determine if malicious database should be used for analysis
    has_malicious_data = any(
        len(indicator) > 0 for indicator in malicious_indicators.values()
    )
    
    if has_malicious_data:
        print(f"    ✓ Malicious database has data: {sum(len(v) for v in malicious_indicators.values())} indicators")
        malicious_report["has_meaningful_data"] = True
        malicious_report["indicators_summary"] = {
            "malicious_addresses_count": len(malicious_indicators["malicious_addresses"]),
            "code_patterns_count": len(malicious_indicators["code_patterns"]),
            "url_check_count": len(malicious_indicators["url_check"]),
            "js_patterns_count": len(malicious_indicators["js_patterns"])
        }
    else:
        print(f"    ⚠ Malicious database is empty, will be excluded from analysis")
        malicious_report["has_meaningful_data"] = False
        malicious_report["indicators_summary"] = {
            "malicious_addresses_count": 0,
            "code_patterns_count": 0,
            "url_check_count": 0,
            "js_patterns_count": 0
        }
    
    # Transaction context
    context = {
        "transaction_hash": os.path.basename(dir_path),
        "trace_calls_total": len(trace_data.get("calls", [])) if trace_data else 0,
        "trace_calls_analyzed": len(call_chain),
        "code_functions_found": len(code_analysis),
        "asset_transfers": len(asset_flows),
        "state_changes": len(state_changes),
        "gas_records": len(gas_data),
        "ui_analysis_available": ui_analysis.get("js_code_present", False)
    }
    
    return {
        "behavior_analysis": {
            "call_chain": call_chain,
            "code_analysis": code_analysis,
            "asset_flows": asset_flows,
            "state_changes": state_changes
        },
        "context_analysis": gas_analysis,
        "ui_analysis": ui_analysis,
        "malicious_database_report": malicious_report,
        "context": context,
        "raw_trace": json.dumps(trace_data, indent=2) if trace_data else ""
    }

def enhanced_feature_analysis(data: Dict[str, Any], model_name: str) -> Dict[str, Any]:
    """Enhanced LLM analysis with user-friendly output"""
    
    print("=== SMART EMBEDDING STRATEGY ===")
    
    # Create embeddings with full content
    embedding_data = create_full_input_embeddings(data)
    
    # Prepare embedding info for prompt
    if embedding_data and "summary" in embedding_data:
        summary = embedding_data["summary"]
        embedding_info = {
            "vectors_generated": summary["total_embeddings"],
            "total_characters": summary["total_characters"],
            "content_types": summary["content_types"],
            "embedding_model": summary["embedding_model"],
            "strategy": "Smart limits applied"
        }
    else:
        embedding_info = {"error": "Failed to create embeddings"}
    
    # Create 4-category analysis prompt
    # Prepare database note
    db_note = ""
    if data["malicious_database_report"].get("has_meaningful_data", False):
        db_note = f"Database contains {data['malicious_database_report'].get('indicators_summary', {}).get('malicious_addresses_count', 0)} malicious addresses, {data['malicious_database_report'].get('indicators_summary', {}).get('code_patterns_count', 0)} code patterns, {data['malicious_database_report'].get('indicators_summary', {}).get('url_check_count', 0)} URL checks, and {data['malicious_database_report'].get('indicators_summary', {}).get('js_patterns_count', 0)} JS patterns."
    else:
        db_note = "Database is empty - no malicious indicators found."
    
    # Prepare database category
    db_category = ""
    if data["malicious_database_report"].get("has_meaningful_data", False):
        db_category = f"4. Database threat intelligence ({data['malicious_database_report'].get('indicators_summary', {}).get('malicious_addresses_count', 0)} addresses, {data['malicious_database_report'].get('indicators_summary', {}).get('code_patterns_count', 0)} patterns)"
    
    # Prepare malicious patterns line
    malicious_patterns = ""
    if data["malicious_database_report"].get("has_meaningful_data", False):
        malicious_patterns = "- Known malicious addresses or patterns"
    
    # Prepare database note for scoring
    db_scoring_note = ""
    if data["malicious_database_report"].get("has_meaningful_data", False):
        db_scoring_note = "Note: Database threat intelligence has meaningful data and should be included in scoring with appropriate weight."
    else:
        db_scoring_note = "Note: Database threat intelligence has no meaningful data and should be excluded from scoring (weight = 0). Redistribute weights among the other 3 categories."
    
    # Prepare malicious_db_score field
    malicious_db_score_field = ""
    if data["malicious_database_report"].get("has_meaningful_data", False):
        malicious_db_score_field = ', "malicious_db_score": 0-100'
    
    # Prepare database note
    db_note = ""
    if data["malicious_database_report"].get("has_meaningful_data", False):
        db_note = f"Database contains {data['malicious_database_report'].get('indicators_summary', {}).get('malicious_addresses_count', 0)} malicious addresses, {data['malicious_database_report'].get('indicators_summary', {}).get('code_patterns_count', 0)} code patterns, {data['malicious_database_report'].get('indicators_summary', {}).get('url_check_count', 0)} URL checks, and {data['malicious_database_report'].get('indicators_summary', {}).get('js_patterns_count', 0)} JS patterns."
    else:
        db_note = "Database is empty - no malicious indicators found."
    
    # Prepare database category
    db_category = ""
    if data["malicious_database_report"].get("has_meaningful_data", False):
        db_category = f"4. Database threat intelligence ({data['malicious_database_report'].get('indicators_summary', {}).get('malicious_addresses_count', 0)} addresses, {data['malicious_database_report'].get('indicators_summary', {}).get('code_patterns_count', 0)} patterns)"
    
    # Prepare malicious patterns line
    malicious_patterns = ""
    if data["malicious_database_report"].get("has_meaningful_data", False):
        malicious_patterns = "- Known malicious addresses or patterns"
    
    # Prepare database note for scoring
    db_scoring_note = ""
    if data["malicious_database_report"].get("has_meaningful_data", False):
        db_scoring_note = "Note: Database threat intelligence has meaningful data and should be included in scoring with appropriate weight."
    else:
        db_scoring_note = "Note: Database threat intelligence has no meaningful data and should be excluded from scoring (weight = 0). Redistribute weights among the other 3 categories."
    
    # Prepare malicious_db_score field
    malicious_db_score_field = ""
    if data["malicious_database_report"].get("has_meaningful_data", False):
        malicious_db_score_field = ', "malicious_db_score": 0-100'
    ui_present = data.get("ui_analysis", {}).get("js_code_present", False)
    ui_phishing_note = ""
    if ui_present:
        ui_phishing_note = (
            "\n\n[IMPORTANT] This transaction was initiated by the user through a detected UI (JavaScript frontend). "
            "Please pay special attention to whether the UI may be tricking or misleading the user into transferring funds, "
            "granting approvals, or signing messages (phishing behavior). Carefully analyze the security of UI-to-contract "
            "interactions and highlight any potential fraud or phishing risks. Clearly state in your analysis and conclusion "
            "whether such risks are present."
        )

    gentle_risk_note = ("\n\n[NOTE] If the transaction involves large or complex asset flows or state changes, but there is no evidence of abnormal or malicious code behavior, "
                       "do not automatically classify it as high risk. Only assign high risk if there are clear suspicious or malicious patterns in the code or transaction logic.")
    # === Add high credibility note for normal JS and official URL ===
    credibility_note = ("\n\n[NOTE] If the detected JavaScript code appears normal (no suspicious patterns) and the related URL(s) are from official or trusted sources, "
                      "consider this transaction to have high credibility. Please reflect this in your analysis and conclusion.")

    prompt = f"""<comprehensive_security_analysis>
You are a blockchain security expert. Analyze this transaction using 4 categories and provide a comprehensive security assessment.{ui_phishing_note}{gentle_risk_note}{credibility_note}

<transaction_context>
{json.dumps(data["context"], indent=2)}
</transaction_context>

<1_behavior_analysis>
Call Chain Analysis:
{json.dumps(data["behavior_analysis"]["call_chain"][:5], indent=2)}

Code Analysis:
{json.dumps(data["behavior_analysis"]["code_analysis"][:3], indent=2)}

Asset Flows:
{json.dumps(data["behavior_analysis"]["asset_flows"][:3], indent=2)}

State Changes:
{json.dumps(data["behavior_analysis"]["state_changes"][:3], indent=2)}
</1_behavior_analysis>

<2_context_analysis>
Gas Usage Analysis:
{json.dumps(data["context_analysis"], indent=2)}
</2_context_analysis>

<3_ui_analysis>
JavaScript Analysis:
{json.dumps(data["ui_analysis"], indent=2)}
</3_ui_analysis>

<4_malicious_database_report>
Security Database Check:
{json.dumps(data["malicious_database_report"], indent=2)}

Note: {db_note}
</4_malicious_database_report>

<custom_scoring_criteria>
Create your own scoring criteria with custom weights that sum to 1.0 based on the actual data available:

1. Behavior patterns (call complexity, suspicious functions, asset movements)
2. Gas efficiency and usage patterns  
3. UI/JavaScript security indicators
{db_category}

Consider factors like:
- Function call patterns and complexity
- Asset transfer amounts and destinations
- Gas usage efficiency
- JavaScript code security
{malicious_patterns}
- State change implications

{db_scoring_note}
</custom_scoring_criteria>

<output_format>
Provide a JSON response with exactly these fields:
{{
  "risk_level": "safe|suspicious|malicious",
  "confidence_score": 0-100,
  "custom_scoring_criteria": "Your detailed scoring criteria with custom weights that sum to 1.0. Include weight for each category and reasoning for weight distribution.",
  "explanation": "Explain what this transaction does in 2-3 sentences",
  "recommendations": ["Action item 1", "Action item 2", "Action item 3"],
  "category_analysis": {{
    "behavior_score": 0-100,
    "context_score": 0-100,
    "ui_score": 0-100{malicious_db_score_field}
  }}
}}

Risk level definitions:
- "safe": No security concerns detected across all categories
- "suspicious": Some concerning patterns but not clearly malicious
- "malicious": Clear evidence of malicious behavior in one or more categories
</output_format>
</comprehensive_security_analysis>"""

    # Send to LLM with retry logic
    max_retries = 3
    for attempt in range(max_retries):
        try:
            print(f"  Sending analysis request (attempt {attempt + 1}/{max_retries})...")
            
            response = client.chat.completions.create(
                model=model_name,
                messages=[
                    {"role": "system", "content": "You are a blockchain security expert. Provide detailed analysis in JSON format."},
                    {"role": "user", "content": prompt}
                ],
                temperature=0.1,
                max_tokens=2000
            )
            
            result = response.choices[0].message.content
            
            # Clean up response (remove markdown if present)
            if "```json" in result:
                result = result.split("```json")[1].split("```")[0].strip()
            elif "```" in result:
                result = result.split("```")[1].strip()
            
            # Parse JSON
            analysis_result = json.loads(result)
            
            # Validate required fields for 4-category analysis
            required_fields = ["risk_level", "confidence_score", "custom_scoring_criteria", "explanation", "recommendations", "category_analysis"]
            if all(field in analysis_result for field in required_fields):
                # Validate risk_level
                valid_risk_levels = ["safe", "suspicious", "malicious"]
                if analysis_result["risk_level"] in valid_risk_levels:
                    # Validate confidence_score
                    if 0 <= analysis_result["confidence_score"] <= 100:
                        # Validate category_analysis
                        category_analysis = analysis_result.get("category_analysis", {})
                        category_fields = ["behavior_score", "context_score", "ui_score"]
                        
                        # Add malicious_db_score only if database has meaningful data
                        if data["malicious_database_report"].get("has_meaningful_data", False):
                            category_fields.append("malicious_db_score")
                        else:
                            # Remove malicious_db_score if it exists but database has no meaningful data
                            if "malicious_db_score" in category_analysis:
                                del category_analysis["malicious_db_score"]
                        
                        if all(field in category_analysis for field in category_fields):
                            if all(0 <= category_analysis[field] <= 100 for field in category_fields):
                                print("  ✓ Valid 4-category analysis result received")
                                break
                            else:
                                print(f"  ⚠ Invalid category scores, retrying...")
                        else:
                            print(f"  ⚠ Missing category analysis fields, retrying...")
                    else:
                        print(f"  ⚠ Invalid confidence score, retrying...")
                else:
                    print(f"  ⚠ Invalid risk level, retrying...")
            else:
                print(f"  ⚠ Missing required fields, retrying...")
                
        except Exception as e:
            print(f"  ✗ Error on attempt {attempt + 1}: {e}")
            if attempt == max_retries - 1:
                analysis_result = {"error": f"Failed after {max_retries} attempts: {str(e)}"}
    
    # Create user-friendly output with 4-category analysis
    user_friendly_result = {
        "risk_level": analysis_result.get("risk_level", "unknown"),
        "confidence_score": analysis_result.get("confidence_score", 0),
        "custom_scoring_criteria": analysis_result.get("custom_scoring_criteria", ""),
        "explanation": analysis_result.get("explanation", ""),
        "recommendations": analysis_result.get("recommendations", []),
        "category_analysis": analysis_result.get("category_analysis", {})
    }
    
    return user_friendly_result

def main():
    """Main function"""
    # Example usage with a transaction directory
    tx_dir = "output/1/0xff8e9226091d513fc936ecc670030eba03f34dbe60cd012122bd18be44248d32"
    
    if os.path.exists(tx_dir):
        print("Starting enhanced analysis with user-friendly output...")
        
        # Process transaction data
        data = process_transaction_data(tx_dir)
        
        # Perform enhanced analysis
        result = enhanced_feature_analysis(data, "gpt-4o-mini")
        
        # Save results
        output_path = os.path.join(tx_dir, "enhanced_analysis_user_friendly.json")
        with open(output_path, 'w', encoding='utf-8') as f:
            json.dump(result, f, indent=2, ensure_ascii=False)
        
        print(f"\n=== COMPREHENSIVE SECURITY ASSESSMENT ===")
        print(f"Risk Level: {result['risk_level'].upper()}")
        print(f"Overall Confidence: {result['confidence_score']}%")
        print(f"Transaction Explanation: {result['explanation']}")
        
        print(f"\nCategory Analysis:")
        categories = result.get('category_analysis', {})
        print(f"  Behavior Score: {categories.get('behavior_score', 0)}%")
        print(f"  Context Score: {categories.get('context_score', 0)}%")
        print(f"  UI Score: {categories.get('ui_score', 0)}%")
        
        # Show malicious DB score only if database has meaningful data
        if data["malicious_database_report"].get("has_meaningful_data", False):
            print(f"  Malicious DB Score: {categories.get('malicious_db_score', 0)}%")
        else:
            print(f"  Malicious DB Score: Excluded (no meaningful data)")
        
        print(f"\nScoring Criteria:")
        print(f"  {result['custom_scoring_criteria']}")
        
        print(f"\nRecommendations:")
        for i, rec in enumerate(result['recommendations'], 1):
            print(f"  {i}. {rec}")
        
        print(f"\nAnalysis completed and saved to: {output_path}")
        
    else:
        print(f"Transaction directory not found: {tx_dir}")

if __name__ == "__main__":
    main() 