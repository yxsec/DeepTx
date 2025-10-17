import os
import json
import re
import time
import pandas as pd
from pathlib import Path
from collections import defaultdict
from web3 import Web3

from .heimdall_client import inspect_transaction
from .contract_fetcher import ContractDecompilerTool, ContractFetcher

def extract_called_functions(df: pd.DataFrame):
    called = set()

    for _, row in df.iterrows():
        fn = row['function']
        to_addr = row['to']
        if isinstance(fn, str) and fn.strip() and isinstance(to_addr, str) and to_addr.strip():
            called.add((to_addr.lower().replace("0x", ""), fn.strip()))
    return called

def fetch_contracts(involved_addresses, tx_dir: str, chain_id: int, etherscan_api: str):
    addrs = sorted({str(addr).lower().replace("0x", "") for addr in involved_addresses if addr})

    fetcher = ContractFetcher(tx_dir, chain_id, api_key=etherscan_api)
    tool = ContractDecompilerTool(fetcher)
    contract_names = {}
    for addr_no0x in addrs:
        try:
            address_with_0x = "0x" + addr_no0x
            contract_name = tool.run(address_with_0x)
            if contract_name:
                contract_names[addr_no0x] = contract_name
        except Exception as e:
            print(f"Failed to process {address_with_0x}: {e}")
    return contract_names

def extract_function_code(
    called_functions: set,
    contract_names: dict,
    tx_dir: str,
    output_code_path: str,
) -> None:

    def _find_func_blocks(text: str, func: str):
        pattern = rf"(function\s+{re.escape(func)}\s*\(.*?\)[\s\S]*?\{{[\s\S]*?\n\}})"
        return re.findall(pattern, text, re.IGNORECASE)

    def _strip_comments(text: str) -> str:
        text = re.sub(r"/\*[\s\S]*?\*/", "", text)
        text = re.sub(r"//.*?$", "", text, flags=re.MULTILINE)
        text = re.sub(r"\n[ \t]*\n(?:[ \t]*\n)+", "\n\n", text)
        return text.strip() + "\n"

    Path(os.path.dirname(output_code_path)).mkdir(parents=True, exist_ok=True)

    buffer = []

    for addr_no0x, func in called_functions:
        contract_path = os.path.join(os.path.dirname(tx_dir), "contracts", addr_no0x)
        if not os.path.exists(contract_path):
            buffer.append(f"\n< Function {func} not found in {addr_no0x} >\n")
            continue

        main_contract_file = contract_names.get(addr_no0x, f"{addr_no0x}.sol")
        matched = False

        main_path = os.path.join(contract_path, main_contract_file)
        if os.path.exists(main_path):
            with open(main_path, "r", encoding="utf-8") as f:
                code = f.read()
            matches = _find_func_blocks(code, func)
            if matches:
                buffer.append(f"\n< Function from {addr_no0x} - {func} in {main_contract_file} >\n")
                buffer.append(matches[0])
                buffer.append("\n")
                matched = True

        if not matched:
            for file in os.listdir(contract_path):
                if not file.endswith(".sol") or (os.path.basename(main_path) == file):
                    continue
                file_path = os.path.join(contract_path, file)
                try:
                    with open(file_path, "r", encoding="utf-8") as f:
                        code = f.read()
                    matches = _find_func_blocks(code, func)
                except Exception:
                    matches = []
                if matches:
                    buffer.append(f"\n< Function from {addr_no0x} - {func} in {file} >\n")
                    buffer.append(matches[0])
                    buffer.append("\n")
                    matched = True
                    break

        if not matched:
            buffer.append(f"\n< Function {func} not found in {addr_no0x} >\n")

    clean = _strip_comments("".join(buffer))
    with open(output_code_path, "w", encoding="utf-8") as out_f:
        out_f.write(clean)


