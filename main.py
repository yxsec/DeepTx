import os
import sys
import json
import time
import pandas as pd
import requests
from typing import Dict, Any, List
from dotenv import load_dotenv, find_dotenv
import argparse


load_dotenv(find_dotenv(filename=".env", usecwd=True), override=False)

def _parse_bool_flag(s: str) -> bool:
    t = str(s).strip().lower()
    if t in {"1", "true", "yes", "y", "on"}:
        return True
    if t in {"0", "false", "no", "n", "off"}:
        return False
    raise argparse.ArgumentTypeError(f"Invalid boolean value for --simulation: {s}")

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

from src.transaction_analyzer import run_transaction_analysis as run_transaction_analysis_from_main
from src.transaction_analyzer import extract_called_functions, fetch_contracts, extract_function_code 
from src.security_checker import analyze_transaction_output
from src.llm_analyzer import run_multi_model_analysis
from src.consensus_engine import ConsensusChecker
from src.simulation import simulation


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


def run_transaction_analysis(tx_hash: str, tx_dir: str, chain_id: str) -> bool:
    """Run transaction analysis"""
    print_step_header(1, 4, "TRANSACTION ANALYSIS")
    
    try:
        print_substep("Transaction inspection...", False)
        print_substep("Call trace extraction and gas usage analysis...", False)
        print_substep("Contract source code fetching and decompilation...", False)
        print_substep("Code extraction...", False)
        print_substep("Asset flow tracking and token transfer analysis...", False)
        print_substep("State changes tracking and storage analysis...", False)
        
        # Execute transaction analysis
        result = run_transaction_analysis_from_main(tx_hash, tx_dir, chain_id)
        
        if result:
            print_substep("Transaction inspection...", True)
            print_substep("Call trace extraction and gas usage analysis...", True)
            print_substep("Contract source code fetching and decompilation...", True)
            print_substep("Code extraction...", True)
            print_substep("Asset flow tracking and token transfer analysis...", True)
            print_substep("State changes tracking and storage analysis...", True)
            print("\n✓ Transaction analysis completed successfully")
            return True
        else:
            print("\n✗ Transaction analysis failed")
            return False
            
    except Exception as e:
        print(f"\n✗ Error during transaction analysis: {e}")
        return False


def run_security_check(tx_hash: str, tx_dir: str) -> bool:
    """Run security database check"""
    print_step_header(2, 4, "SECURITY DATABASE CHECK")
    
    try:
        print_substep("Malicious address database checking...", False)
        print_substep("Suspicious code pattern identification...", False)
        
        # Check for optional files and offer interactive input
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
        analyze_transaction_output(tx_hash, tx_dir)
        
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


def run_llm_analysis(tx_hash: str, tx_dir: str) -> Dict[str, Any]:
    """Run multi-model LLM analysis"""
    print_step_header(3, 4, "MULTI-MODEL LLM ANALYSIS")
    
    if not os.path.exists(tx_dir):
        print(f"✗ Transaction directory not found: {tx_dir}")
        return {}
    
    try:
        print_substep("Data preprocessing and token limit management...", False)
        print_substep("Consensus algorithm with self-reflection...", False)
        print_substep("Weighted voting and final decision...", False)
        
        # Execute multi-model analysis
        results = run_multi_model_analysis(tx_dir)
        
        if results:
            print_substep("Data preprocessing and token limit management...", True)
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


def analyze_transaction_type(tx_dir: str) -> str:
    """Analyze transaction type with detailed contract creation detection"""
    try:
        call_trace_path = os.path.join(tx_dir, "call_trace.csv")
        df_call_trace = pd.read_csv(call_trace_path)
        
        if df_call_trace.empty:
            return "User Transfer"
    
        first_row = df_call_trace.iloc[0]
        is_contract_creation = False
        
        if pd.isna(first_row.get('to')) or first_row.get('to') in ['', '0x', '0x0', None]:
            is_contract_creation = True
        
        if 'call_type' in first_row and pd.notna(first_row['call_type']):
            if any(keyword in str(first_row['call_type']).lower() for keyword in ['create', 'delegate', 'init']):
                is_contract_creation = True
        
        if 'input' in first_row and pd.notna(first_row['input']):
            if len(str(first_row['input'])) > 2000:
                is_contract_creation = True
        
        if is_contract_creation:
            return "Contract Creation"
        
        has_contract_calls = any(df_call_trace['depth'] > 0)
        has_function_calls = any(df_call_trace['function'].notna() & (df_call_trace['function'] != ""))
        
        if has_contract_calls or has_function_calls:
            return "Smart Contract Interaction"
        else:
            return "User Transfer"
            
    except Exception as e:
        print(f"Error analyzing transaction type: {e}")
        return "Unknown"


def generate_final_report(tx_hash: str, tx_dir: str, llm_results: Dict[str, Any]) -> Dict[str, Any]:
    """Generate final comprehensive report"""
    print_step_header(4, 4, "FINAL REPORT GENERATION")
    
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
        tx_type = analyze_transaction_type(tx_dir)
        
        print_substep("Analyzing transaction type and classification...", True)
        print_substep("Synthesizing security assessment and recommendations...", False)

        if tx_type == "Contract Creation":
            explanation = "Contract creation transaction - deploying new smart contract to the blockchain"
        else:
            explanation = consensus_result.get("explanation", "")
        
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
                "explanation": explanation,
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
        print(f"Transaction Description: {final_report['transaction_analysis']['explanation']}")
        
        if final_report['recommendations']:
            print("\nKey Recommendations:")
            for i, rec in enumerate(final_report['recommendations'][:3], 1):
                print(f"  {i}. {rec}")
        
        return final_report
        
    except Exception as e:
        print(f"\n✗ Error generating final report: {e}")
        return {}
    
