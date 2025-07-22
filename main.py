#!/usr/bin/env python3
"""
Unified Ethereum Transaction Analysis Tool
Comprehensive tool that integrates transaction analysis, security database checking, 
multi-model LLM analysis and consensus checking
"""

import os
import sys
import json
import time
import subprocess
from typing import Dict, Any, List

def check_dependencies():
    """Check if required dependencies are installed"""
    missing_deps = []
    
    try:
        import pandas
    except ImportError:
        missing_deps.append("pandas")
    
    try:
        import web3
    except ImportError:
        missing_deps.append("web3")
    
    try:
        import openai
    except ImportError:
        missing_deps.append("openai")
    
    try:
        import requests
    except ImportError:
        missing_deps.append("requests")
    
    if missing_deps:
        print("Error: Missing required dependencies:")
        for dep in missing_deps:
            print(f"  - {dep}")
        print("\nPlease install dependencies with:")
        print("  pip install -r requirements.txt")
        print("\nOr install manually:")
        print(f"  pip install {' '.join(missing_deps)}")
        sys.exit(1)

# Check dependencies first
check_dependencies()

# Import necessary modules from src package
from src.transaction_analyzer import run_transaction_analysis as run_transaction_analysis_from_main
from src.security_checker import analyze_transaction_output
from src.llm_analyzer import run_multi_model_analysis
from src.consensus_engine import ConsensusChecker


def print_step_header(step_num: int, total_steps: int, title: str):
    """Print step header"""
    print(f"\n[{step_num}/{total_steps}] {title}")
    print("=" * 60)


def print_substep(substep: str, completed: bool = False):
    """Print substep"""
    if completed:
        print(f"  ✓ {substep}")
    else:
        print(f"  - {substep}")


def run_transaction_analysis(tx_hash: str) -> bool:
    """Run transaction analysis"""
    print_step_header(1, 4, "TRANSACTION ANALYSIS")
    
    try:
        print_substep("Transaction inspection and trace extraction...", False)
        print_substep("Contract source code fetching and decompilation...", False)
        print_substep("Function call analysis and code extraction...", False)
        print_substep("Asset flow tracking and token transfer analysis...", False)
        print_substep("Gas usage analysis and efficiency calculation...", False)
        print_substep("State changes tracking and storage analysis...", False)
        
        # Execute transaction analysis
        result = run_transaction_analysis_from_main(tx_hash)
        
        if result:
            print_substep("Transaction inspection and trace extraction...", True)
            print_substep("Contract source code fetching and decompilation...", True)
            print_substep("Function call analysis and code extraction...", True)
            print_substep("Asset flow tracking and token transfer analysis...", True)
            print_substep("Gas usage analysis and efficiency calculation...", True)
            print_substep("State changes tracking and storage analysis...", True)
            print("\n✓ Transaction analysis completed successfully")
            return True
        else:
            print("\n✗ Transaction analysis failed")
            return False
            
    except Exception as e:
        print(f"\n✗ Error during transaction analysis: {e}")
        return False