def run_transaction_analysis(tx_hash, tx_dir, chain_id):
    api_key = os.environ.get("TRANSPOSE_API_KEY")
    if not api_key:
        raise ValueError("TRANSPOSE_API_KEY environment variable is required")
    
    rpc_url = os.environ.get("RPC_URL", "https://ethereum.therpc.io")
    etherscan_api = os.environ.get("ETHERSCAN_API_KEY")
    if not etherscan_api:
        raise ValueError("ETHERSCAN_API_KEY environment variable is required")
    
    TRACE_PATH = os.path.join(tx_dir, "decoded_trace.json")
    OUTPUT_CODE_PATH = os.path.join(tx_dir, "code.txt")
    ASSET_FLOWS_PATH = os.path.join(tx_dir, "asset_flows.csv")
    CALL_TRACE_PATH = os.path.join(tx_dir, "call_trace.csv")
    GAS_INFO_PATH = os.path.join(tx_dir, "gas_info.txt")
    STATE_CHANGES_PATH = os.path.join(tx_dir, "state_changes.csv") 

    w3 = Web3(Web3.HTTPProvider(rpc_url))

    # === Step 1: Heimdall Inspect ===
    inspect_transaction(tx_hash=tx_hash, api_key=api_key, rpc_url=rpc_url, tx_dir=tx_dir)

    # === Step 2: Extract Gas Info ===
    if not os.path.exists(TRACE_PATH):
        print(f"Error: decoded_trace.json not found")
        return False

    with open(TRACE_PATH, "r", encoding="utf-8") as f:
        trace_data = json.load(f)

    tx = w3.eth.get_transaction(tx_hash)
    tx_gas_price = tx.gasPrice
    block_base_fee = None
    if chain_id == 1 and int(tx.blockNumber) > 12965000:
        block = w3.eth.get_block(tx.blockNumber)       
        block_base_fee = getattr(block, "baseFeePerGas")
    
    with open(GAS_INFO_PATH, "w", encoding="utf-8") as f:
        f.write(f"tx_gas_price: {tx_gas_price}\n")
        if block_base_fee is not None:
            f.write(f"block_base_fee: {block_base_fee}\n")
        else:
            pass

    # === Step 3: Call Trace and Gas Usage Analysis ===
    call_trace = []
    def hex_to_int(h):
        try:
            return int(h, 16)
        except:
            return None
    
    def collect_func_info(item, depth=0):
        if item is None:
            return
        action = item.get("action", {})
        result = item.get("result", {})
        func_info = action.get("resolvedFunction", {}) or {}
        fn_name = func_info.get("name", "") if func_info else ""
        gas_alloc = hex_to_int(action.get("gas", "0x0"))
        gas_used = hex_to_int(result.get("gasUsed", "0x0"))
        gas_remain = (gas_alloc - gas_used) if gas_alloc is not None and gas_used is not None else None
        call_type = (action.get("callType", "") or "").lower()
        call_trace.append({
            "depth": depth,
            "from": action.get("from", "").lower(),
            "to": action.get("to", "").lower(),
            "call_type": call_type,
            "function": fn_name,
            "gas_allocated": gas_alloc,
            "gas_used": gas_used,
            "gas_remaining": gas_remain
        })
        for sub in item.get("subtraces", []):
            collect_func_info(sub, depth+1)

    if trace_data:
        collect_func_info(item=trace_data)
    else:
        print("✗ No trace data to analyze")

    df_call_trace = pd.DataFrame(call_trace)
    df_call_trace = df_call_trace[[
        "depth", "from", "to", "call_type", "function",
        "gas_allocated", "gas_used", "gas_remaining"
    ]]
    df_call_trace.to_csv(CALL_TRACE_PATH, index=False)

    # === Step 4: Fetch Contracts ===   
    df_call_trace = pd.read_csv(CALL_TRACE_PATH)
    from_addresses = df_call_trace["from"].dropna()
    to_addresses = df_call_trace["to"].dropna()
    involved_addresses = set()
    involved_addresses.update(from_addresses.str.lower().unique())
    if not to_addresses.empty:
        involved_addresses.update(to_addresses.str.lower().unique())

    contract_names = fetch_contracts(involved_addresses=involved_addresses, tx_dir=tx_dir, chain_id=chain_id, etherscan_api=etherscan_api )
    # === Step 5: Extract Functions ===
    called_functions = extract_called_functions(df_call_trace)
    # === Step 6: Extract Function Code ===
    extract_function_code(called_functions=called_functions,contract_names=contract_names,tx_dir=tx_dir,output_code_path=OUTPUT_CODE_PATH)
    # === Step 7: Asset Flow Analysis ===
    def collect_transfers(trace_item, transfers):
        native_token_map = {
            1: "ETH",    # Ethereum Mainnet
            56: "BNB",   # BSC
            137: "POL",  # Polygon
            146: "S",    # Sonic
            1329: "Sei", # Sei
            314: "FIL",  # Filecoin
        }
        native_token_symbol = native_token_map.get(chain_id, "ETH")

        error_field = trace_item.get("error")
        has_error = error_field is not None and error_field != "None" and error_field != ""
        
        if has_error:
            return

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
                        "token_address": native_token_symbol,
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
            time.sleep(1)
        except:
            name = "N/A"
        try:
            symbol = contract.functions.symbol().call()
            time.sleep(1)
        except:
            symbol = "N/A"
            
        try:
            decimals = contract.functions.decimals().call()
            time.sleep(1)
        except:
            decimals = 18
        token_meta[addr] = {"name": name, "symbol": symbol, "decimals": decimals}
        return token_meta[addr]
    
    native_token_meta = {
        1: {"name": "Ether", "symbol": "ETH", "decimals": 18},
        56: {"name": "Binance Coin", "symbol": "BNB", "decimals": 18},
        137: {"name": "Polygon", "symbol": "POL", "decimals": 18},
        146: {"name": "Sonic", "symbol": "S", "decimals": 18},
        1329: {"name": "Sei", "symbol": "SEI", "decimals": 18},
        314: {"name": "Filecoin", "symbol": "FIL", "decimals": 18}
    }

    # Enrich transfers with token metadata
    for tx in transfers:
        if not tx["token_address"].startswith("0x"):
            meta_config = native_token_meta.get(chain_id, native_token_meta[1])
            meta = {
                "name": meta_config["name"],
                "symbol": meta_config["symbol"], 
                "decimals": meta_config["decimals"]
            }
        else:
            meta = get_token_info(tx["token_address"])
        tx.update(meta)
        tx["value"] = tx["value"] / (10 ** meta["decimals"])


    # Save asset flows
    if transfers:
        df_assets = pd.DataFrame(transfers)
        df_assets = df_assets[["token_address", "name", "symbol", "from", "to", "value"]]
        df_assets.to_csv(ASSET_FLOWS_PATH, index=False)

    # === Step 8: State Changes Analysis ===
    state_changes = defaultdict(list)

    def extract_state_diffs(trace_item):
        if "action" in trace_item:
            contract_address = trace_item["action"].get("to", "").lower()
            if not contract_address: 
                contract_address = trace_item["action"].get("from", "").lower()
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
    print(f"  - call_trace.csv: Call trace and Gas usage analysis ({len(call_trace)} calls)")
    print(f"  - asset_flows.csv: Token transfers ({len(transfers)} transfers)")
    print(f"  - state_changes.csv: State changes ({len(state_rows)} changes)")
    
    return True