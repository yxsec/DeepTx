#!/usr/bin/env python3
"""
Comprehensive Ethereum Transaction Analysis Tool
Combines transaction analysis and security checking in one workflow
"""

import os
import json
import re
import time
import pandas as pd
from pathlib import Path
from collections import defaultdict
from web3 import Web3
from datetime import datetime

# Import modules
from .heimdall_client import inspect_transaction
from .contract_fetcher import ContractDecompilerTool, ContractFetcher

def run_transaction_analysis(tx_hash):
    """Run comprehensive transaction analysis (analyze.py functionality)"""
    
    # === Configurations ===
    TX_ID = tx_hash.lower()
    TRACE_DIR = os.path.join("output", "1", TX_ID)
    TRACE_PATH = os.path.join(TRACE_DIR, "decoded_trace.json")
    TRACE_TXT_PATH = os.path.join(TRACE_DIR, "trace.txt")
    CONTRACTS_DIR = "contracts"
    OUTPUT_CODE_PATH = os.path.join(TRACE_DIR, "code.txt")
    ASSET_FLOWS_PATH = os.path.join(TRACE_DIR, "asset_flows.csv")
    GAS_USAGE_PATH = os.path.join(TRACE_DIR, "gas_usage.csv")
    STATE_CHANGES_PATH = os.path.join(TRACE_DIR, "state_changes.csv")

    api_key = os.environ.get("HEIMDALL_API_KEY")
    if not api_key:
        raise ValueError("HEIMDALL_API_KEY environment variable is required")
    
    rpc_url = os.environ.get("RPC_URL", "https://ethereum.therpc.io")
    etherscan_api = os.environ.get("ETHERSCAN_API_KEY")
    if not etherscan_api:
        raise ValueError("ETHERSCAN_API_KEY environment variable is required")

    # Initialize Web3
    w3 = Web3(Web3.HTTPProvider(rpc_url))

    # === Step 1: Heimdall Inspect ===
    inspect_transaction(tx_hash, api_key=api_key, rpc_url=rpc_url)

    # === Step 2: Clean Trace File ===
    def clean_trace_file(trace_path):
        if not os.path.exists(trace_path):
            return
        with open(trace_path, "r", encoding="utf-8") as f:
            lines = f.readlines()
        start_index = next((i for i, line in enumerate(lines) if "heimdall::inspect" in line), None)
        if start_index is not None:
            with open(trace_path, "w", encoding="utf-8") as f:
                f.writelines(lines[start_index:])

    clean_trace_file(TRACE_TXT_PATH)

    # === Step 3: Load Trace and Collect Addresses ===
    if not os.path.exists(TRACE_PATH):
        print(f"Error: decoded_trace.json not found")
        return False

    with open(TRACE_PATH, "r", encoding="utf-8") as f:
        trace_data = json.load(f)

    involved_addresses = set()
    def collect_addresses(trace_item):
        action = trace_item.get("action", {})
        if "from" in action:
            involved_addresses.add(action["from"].lower())
        if "to" in action:
            involved_addresses.add(action["to"].lower())
        for sub in trace_item.get("subtraces", []):
            collect_addresses(sub)

    collect_addresses(trace_data)
    print(f"Found {len(involved_addresses)} contract addresses")

    # === Step 4: Fetch Contracts ===
    fetcher = ContractFetcher(api_key=etherscan_api)
    tool = ContractDecompilerTool(fetcher)
    for addr in sorted(involved_addresses):
        try:
            tool.run(addr)
            time.sleep(1.5)
        except Exception as e:
            print(f"Failed to process {addr}: {e}")

    # === Step 5: Extract Functions ===
    called_functions = set()
    def collect_function_calls(trace_item):
        action = trace_item.get("action", {})
        to_addr = action.get("to", "").lower().replace("0x", "")
        func_info = action.get("resolvedFunction")
        selector = action.get("functionSelector")
        if func_info and "name" in func_info:
            called_functions.add((to_addr, func_info["name"]))
        elif selector:
            called_functions.add((to_addr, f"Unresolved_{selector}"))
        for sub in trace_item.get("subtraces", []):
            collect_function_calls(sub)

    collect_function_calls(trace_data)

    # === Step 6: Extract Function Code ===
    Path(os.path.dirname(OUTPUT_CODE_PATH)).mkdir(parents=True, exist_ok=True)
    written_funcs = set()
    with open(OUTPUT_CODE_PATH, "w", encoding="utf-8") as output_file:
        for addr, func in sorted(called_functions):
            if (addr, func) in written_funcs:
                continue
            contract_path = os.path.join(CONTRACTS_DIR, addr)
            if not os.path.isdir(contract_path):
                output_file.write(f"\n// Contract directory not found for address {addr}\n")
                continue
            matched = False
            for file in os.listdir(contract_path):
                if not file.endswith(".sol"):
                    continue
                file_path = os.path.join(contract_path, file)
                with open(file_path, "r", encoding="utf-8") as f:
                    code = f.read()
                pattern = rf"(function\s+{re.escape(func)}\s*\(.*?\)[\s\S]*?\{{[\s\S]*?\n\}})"
                matches = re.findall(pattern, code, re.IGNORECASE)
                if matches:
                    output_file.write(f"\n// Function from {addr} - {func} in {file}\n")
                    output_file.write(matches[0])
                    output_file.write("\n")
                    written_funcs.add((addr, func))
                    matched = True
                    break
            if not matched:
                output_file.write(f"\n// Function {func} not found in {addr}\n")
                written_funcs.add((addr, func))

    # === Step 7: Asset Flow Analysis ===
    def collect_transfers(trace_item, transfers):

        action = trace_item.get("action", {})
        value_hex = action.get("value", "0x0")
        if value_hex not in ("0x", "", "0x0"):
            try:
                value = int(value_hex, 16)
            except Exception:
                value = 0
            if value > 0:
                from_addr = action.get("from", "")
                to_addr = action.get("to", "")
                if from_addr and to_addr:
                    transfers.append({
                        "token_address": "ETH",
                        "from": Web3.to_checksum_address(from_addr),
                        "to": Web3.to_checksum_address(to_addr),
                        "value": value
                    })

        for log in trace_item.get("logs", []):
            topics = log.get("topics", [])
            if len(topics) >= 3 and topics[0].lower().startswith("0xddf252ad"):
                from_addr = "0x" + topics[1][-40:]
                to_addr = "0x" + topics[2][-40:]
                data_hex = log.get("data", "0x0")
                if data_hex == "0x" or data_hex == "":
                    value = 0
                else:
                    try:
                        value = int(data_hex, 16)
                    except Exception:
                        value = 0
                token = log["address"].lower()
                transfers.append({
                    "token_address": token,
                    "from": Web3.to_checksum_address(from_addr),
                    "to": Web3.to_checksum_address(to_addr),
                    "value": value
                })
        for sub in trace_item.get("subtraces", []):
            collect_transfers(sub, transfers)

    transfers = []
    collect_transfers(trace_data, transfers)

    # Get token metadata
    token_meta = {}
    abi = [
        {"constant": True, "inputs": [], "name": "name", "outputs": [{"name": "", "type": "string"}], "type": "function"},
        {"constant": True, "inputs": [], "name": "symbol", "outputs": [{"name": "", "type": "string"}], "type": "function"},
        {"constant": True, "inputs": [], "name": "decimals", "outputs": [{"name": "", "type": "uint8"}], "type": "function"}
    ]

    def get_token_info(addr):
        if addr in token_meta:
            return token_meta[addr]
        contract = w3.eth.contract(address=Web3.to_checksum_address(addr), abi=abi)
        try:
            name = contract.functions.name().call()
        except:
            name = "N/A"
        try:
            symbol = contract.functions.symbol().call()
        except:
            symbol = "N/A"
        try:
            decimals = contract.functions.decimals().call()
        except:
            decimals = 18
        token_meta[addr] = {"name": name, "symbol": symbol, "decimals": decimals}
        return token_meta[addr]

    # Enrich transfers with token metadata
    for tx in transfers:
        if tx["token_address"] == "ETH":
            meta = {"name": "Ether", "symbol": "ETH", "decimals": 18}
        else:
            meta = get_token_info(tx["token_address"])
        tx.update(meta)
        tx["value_normalized"] = tx["value"] / (10 ** meta["decimals"])


    # Save asset flows
    if transfers:
        df_assets = pd.DataFrame(transfers)
        df_assets = df_assets[["token_address", "name", "symbol", "from", "to", "value_normalized"]]
        df_assets.to_csv(ASSET_FLOWS_PATH, index=False)

    # === Step 8: Gas Usage Analysis ===
    tx = w3.eth.get_transaction(tx_hash)
    receipt = w3.eth.get_transaction_receipt(tx_hash)
    block = w3.eth.get_block(tx.blockNumber)

    tx_gas_price = tx.gasPrice
    block_base_fee = getattr(block, "baseFeePerGas", None)

    gas_records = []
    def hex_to_int(h):
        try:
            return int(h, 16)
        except:
            return None

    def collect_gas_usage(item, depth=0):
        action = item.get("action", {})
        result = item.get("result", {})
        func_info = action.get("resolvedFunction", {})
        selector = action.get("functionSelector")
        fn_name = func_info.get("name") if func_info else f"Unresolved_{selector}"
        gas_alloc = hex_to_int(action.get("gas", "0x0"))
        gas_used = hex_to_int(result.get("gasUsed", "0x0"))
        gas_remain = (gas_alloc - gas_used) if gas_alloc is not None and gas_used is not None else None
        gas_records.append({
            "depth": depth,
            "from": action.get("from", "").lower(),
            "to": action.get("to", "").lower(),
            "call_type": action.get("callType", ""),
            "function": fn_name,
            "gas_allocated": gas_alloc,
            "gas_used": gas_used,
            "gas_remaining": gas_remain,
            "tx_gas_price": tx_gas_price,
            "block_base_fee": block_base_fee
        })
        for sub in item.get("subtraces", []):
            collect_gas_usage(sub, depth+1)

    collect_gas_usage(trace_data)

    df_gas = pd.DataFrame(gas_records)
    df_gas = df_gas[[
        "depth", "from", "to", "call_type", "function",
        "gas_allocated", "gas_used", "gas_remaining",
        "tx_gas_price", "block_base_fee"
    ]]
    df_gas.to_csv(GAS_USAGE_PATH, index=False)

    # === Step 9: State Changes Analysis ===
    state_changes = defaultdict(list)

    def extract_state_diffs(trace_item):
        if "action" in trace_item:
            contract_address = trace_item["action"].get("to", "").lower()
            if "diff" in trace_item and isinstance(trace_item["diff"], list):
                for change in trace_item["diff"]:
                    key = change.get("key")
                    val = change.get("val")
                    if key and val:
                        state_changes[contract_address].append((key, val))
        for sub in trace_item.get("subtraces", []):
            extract_state_diffs(sub)

    extract_state_diffs(trace_data)

    state_rows = []
    for contract, changes in state_changes.items():
        for key, val in changes:
            state_rows.append({
                "Contract": contract,
                "Storage Slot": key,
                "New Value": val
            })

    if state_rows:
        df_state = pd.DataFrame(state_rows)
        df_state.to_csv(STATE_CHANGES_PATH, index=False)

    print(f"Analysis complete. Generated files:")
    print(f"  - decoded_trace.json: Transaction trace")
    print(f"  - code.txt: Function source code")
    print(f"  - asset_flows.csv: Token transfers ({len(transfers)} transfers)")
    print(f"  - gas_usage.csv: Gas analysis ({len(gas_records)} calls)")
    print(f"  - state_changes.csv: State changes ({len(state_rows)} changes)")
    
    return True


