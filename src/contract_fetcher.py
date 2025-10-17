import os
import requests
import json
import time
from .heimdall_client import decompile_bytecode

ETHERSCAN_API_KEY = os.environ.get("ETHERSCAN_API_KEY")
ETHERSCAN_API_URL = os.environ.get("ETHERSCAN_API_URL")
if not ETHERSCAN_API_KEY:
    raise ValueError("ETHERSCAN_API_KEY environment variable is required")

RPC_URL = os.environ.get("RPC_URL", "https://ethereum.therpc.io")


class ContractFetcher:
    def __init__(self, tx_dir, chain_id, api_key=ETHERSCAN_API_KEY, api_url=ETHERSCAN_API_URL):
        self.api_key = api_key
        self.api_url = api_url
        self.chain_id = chain_id
        self.tx_dir = tx_dir

    def fetch_contract_source(self, contract_address):
        url = (
            f"{self.api_url}?"
            f"chainid={self.chain_id}&module=contract&action=getsourcecode"
            f"&address={contract_address}&apikey={self.api_key}"
        )
        contract_info = {
            "source_code": None,
            "contract_name": None,
            "proxy": None
        }
        try:
            response = requests.get(url, timeout=10)
            time.sleep(1)
            
            if response.status_code == 200:
                data = response.json()
                status = data.get("status")
                result = data.get("result", [])
                
                if status == "1" and result:
                    source_info = result[0]
                    contract_info.update({
                        "source_code": source_info.get("SourceCode"),
                        "contract_name": source_info.get("ContractName"),
                        "proxy": source_info.get("Proxy")
                    })
                    
                    if not contract_info["source_code"]:
                        retry_response = requests.get(url, timeout=10)
                        time.sleep(1)
                        if retry_response.status_code == 200:
                            retry_data = retry_response.json()
                            retry_result = retry_data.get("result", [])
                            if retry_result and retry_result[0].get("SourceCode"):
                                contract_info["source_code"] = retry_result[0].get("SourceCode")
                                contract_info["contract_name"] = retry_result[0].get("ContractName")
                                contract_info["proxy"] = retry_result[0].get("Proxy")

        except Exception as e:
            print(f"Error fetching contract info for {contract_address}: {e}")
        return contract_info

    def fetch_contract_bytecode(self, contract_address):
        url = (
            f"{self.api_url}?"
            f"chainid={self.chain_id}&module=proxy&action=eth_getCode"
            f"&address={contract_address}&tag=latest&apikey={self.api_key}"
        )
        try:
            response = requests.get(url, timeout=10)
            time.sleep(1)
            if response.status_code == 200:
                data = response.json()
                bytecode = data.get("result")
                if bytecode and bytecode != "0x":
                    return bytecode
        except Exception as e:
            print(f"Error fetching bytecode for {contract_address}: {e}")
        return None


class ContractDecompilerTool:
    def __init__(self, fetcher: ContractFetcher):
        self.fetcher = fetcher

    def save_multi_file_source(self, contract_address, sources_dict):
        base_path = os.path.join(os.path.dirname(self.fetcher.tx_dir), "contracts", contract_address)
        os.makedirs(base_path, exist_ok=True)
        for filename, content_info in sources_dict.items():
            clean_filename = filename.replace("@", "").replace("/", "_")
            path = os.path.join(base_path, clean_filename)
            with open(path, "w", encoding="utf-8") as f:
                f.write(content_info["content"])
        print(f"[+] Saved multi-file source code to: {base_path}")

    def run(self, contract_address):
        contract_address = contract_address.lower().replace("0x", "")
        print(f"[*] Checking contract: 0x{contract_address}")

        output_dir = os.path.join(os.path.dirname(self.fetcher.tx_dir), "contracts", contract_address)
        if os.path.exists(output_dir):
            existing_files = [
                f for f in os.listdir(output_dir) 
                if f.endswith(".sol")
            ]
            if existing_files:
                print(f"[!] Contract 0x{contract_address} already downloaded. Skipping...")
                return None

        info = self.fetcher.fetch_contract_source("0x" + contract_address)
        if info.get("proxy") == "0" and info.get("source_code") or contract_address == "43506849d7c04f9138d1a2050bbf3a0c054402dd":
            source_code = info["source_code"]
            if source_code.startswith("{{") and source_code.endswith("}}"):
                # Multi-file JSON format, remove outer braces
                source_code = source_code[1:-1]
                try:
                    source_code_json = json.loads(source_code)
                    sources_dict = source_code_json.get("sources", {})
                    self.save_multi_file_source(contract_address, sources_dict)
                    print("[+] Multi-file source code found and saved.")
                    return info["contract_name"] 
                except Exception as e:
                    print(f"[!] Failed to parse multi-file JSON: {e}")
                    return None
                
            else:
                # Single file format, save directly as contract_address.sol
                os.makedirs(output_dir, exist_ok=True)
                filepath = os.path.join(output_dir, f"{contract_address}.sol")
                with open(filepath, "w", encoding="utf-8") as f:
                    f.write(source_code)
                print(f"[+] Single-file source saved: {filepath}")
                return None
                      
        elif info.get("proxy") == "0":
            bytecode = self.fetcher.fetch_contract_bytecode("0x" + contract_address)
            if not bytecode:
                return None
            os.makedirs(output_dir, exist_ok=True)
            bytecode_file = f"{output_dir}{contract_address}.bin"
            with open(bytecode_file, "w") as f:
                f.write(bytecode)

            result = decompile_bytecode(bytecode_file, name=contract_address, rpc_url=RPC_URL, output=output_dir)
            print(result)
            return None