def get_chain_id(rpc_url: str) -> str:
    payload = {
        "jsonrpc": "2.0",
        "method": "eth_chainId",
        "params": [],
        "id": 1
    }
    headers = {"Content-Type": "application/json"}
    response = requests.post(rpc_url, data=json.dumps(payload), headers=headers)

    if response.status_code == 200:
        result = response.json()
        chain_id_hex = result["result"]
        return str(int(chain_id_hex, 16))
    else:
        raise RuntimeError(f"Error fetching chain_id: {response.status_code} {response.text}")

def simulation_report():
    print("\nSIMULATION")
    print("=" * 60)
    try:
        tx_dir = simulation()  
    except Exception as e:
        print(f"\n✗ Simulation execution failed: {e}")
        sys.exit(1)

    base_output = "output"
    if not os.path.exists(base_output):
        print("No simulation output directory found.")
        sys.exit(1)

    tx_hash = os.path.basename(tx_dir)

    chain_id_str = os.path.basename(os.path.dirname(tx_dir))
    try:
        chain_id = int(chain_id_str)
    except Exception:
        chain_id = chain_id_str

    # === Step 1: Load involved addresses ===
    address_file = os.path.join(tx_dir, "address.txt")
    call_trace_path = os.path.join(tx_dir, "call_trace.csv")

    involved = set()
    if os.path.exists(address_file):
        try:
            with open(address_file, "r", encoding="utf-8") as f:
                for line in f:
                    addr = line.strip().lower()
                    if addr.startswith("0x") and len(addr) == 42:
                        involved.add(addr)
        except Exception as e:
            print(f"Failed to read address.txt: {e}")

    # === Step 2: Fetch contracts ===
    etherscan_api = os.environ.get("ETHERSCAN_API_KEY")

    contract_names = fetch_contracts(involved_addresses=involved, tx_dir=tx_dir, chain_id=chain_id, etherscan_api=etherscan_api)

    # === Step 3: Extract called functions ===
    if not os.path.exists(call_trace_path):
        print("call_trace.csv not found — skip function extraction")
    else:
        try:
            df_call_trace = pd.read_csv(call_trace_path)
            called_functions = extract_called_functions(df_call_trace)

            output_code_path = os.path.join(tx_dir, "code.txt")
            extract_function_code(
                called_functions=called_functions,
                contract_names=contract_names,
                tx_dir=tx_dir,
                output_code_path=output_code_path,
            )
            print(f"✓ code.txt generated at: {output_code_path}")
        except Exception as e:
            print(f"⚠ Error during function extraction: {e}")

    run_post_analysis(tx_hash, tx_dir)

    print(f"\nSimulation and Analysis completed successfully!")
    print(f"Results saved in: {tx_dir}")

def real():
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
    
    print("DeepTx V0.1")
    print("="*60)
    print(f"Analyzing transaction: {tx_hash}")
    print(f"Start time: {time.strftime('%Y-%m-%d %H:%M:%S')}")

    rpc_url = os.environ.get("RPC_URL", "https://ethereum.therpc.io")
    chain_id = get_chain_id(rpc_url)
    tx_dir = os.path.join("output", chain_id, tx_hash.lower())

    # Step 1: Transaction analysis
    if not run_transaction_analysis(tx_hash, tx_dir, chain_id):
        print("\n✗ Analysis failed at transaction analysis step")
        sys.exit(1)
    # Steps 2-4: Post-analysis (security check, LLM analysis, final report)
    run_post_analysis(tx_hash, tx_dir)

    
    print(f"\nAnalysis completed successfully!")
    print(f"End time: {time.strftime('%Y-%m-%d %H:%M:%S')}")
    print(f"Results saved in: output/1/{tx_hash.lower()}/")

def run_post_analysis(tx_id: str, tx_dir: str) -> dict:
    """
      1) Security DB check
      2) Multi-model LLM analysis
      3) Final comprehensive report
    if success return final_report(dict), else sys.exit(1).
    """
    # Step 2: Security database check
    if not run_security_check(tx_id, tx_dir):
        print("\n✗ Analysis failed at security check step")
        sys.exit(1)

    # Step 3: Multi-model LLM analysis
    llm_results = run_llm_analysis(tx_id, tx_dir)
    if not llm_results:
        print("\n✗ Analysis failed at LLM analysis step")
        sys.exit(1)

    # Step 4: Generate final report
    final_report = generate_final_report(tx_id, tx_dir, llm_results)
    if not final_report:
        print("\n✗ Analysis failed at final report generation step")
        sys.exit(1)

    return final_report

if __name__ == "__main__":
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument( "-s", "--simulation", type=_parse_bool_flag, default=False, help="1/true: run simulation() — simulate execution then analyze; 0/false: run main() — analyze a real on-chain transaction." )
    known, remaining = parser.parse_known_args()
    if known.simulation:
        simulation_report()
    else:
        real() 