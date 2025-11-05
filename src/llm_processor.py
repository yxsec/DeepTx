import os
import json
import pandas as pd
from typing import Dict, Any, List
from openai import OpenAI, OpenAIError
from .utils import load_json, load_text, load_csv, retry_with_exponential_backoff
from .prompt_schema import build_security_schema

api_key = os.environ.get("OPENAI_API_KEY")
if not api_key:
    raise ValueError("OPENAI_API_KEY environment variable is required")

client = OpenAI(
    api_key=api_key,
    base_url=os.environ.get("OPENAI_BASE_URL", "https://api.openai.com/v1")
)

PREV_RESPONSE_ID = {}

@retry_with_exponential_backoff(max_retries=3, initial_delay=2.0, exceptions=(OpenAIError, Exception))
def call_with_chain(model_name: str, system_msg: str, prompt: str, schema: dict, temperature: float = 0.1):
    payload = {
        "model": model_name,
        "input": [
            {"role": "system", "content": system_msg},
            {"role": "user", "content": prompt},
        ],       
        "temperature": temperature,
        "store": True,
        "text": {
            "format": {
                "type": "json_schema",
                "name": "security_assessment", 
                "strict": True,
                "schema": schema
            }
        },  
    }

    prev_id = PREV_RESPONSE_ID.get(model_name)
    if prev_id:
        payload["previous_response_id"] = prev_id

    response = client.responses.create(**payload)
    PREV_RESPONSE_ID[model_name] = response.id
    text = getattr(response, "output_text")

    return json.loads(text)

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

def extract_function_frequency(call_chain: List[Dict]) -> Dict[str, int]:
    """
    Extract function call frequency from call chain.

    Args:
        call_chain: List of call records with 'function' field

    Returns:
        Dictionary mapping function name to call count
    """
    frequency = {}
    for call in call_chain:
        func = call.get('function', '')
        if func and func.strip():
            frequency[func] = frequency.get(func, 0) + 1
    return frequency

def select_top_functions_from_code(code: str, top_functions: List[str], max_functions: int = 20) -> str:
    """
    Extract only the specified top functions from code.

    Args:
        code: Full code string with function blocks
        top_functions: List of function names to keep (ordered by priority)
        max_functions: Maximum number of functions to keep

    Returns:
        Filtered code containing only top functions
    """
    if not code or not top_functions:
        return ""

    # Split by function blocks
    function_blocks = code.split('\n\n< Function')

    if len(function_blocks) <= 1:
        # No clear function boundaries
        return code

    # Extract function name from block header
    def get_function_name(block: str) -> str:
        # Format: "< Function from address - function_name in file >"
        lines = block.split('\n', 1)
        if lines:
            header = lines[0]
            if ' - ' in header and ' in ' in header:
                parts = header.split(' - ')
                if len(parts) >= 2:
                    func_part = parts[1].split(' in ')[0].strip()
                    return func_part
        return ""

    # Keep the first block (usually preamble)
    kept_blocks = [function_blocks[0]]
    functions_added = 0

    # Process remaining blocks
    for block in function_blocks[1:]:
        if functions_added >= max_functions:
            break

        block_with_marker = '\n\n< Function' + block
        func_name = get_function_name(block)

        # Check if this function is in top list
        if func_name in top_functions:
            kept_blocks.append(block_with_marker)
            functions_added += 1

    result = ''.join(kept_blocks)

    if functions_added < len(top_functions):
        omitted = len(top_functions) - functions_added
        result += f"\n\n[Note: {omitted} other called functions omitted due to token limits]"

    return result