def ask_for_optional_files(tx_hash):
    """Ask user if they want to add optional files for security analysis"""
    
    print(f"\n[2/3] OPTIONAL SECURITY FILES")
    print(f"="*50)
    
    output_dir = f"output/1/{tx_hash.lower()}"
    url_file = os.path.join(output_dir, "url.txt")
    js_file = os.path.join(output_dir, "js.txt")
    
    print("You can optionally add files for enhanced security analysis:")
    print(f"  {url_file} - One URL per line for domain checking")
    print(f"  {js_file} - JavaScript code for pattern analysis")
    
    while True:
        choice = input("\nDo you want to add optional files? (y/n/skip): ").strip().lower()
        
        if choice in ['n', 'no', 'skip', '']:
            print("Skipping optional files...")
            return
        elif choice in ['y', 'yes']:
            break
        else:
            print("Please enter 'y' for yes or 'n' for no")
    
    # URL file
    while True:
        add_urls = input("Add URL file? (y/n): ").strip().lower()
        if add_urls in ['y', 'yes']:
            print(f"\nCreate {url_file} with URLs (one per line):")
            print("Enter URLs (press Enter twice to finish):")
            urls = []
            while True:
                url = input("URL: ").strip()
                if not url:
                    break
                urls.append(url)
            
            if urls:
                with open(url_file, 'w', encoding='utf-8') as f:
                    f.write('\n'.join(urls))
                print(f"Created {url_file} with {len(urls)} URLs")
            break
        elif add_urls in ['n', 'no', '']:
            break
    
    # JavaScript file
    while True:
        add_js = input("Add JavaScript file? (y/n): ").strip().lower()
        if add_js in ['y', 'yes']:
            print(f"\nCreate {js_file}:")
            print("Paste JavaScript code (press Ctrl+D when finished):")
            try:
                import sys
                js_content = sys.stdin.read()
                if js_content.strip():
                    with open(js_file, 'w', encoding='utf-8') as f:
                        f.write(js_content)
                    print(f"Created {js_file}")
            except:
                print("Error reading JavaScript content")
            break
        elif add_js in ['n', 'no', '']:
            break


