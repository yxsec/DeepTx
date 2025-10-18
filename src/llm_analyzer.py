import os
import json
import time
from typing import List, Dict, Any
from src import llm_processor
from .consensus_engine import run_consensus_analysis

def run_multi_model_analysis(tx_dir: str, models: List[str] = None) -> Dict[str, Any]:
    if models is None:
        models = ["gpt-4o-mini", "gpt-4.1-mini", "gpt-4o"]
    
    print(f"Starting multi-model analysis for transaction: {tx_dir}")
    print(f"Models to test: {', '.join(models)}")
    
    # Check if transaction directory exists
    if not os.path.exists(tx_dir):
        print(f"Error: Transaction directory not found: {tx_dir}")
        return {}
    
    # Process transaction data once (shared across all models)
    print("\n1. Loading and processing transaction data...")
    data = llm_processor.process_transaction_data(tx_dir)
    
    results = {}
    
    # Run analysis with each model
    for i, model in enumerate(models, 1):
        print(f"\n{i}. Running analysis with {model}...")
        
        try:
            # Run analysis
            start_time = time.time()
            result, has_context, has_malicious_db = llm_processor.enhanced_feature_analysis(data, model)
            end_time = time.time()
            
            # Add timing information
            result["analysis_metadata"] = {
                "model": model,
                "analysis_time_seconds": round(end_time - start_time, 2),
                "timestamp": time.strftime("%Y-%m-%d %H:%M:%S")
            }
            
            results[model] = result
            
            # Save individual model report
            report_filename = f"security_analysis_{model.replace('-', '_')}.json"
            report_path = os.path.join(tx_dir, report_filename)
            
            with open(report_path, 'w', encoding='utf-8') as f:
                json.dump(result, f, indent=2, ensure_ascii=False)
            
            print(f"   ✓ Analysis completed in {result['analysis_metadata']['analysis_time_seconds']}s")
            print(f"   ✓ Report saved to: {report_path}")
            
            # Display summary
            print(f"   Risk Level: {result['risk_level'].upper()}")
            print(f"   Confidence: {result['confidence_score']}%")
            
        except Exception as e:
            print(f"   ✗ Error with {model}: {e}")
            results[model] = {"error": str(e)}
    
    # Generate comparison report
    print(f"\n4. Generating comparison report...")
    comparison_report = generate_comparison_report(results, tx_dir)
    
    # Save comparison report
    comparison_path = os.path.join(tx_dir, "model_comparison_report.json")
    with open(comparison_path, 'w', encoding='utf-8') as f:
        json.dump(comparison_report, f, indent=2, ensure_ascii=False)
    
    print(f"   ✓ Comparison report saved to: {comparison_path}")
    
    # Run consensus analysis
    print(f"\n5. Running consensus analysis...")
    successful_outputs = []
    for model, result in results.items():
        if "error" not in result:
            successful_outputs.append(result)
    
    if len(successful_outputs) >= 2:
        consensus_result = run_consensus_analysis(successful_outputs, has_context, has_malicious_db, "gpt-4o-mini")
        
        # Save consensus report
        consensus_path = os.path.join(tx_dir, "consensus_final_report.json")
        with open(consensus_path, 'w', encoding='utf-8') as f:
            json.dump(consensus_result, f, indent=2, ensure_ascii=False)
        
        print(f"   ✓ Consensus analysis completed")
        print(f"   ✓ Final consensus report saved to: {consensus_path}")
        
        # Add consensus result to comparison report
        comparison_report["consensus_result"] = consensus_result
        with open(comparison_path, 'w', encoding='utf-8') as f:
            json.dump(comparison_report, f, indent=2, ensure_ascii=False)
    else:
        print(f"   ⚠ Not enough successful models for consensus analysis (need at least 2)")
    
    return results

def generate_comparison_report(results: Dict[str, Any], tx_dir: str) -> Dict[str, Any]:
    comparison = {
        "transaction_info": {
            "directory": tx_dir,
            "analysis_timestamp": time.strftime("%Y-%m-%d %H:%M:%S"),
            "models_tested": list(results.keys())
        },
        "model_results": {},
        "consensus_analysis": {},
        "performance_metrics": {}
    }
    
    # Extract results for each model
    for model, result in results.items():
        if "error" in result:
            comparison["model_results"][model] = {
                "status": "error",
                "error": result["error"]
            }
        else:
            comparison["model_results"][model] = {
                "status": "success",
                "risk_level": result.get("risk_level", "unknown"),
                "confidence_score": result.get("confidence_score", 0),
                "explanation": result.get("explanation", ""),
                "custom_scoring_criteria": result.get("custom_scoring_criteria", ""),
                "recommendations": result.get("recommendations", []),
                "category_analysis": result.get("category_analysis", {}),
                "analysis_time": result.get("analysis_metadata", {}).get("analysis_time_seconds", 0)
            }
    
    # Analyze consensus
    risk_levels = []
    confidence_scores = []
    
    for model, model_result in comparison["model_results"].items():
        if model_result["status"] == "success":
            risk_levels.append(model_result["risk_level"])
            confidence_scores.append(model_result["confidence_score"])
    
    if risk_levels:
        comparison["consensus_analysis"] = {
            "risk_level_consensus": get_consensus_risk_level(risk_levels),
            "average_confidence": round(sum(confidence_scores) / len(confidence_scores), 2),
            "confidence_range": f"{min(confidence_scores)}-{max(confidence_scores)}",
            "models_agreed": len(set(risk_levels)) == 1
        }
    
    # Performance metrics
    successful_models = [m for m, r in comparison["model_results"].items() if r["status"] == "success"]
    if successful_models:
        times = [comparison["model_results"][m]["analysis_time"] for m in successful_models]
        comparison["performance_metrics"] = {
            "fastest_model": successful_models[times.index(min(times))],
            "slowest_model": successful_models[times.index(max(times))],
            "average_time": round(sum(times) / len(times), 2),
            "total_analysis_time": round(sum(times), 2)
        }
    
    return comparison

def get_consensus_risk_level(risk_levels: List[str]) -> str:
    if not risk_levels:
        return "unknown"
    
    # Count occurrences
    counts = {}
    for level in risk_levels:
        counts[level] = counts.get(level, 0) + 1
    
    # Find most common
    most_common = max(counts, key=counts.get)
    
    # If unanimous, return that level
    if counts[most_common] == len(risk_levels):
        return most_common
    
    # If not unanimous, return the most severe level
    severity_order = {"malicious": 3, "suspicious": 2, "safe": 1}
    max_severity = max(severity_order.get(level, 0) for level in risk_levels)
    
    for level, severity in severity_order.items():
        if severity == max_severity and level in risk_levels:
            return level
    
    return most_common