def smart_token_management(data: Dict[str, Any], max_total_tokens: int = 25000) -> Dict[str, Any]:
    """
    Smart token management: prioritize essential data, selectively include code.

    Strategy:
    1. Always include: call_chain, asset_flows, state_changes, gas, db_report
    2. If tokens remaining: include top N most-called functions
    3. If still not enough: skip code analysis entirely

    Args:
        data: Transaction data dictionary
        max_total_tokens: Maximum total tokens allowed

    Returns:
        Optimized data dictionary
    """
    print(f"\n=== SMART TOKEN MANAGEMENT (Max: {max_total_tokens:,} tokens) ===")

    optimized_data = data.copy()
    ba = optimized_data.get("behavior_analysis", {}).copy()

    # Calculate tokens for essential data (everything except code)
    essential_tokens = sum([
        estimate_tokens(json.dumps(ba.get("call_chain", []), indent=2)),
        estimate_tokens(json.dumps(ba.get("asset_flows", []), indent=2)),
        estimate_tokens(json.dumps(ba.get("state_changes", []), indent=2)),
        estimate_tokens(json.dumps(optimized_data.get("context_analysis", {}), indent=2)),
        estimate_tokens(json.dumps(optimized_data.get("ui_analysis", {}), indent=2)),
        estimate_tokens(json.dumps(optimized_data.get("malicious_database_report", {}), indent=2)),
    ])

    # Reserve tokens for prompt instructions (~2000 tokens)
    prompt_overhead = 2000
    available_for_code = max_total_tokens - essential_tokens - prompt_overhead

    print(f"  Essential data tokens: ~{essential_tokens:,}")
    print(f"  Available for code: ~{available_for_code:,}")

    # Handle code analysis based on available tokens
    code = ba.get("code_analysis", "")
    code_tokens = estimate_tokens(code) if code else 0

    if code_tokens == 0:
        print(f"  ✓ No code to analyze")
        optimized_data["behavior_analysis"] = ba
        return optimized_data

    if code_tokens <= available_for_code:
        # Enough tokens, keep all code
        print(f"  ✓ Including all code: ~{code_tokens:,} tokens")
        optimized_data["behavior_analysis"] = ba
        return optimized_data

    # Not enough tokens - use function frequency analysis
    print(f"  ⚠ Code too large ({code_tokens:,} tokens), analyzing function frequency...")

    call_chain = ba.get("call_chain", [])
    if not call_chain:
        # No call chain, can't determine function importance
        print(f"  ⚠ No call chain available, skipping code analysis entirely")
        ba["code_analysis"] = ""
        ba["_code_skipped_reason"] = "insufficient_tokens_no_call_chain"
        optimized_data["behavior_analysis"] = ba
        return optimized_data

    # Extract function frequency
    func_frequency = extract_function_frequency(call_chain)
    if not func_frequency:
        print(f"  ⚠ No function calls detected, skipping code analysis")
        ba["code_analysis"] = ""
        ba["_code_skipped_reason"] = "no_function_calls"
        optimized_data["behavior_analysis"] = ba
        return optimized_data

    # Sort by frequency (most called first)
    sorted_functions = sorted(func_frequency.items(), key=lambda x: x[1], reverse=True)

    print(f"  📊 Found {len(sorted_functions)} unique functions called")
    print(f"  Top 5 most called: {[f'{func}({count}x)' for func, count in sorted_functions[:5]]}")

    # Try to fit top N functions
    max_functions_to_try = min(20, len(sorted_functions))

    for num_functions in range(max_functions_to_try, 0, -1):
        top_funcs = [func for func, _ in sorted_functions[:num_functions]]
        filtered_code = select_top_functions_from_code(code, top_funcs, num_functions)
        filtered_tokens = estimate_tokens(filtered_code)

        if filtered_tokens <= available_for_code:
            print(f"  ✓ Including top {num_functions} functions: ~{filtered_tokens:,} tokens")
            ba["code_analysis"] = filtered_code
            ba["_code_selection"] = {
                "strategy": "top_n_by_frequency",
                "functions_included": num_functions,
                "total_functions": len(sorted_functions),
                "top_functions": [{"name": func, "calls": count} for func, count in sorted_functions[:num_functions]]
            }
            optimized_data["behavior_analysis"] = ba
            return optimized_data

    # Even top function doesn't fit - skip code entirely
    print(f"  ⚠ Unable to fit any functions within token budget")
    print(f"  ℹ Proceeding WITHOUT code analysis (other data is complete)")
    ba["code_analysis"] = ""
    ba["_code_skipped_reason"] = "insufficient_tokens_even_for_top_function"
    optimized_data["behavior_analysis"] = ba

    return optimized_data

def process_transaction_data(dir_path: str) -> Dict[str, Any]:
    """Process all transaction data from output directory with 4 categories"""
    print(f"Processing transaction data from: {dir_path}")
    
    # 1. BEHAVIOR ANALYSIS
    print("  1. Loading behavior analysis data...")
    
    call_trace_path = os.path.join(dir_path, "call_trace.csv")
    call_chain = []
    if os.path.exists(call_trace_path):
        df_call_trace = pd.read_csv(call_trace_path)
        trace_data = df_call_trace.to_dict(orient='records')
        for call in trace_data:
            entry = {
                "depth": call.get("depth", 0),
                "from": call.get("from", ""),
                "to": call.get("to", ""),
                "call_type": call.get("call_type", "unknown"),
                "function": call.get("function", "")
            }
            if call.get("gas_used") not in (None, "", 0):
                entry.update({
                    "gas_allocated": call.get("gas_allocated", ""),
                    "gas_used": call.get("gas_used", ""),
                    "gas_remaining": call.get("gas_remaining", "")
                })
            call_chain.append(entry)
        
        print(f"Loaded {len(call_chain)} call records from call_trace.csv")
    
    # Code analysis
    code_path = os.path.join(dir_path, "code.txt")
    code_analysis = load_text(code_path)
    # Asset flows
    asset_flows = []
    asset_path = os.path.join(dir_path, "asset_flows.csv")
    if os.path.exists(asset_path):
        asset_flows = load_csv(asset_path)
    else:
        print(f"No asset flows, skipping")   
    
    # State changes
    state_changes = []
    state_path = os.path.join(dir_path, "state_changes.csv")
    if os.path.exists(state_path):
        state_changes = load_csv(state_path)
    else:
        print(f"No state changes, skipping")
    
    # 2. CONTEXT ANALYSIS (Gas) 
    print("  2. Loading context analysis (gas) data...")
    gas_path = os.path.join(dir_path, "call_trace.csv")
    gas_data = load_csv(gas_path)
    gas_info_path = os.path.join(dir_path, "gas_info.txt")

    # Gas analysis summary
    if any((r.get("gas_used")) not in (None, "", 0) for r in gas_data):
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

        if os.path.exists(gas_info_path):
            try:
                with open(gas_info_path, 'r') as f:
                    gas_info = {}
                    for line in f:
                        if ':' in line:
                            key, value = line.strip().split(':', 1)
                            gas_info[key.strip()] = value.strip()
                gas_analysis["tx_gas_price"] = int(gas_info.get("tx_gas_price", 0))
                if gas_info.get("block_base_fee") != 0:
                    gas_analysis["block_base_fee"] = int(gas_info.get("block_base_fee", 0))
            except Exception as e:
                print(f"Simulation don't analyze gas information.")  
                gas_analysis = {}
    else:
        gas_analysis = {}

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
                "js_sample": js_text
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
        # "trace_calls_total": len(trace_data.get("calls", [])) if trace_data else 0,
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