def run_security_analysis(tx_hash):
    """Run security analysis (test_query.py functionality)"""
    
    print(f"\n[3/3] SECURITY ANALYSIS")
    print(f"="*50)
    
    from .security_checker import analyze_transaction_output
    analyze_transaction_output(tx_hash)


def main():
    """Main execution flow"""
    
    print("COMPREHENSIVE ETHEREUM TRANSACTION ANALYSIS")
    print("="*50)
    
    if len(os.sys.argv) != 2:
        print("Usage:")
        print("  python main.py <tx_hash>")
        print("\nExample:")
        print("  python main.py 0xff8e9226091d513fc936ecc670030eba03f34dbe60cd012122bd18be44248d32")
        return
    
    tx_hash = os.sys.argv[1]
    
    try:
        # Step 1: Run transaction analysis
        success = run_transaction_analysis(tx_hash)
        if not success:
            print("Transaction analysis failed")
            return
        
        # Step 2: Ask for optional files
        ask_for_optional_files(tx_hash)
        
        # Step 3: Run security analysis
        run_security_analysis(tx_hash)
        
        print(f"\n" + "="*50)
        print("ANALYSIS COMPLETE")
        print(f"Output directory: output/1/{tx_hash.lower()}")
        print("="*50)
        
    except KeyboardInterrupt:
        print("\nAnalysis interrupted by user")
    except Exception as e:
        print(f"Error during analysis: {e}")


if __name__ == "__main__":
    main() 