def run_security_check(tx_hash: str) -> bool:
    """Run security database check"""
    print_step_header(2, 4, "SECURITY DATABASE CHECK")
    
    try:
        print_substep("Malicious address database checking...", False)
        print_substep("Suspicious code pattern identification...", False)
        
        # Check for optional files and offer interactive input
        tx_dir = f"output/1/{tx_hash.lower()}"
        urls_file = os.path.join(tx_dir, "url.txt")
        js_file = os.path.join(tx_dir, "js.txt")
        
        has_urls = os.path.exists(urls_file)
        has_js = os.path.exists(js_file)
        
        # Offer interactive URL input
        if not has_urls:
            print("\n  URL Analysis:")
            print("  Enter URLs to analyze (one per line, press Enter twice to finish):")
            urls = []
            while True:
                url = input("  URL: ").strip()
                if not url:
                    break
                urls.append(url)
            
            if urls:
                # Create url.txt file
                os.makedirs(tx_dir, exist_ok=True)
                with open(urls_file, 'w', encoding='utf-8') as f:
                    for url in urls:
                        f.write(url + '\n')
                has_urls = True
                print(f"  ✓ Saved {len(urls)} URLs to {urls_file}")
        
        # Offer interactive JavaScript input
        if not has_js:
            print("\n  JavaScript Analysis:")
            print("  Enter JavaScript code to analyze (press Enter twice to finish):")
            js_lines = []
            while True:
                js_line = input("  JS: ").strip()
                if not js_line:
                    break
                js_lines.append(js_line)
            
            if js_lines:
                # Create js.txt file
                os.makedirs(tx_dir, exist_ok=True)
                with open(js_file, 'w', encoding='utf-8') as f:
                    for line in js_lines:
                        f.write(line + '\n')
                has_js = True
                print(f"  ✓ Saved JavaScript code to {js_file}")
        
        if has_urls:
            print_substep("URL and domain reputation analysis...", False)
        if has_js:
            print_substep("JavaScript code security pattern detection...", False)
        
        # Execute security check
        analyze_transaction_output(tx_hash)
        
        print_substep("Malicious address database checking...", True)
        print_substep("Suspicious code pattern identification...", True)
        
        if has_urls:
            print_substep("URL and domain reputation analysis...", True)
        if has_js:
            print_substep("JavaScript code security pattern detection...", True)
        
        # Show optional file status
        if not has_urls:
            print(f"  ⚠ URL analysis skipped (no URLs provided)")
        if not has_js:
            print(f"  ⚠ JavaScript analysis skipped (no JavaScript provided)")
        
        print("\n✓ Security database check completed")
        return True
        
    except Exception as e:
        print(f"\n✗ Security check failed: {e}")
        return False


def run_llm_analysis(tx_hash: str) -> Dict[str, Any]:
    """Run multi-model LLM analysis"""
    print_step_header(3, 4, "MULTI-MODEL LLM ANALYSIS")
    
    tx_dir = f"output/1/{tx_hash.lower()}"
    
    if not os.path.exists(tx_dir):
        print(f"✗ Transaction directory not found: {tx_dir}")
        return {}
    
    try:
        print_substep("Data preprocessing and token limit management...", False)
        print_substep("GPT-4o-mini model analysis...", False)
        print_substep("GPT-3.5-turbo model analysis...", False)
        print_substep("GPT-4o model analysis...", False)
        print_substep("Consensus algorithm with self-reflection...", False)
        print_substep("Weighted voting and final decision...", False)
        
        # Execute multi-model analysis
        results = run_multi_model_analysis(tx_dir)
        
        if results:
            print_substep("Data preprocessing and token limit management...", True)
            print_substep("GPT-4o-mini model analysis...", True)
            print_substep("GPT-3.5-turbo model analysis...", True)
            print_substep("GPT-4o model analysis...", True)
            print_substep("Consensus algorithm with self-reflection...", True)
            print_substep("Weighted voting and final decision...", True)
            print("\n✓ Multi-model analysis completed")
            return results
        else:
            print("\n✗ Multi-model analysis failed")
            return {}
            
    except Exception as e:
        print(f"\n✗ Error during LLM analysis: {e}")
        return {}


def analyze_transaction_type(tx_hash: str) -> str:
    """Analyze transaction type"""
    try:
        # This can be enhanced to determine type based on transaction data
        # For now, return generic type
        return "Smart Contract Interaction"
    except:
        return "Unknown"