def enhanced_feature_analysis(data: Dict[str, Any], model_name: str):
    """Enhanced LLM analysis with user-friendly output"""

    print("=== SMART EMBEDDING STRATEGY ===")

    # Apply smart token management
    # Model-specific token limits (conservative to avoid API errors)
    model_token_limits = {
        "gpt-4o": 25000,          # GPT-4o with 128K context
        "gpt-4o-mini": 20000,      # GPT-4o mini version
        "gpt-4.1-mini": 20000,     # Similar to gpt-4o-mini
        "gpt-3.5-turbo": 8000,     # Smaller context window
    }

    # Allow override via environment variable
    env_max_tokens = os.environ.get("MAX_ANALYSIS_TOKENS")
    if env_max_tokens:
        try:
            max_tokens = int(env_max_tokens)
            print(f"  Using custom token limit: {max_tokens:,}")
        except ValueError:
            max_tokens = model_token_limits.get(model_name, 20000)
    else:
        max_tokens = model_token_limits.get(model_name, 20000)

    # Apply token management strategy
    data = smart_token_management(data, max_total_tokens=max_tokens)

    # Create 4-category analysis prompt
    ba = data.get("behavior_analysis", {})
    sections = [
    ("Call Chain Analysis", ba.get("call_chain")),
    ("Code Analysis",       ba.get("code_analysis")),
    ("Asset Flows",         ba.get("asset_flows")),
    ("State Changes",       ba.get("state_changes")),
    ]
    parts = []
    for title, v in sections:
        if v is None:
            continue
        if isinstance(v, str):
            v = v.strip()
            if not v: 
                continue
            s = v
        elif isinstance(v, (list, dict)):
            if not v:
                continue
            s = json.dumps(v, indent=2, ensure_ascii=False)
        else:
            s = json.dumps(v, indent=2, ensure_ascii=False)
        parts.append(f"{title}:\n{s}")
    behavior_block = "\n\n".join(parts)

    ui_block = f"""JavaScript Analysis:
{json.dumps(data["ui_analysis"], indent=2)}
"""
    # Prepare database
    db_block = f"""Security Database Check:
{json.dumps(data["malicious_database_report"], indent=2)}
"""
    # Combine sections
    sections = []
    sections.append(("behavior_analysis", behavior_block))
    sections.append(("ui_analysis", ui_block))
    sections.append(("malicious_database_report", db_block))
    # Judge if need to include context analysis 
    has_context = bool(data.get("context_analysis"))
    if has_context:
        context_block = f"""Gas Usage Analysis:
{json.dumps(data["context_analysis"], indent=2)}
"""
        sections.append(("context_analysis", context_block))
    # Automatically number sections
    numbered_sections = "\n\n".join(
        f"<{i}_{name}>\n{body}</{i}_{name}>"
        for i, (name, body) in enumerate(sections, start=1)
    )
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
    
    # Prepare UI phishing detection note
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

{numbered_sections}

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

Risk level definitions:
- "safe": No security concerns detected across all categories
- "suspicious": Some concerning patterns but not clearly malicious
- "malicious": Clear evidence of malicious behavior in one or more categories
</comprehensive_security_analysis>"""

    # Send to LLM 
    print(f"  Sending analysis request ...")
    system_msg = "You are a blockchain security expert. Provide detailed analysis in JSON format."
    has_malicious_db = bool(data.get("malicious_database_report").get("has_meaningful_data", False))
    schema = build_security_schema(has_context, has_malicious_db)
    analysis_result = call_with_chain(model_name, system_msg, prompt, schema)
    
    return analysis_result, has_context, has_malicious_db
