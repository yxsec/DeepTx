#!/usr/bin/env python3
"""
Multi-Model Security Analysis Script
====================================

This script runs security analysis on a transaction using three different models
and generates separate reports for each model in the transaction directory.
"""

import os
import json
import time
from typing import List, Dict, Any
from .llm_processor import process_transaction_data, enhanced_feature_analysis
from .consensus_engine import run_consensus_analysis

def run_multi_model_analysis(tx_dir: str, models: List[str] = None) -> Dict[str, Any]:
    """
    Run security analysis using multiple models on the same transaction.
    
    Args:
        tx_dir: Path to transaction directory
        models: List of model names to use (default: gpt-4o-mini, gpt-3.5-turbo, gpt-4o)
    
    Returns:
        Dictionary containing results from all models
    """
    if models is None:
        models = ["gpt-4o-mini", "gpt-3.5-turbo", "gpt-4o"]
    
    print(f"Starting multi-model analysis for transaction: {tx_dir}")
    print(f"Models to test: {', '.join(models)}")
    
    # Check if transaction directory exists
    if not os.path.exists(tx_dir):
        print(f"Error: Transaction directory not found: {tx_dir}")
        return {}
    
    # Process transaction data once (shared across all models)
    print("\n1. Loading and processing transaction data...")
    data = process_transaction_data(tx_dir)
    
    results = {}
    
    # Run analysis with each model
    for i, model in enumerate(models, 1):
        print(f"\n{i}. Running analysis with {model}...")
        
        try:
            # Run analysis
            start_time = time.time()
            result = enhanced_feature_analysis(data, model)
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
        consensus_result = run_consensus_analysis(successful_outputs, "gpt-4o-mini")
        
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
    """
    Generate a comparison report of results from different models.
    
    Args:
        results: Dictionary containing results from all models
        tx_dir: Transaction directory path
    
    Returns:
        Comparison report dictionary
    """
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
    """
    Determine consensus risk level from multiple model results.
    
    Args:
        risk_levels: List of risk levels from different models
    
    Returns:
        Consensus risk level
    """
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

def display_comparison_summary(comparison: Dict[str, Any]):
    """
    Display a summary of the comparison results.
    
    Args:
        comparison: Comparison report dictionary
    """
    print(f"\n=== MODEL COMPARISON SUMMARY ===")
    print(f"Transaction: {comparison['transaction_info']['directory']}")
    print(f"Models tested: {', '.join(comparison['transaction_info']['models_tested'])}")
    
    print(f"\nIndividual Results:")
    for model, result in comparison["model_results"].items():
        if result["status"] == "success":
            print(f"  {model}: {result['risk_level'].upper()} ({result['confidence_score']}%) - {result['analysis_time']}s")
            print(f"    Explanation: {result['explanation']}")
            print(f"    Scoring Criteria: {result['custom_scoring_criteria']}")
            print(f"    Recommendations: {', '.join(result['recommendations'][:2])}...")
        else:
            print(f"  {model}: ERROR - {result['error']}")
    
    if "consensus_analysis" in comparison and comparison["consensus_analysis"]:
        consensus = comparison["consensus_analysis"]
        print(f"\nConsensus Analysis:")
        print(f"  Consensus Risk Level: {consensus['risk_level_consensus'].upper()}")
        print(f"  Average Confidence: {consensus['average_confidence']}%")
        print(f"  Confidence Range: {consensus['confidence_range']}")
        print(f"  Models Agreed: {'Yes' if consensus['models_agreed'] else 'No'}")
    
    if "performance_metrics" in comparison and comparison["performance_metrics"]:
        perf = comparison["performance_metrics"]
        print(f"\nPerformance Metrics:")
        print(f"  Fastest Model: {perf['fastest_model']}")
        print(f"  Slowest Model: {perf['slowest_model']}")
        print(f"  Average Time: {perf['average_time']}s")
        print(f"  Total Analysis Time: {perf['total_analysis_time']}s")
    
    # Display consensus result if available
    if "consensus_result" in comparison:
        consensus = comparison["consensus_result"]
        print(f"\nConsensus Final Result:")
        print(f"  Risk Level: {consensus.get('risk_level', 'unknown').upper()}")
        print(f"  Confidence: {consensus.get('confidence_score', 0)}%")
        print(f"  Method: {consensus.get('consensus_metadata', {}).get('method', 'unknown')}")
        print(f"  Rounds Used: {consensus.get('consensus_metadata', {}).get('rounds_used', 0)}")
        if consensus.get('consensus_metadata', {}).get('method') == 'weighted_voting':
            voting_scores = consensus.get('consensus_metadata', {}).get('voting_scores', {})
            print(f"  Voting Scores: {voting_scores}")

def main():
    """Main function for multi-model analysis."""
    # Example usage with a transaction directory
    tx_dir = "output/1/0xff8e9226091d513fc936ecc670030eba03f34dbe60cd012122bd18be44248d32"
    
    # Define models to test
    models = [
        "gpt-4o-mini",      # OpenAI's latest model
        "gpt-3.5-turbo",    # OpenAI's faster model
        "gpt-4o"    # Anthropic's fast model
    ]
    
    # Run multi-model analysis
    results = run_multi_model_analysis(tx_dir, models)
    
    if results:
        # Load and display comparison report
        comparison_path = os.path.join(tx_dir, "model_comparison_report.json")
        if os.path.exists(comparison_path):
            with open(comparison_path, 'r', encoding='utf-8') as f:
                comparison = json.load(f)
            display_comparison_summary(comparison)
        
        print(f"\nAll reports saved to: {tx_dir}")
        print("Files generated:")
        for model in models:
            report_file = f"security_analysis_{model.replace('-', '_')}.json"
            print(f"  - {report_file}")
        print("  - model_comparison_report.json")
        print("  - consensus_final_report.json")
    else:
        print("No analysis results generated.")

if __name__ == "__main__":
    main() 