def generate_final_report(tx_hash: str, llm_results: Dict[str, Any]) -> Dict[str, Any]:
    """Generate final comprehensive report"""
    print_step_header(4, 4, "FINAL REPORT GENERATION")
    
    tx_dir = f"output/1/{tx_hash.lower()}"
    
    try:
        print_substep("Loading consensus results and model comparisons...", False)
        
        # Load consensus results
        consensus_path = os.path.join(tx_dir, "consensus_final_report.json")
        consensus_result = {}
        if os.path.exists(consensus_path):
            with open(consensus_path, 'r', encoding='utf-8') as f:
                consensus_result = json.load(f)
        
        print_substep("Loading consensus results and model comparisons...", True)
        print_substep("Analyzing transaction type and classification...", False)
        
        # Determine transaction type
        tx_type = analyze_transaction_type(tx_hash)
        
        print_substep("Analyzing transaction type and classification...", True)
        print_substep("Synthesizing security assessment and recommendations...", False)
        
        # Generate final report
        final_report = {
            "transaction_info": {
                "tx_hash": tx_hash,
                "transaction_type": tx_type,
                "analysis_timestamp": time.strftime("%Y-%m-%d %H:%M:%S")
            },
            "security_assessment": {
                "risk_level": consensus_result.get("risk_level", "unknown"),
                "confidence_score": consensus_result.get("confidence_score", 0),
                "consensus_method": consensus_result.get("consensus_metadata", {}).get("method", "unknown")
            },
            "transaction_analysis": {
                "explanation": consensus_result.get("explanation", ""),
                "scoring_criteria": consensus_result.get("custom_scoring_criteria", "")
            },
            "recommendations": consensus_result.get("recommendations", [])
        }
        
        print_substep("Synthesizing security assessment and recommendations...", True)
        print_substep("Saving comprehensive final report...", False)
        
        # Save final report
        final_report_path = os.path.join(tx_dir, "final_comprehensive_report.json")
        with open(final_report_path, 'w', encoding='utf-8') as f:
            json.dump(final_report, f, indent=2, ensure_ascii=False)
        
        print_substep("Saving comprehensive final report...", True)
        print(f"\n✓ Final report generated: {final_report_path}")
        
        # Display final result summary
        print("\n" + "="*60)
        print("FINAL ANALYSIS SUMMARY")
        print("="*60)
        print(f"Transaction Hash: {tx_hash}")
        print(f"Transaction Type: {tx_type}")
        print(f"Risk Level: {final_report['security_assessment']['risk_level']}")
        print(f"Confidence Score: {final_report['security_assessment']['confidence_score']}")
        print(f"Consensus Method: {final_report['security_assessment']['consensus_method']}")
        
        if final_report['recommendations']:
            print("\nKey Recommendations:")
            for i, rec in enumerate(final_report['recommendations'][:3], 1):
                print(f"  {i}. {rec}")
        
        return final_report
        
    except Exception as e:
        print(f"\n✗ Error generating final report: {e}")
        return {}


def main():
    """Main function"""
    if len(sys.argv) != 2:
        print("Usage: python3 main.py <transaction_hash>")
        print("Example: python3 main.py 0xff8e9226091d513fc936ecc670030eba03f34dbe60cd012122bd18be44248d32")
        print("\nInteractive Features:")
        print("  - Program will prompt for URLs and JavaScript code if not found")
        print("  - Enter URLs one per line, press Enter twice to finish")
        print("  - Enter JavaScript code line by line, press Enter twice to finish")
        print("\nOptional: Pre-create these files in output/1/<tx_hash>/:")
        print("  url.txt  - One URL per line for domain reputation analysis")
        print("  js.txt   - JavaScript code for security pattern detection")
        sys.exit(1)
    
    tx_hash = sys.argv[1]
    
    print("UNIFIED ETHEREUM TRANSACTION ANALYSIS")
    print("="*60)
    print(f"Analyzing transaction: {tx_hash}")
    print(f"Start time: {time.strftime('%Y-%m-%d %H:%M:%S')}")
    
    # Step 1: Transaction analysis
    if not run_transaction_analysis(tx_hash):
        print("\n✗ Analysis failed at transaction analysis step")
        sys.exit(1)
    
    # Step 2: Security database check
    if not run_security_check(tx_hash):
        print("\n✗ Analysis failed at security check step")
        sys.exit(1)
    
    # Step 3: Multi-model LLM analysis
    llm_results = run_llm_analysis(tx_hash)
    if not llm_results:
        print("\n✗ Analysis failed at LLM analysis step")
        sys.exit(1)
    
    # Step 4: Generate final report
    final_report = generate_final_report(tx_hash, llm_results)
    if not final_report:
        print("\n✗ Analysis failed at final report generation step")
        sys.exit(1)
    
    print(f"\nAnalysis completed successfully!")
    print(f"End time: {time.strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"Results saved in: output/1/{tx_hash.lower()}/")


if __name__ == "__main__":
    main() 