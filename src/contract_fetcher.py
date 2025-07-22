import os
import requests
from datetime import datetime
import json
from .heimdall_client import decompile_bytecode

ETHERSCAN_API_KEY = os.environ.get("ETHERSCAN_API_KEY")
if not ETHERSCAN_API_KEY:
    raise ValueError("ETHERSCAN_API_KEY environment variable is required")

RPC_URL = os.environ.get("RPC_URL", "https://ethereum.therpc.io")


class ContractFetcher:
    def __init__(self, api_key=ETHERSCAN_API_KEY):
        self.api_key = api_key

    def fetch_contract_source(self, contract_address):
        url = (
            f"https://api.etherscan.io/api?module=contract&action=getsourcecode"
            f"&address={contract_address}&apikey={self.api_key}"
        )
        response = requests.get(url, timeout=10)
        if response.status_code == 200:
            result = response.json()["result"]
            if result and result[0]["SourceCode"]:
                return result[0]
        return None

    def fetch_contract_bytecode(self, contract_address):
        url = (
            f"https://api.etherscan.io/api?module=proxy&action=eth_getCode"
            f"&address={contract_address}&tag=latest&apikey={self.api_key}"
        )
        response = requests.get(url, timeout=10)
        if response.status_code == 200:
            data = response.json()
            bytecode = data.get("result")
            if bytecode and bytecode != "0x":
                return bytecode
        return None


class ContractDecompilerTool:
    def __init__(self, fetcher: ContractFetcher):
        self.fetcher = fetcher

    def save_multi_file_source(self, contract_address, sources_dict):
        base_path = f"contracts/{contract_address}/"
        os.makedirs(base_path, exist_ok=True)
        for filename, content_info in sources_dict.items():
            clean_filename = filename.replace("@", "").replace("/", "_")
            path = os.path.join(base_path, clean_filename)
            with open(path, "w", encoding="utf-8") as f:
                f.write(content_info["content"])
        print(f"[+] Saved multi-file source code to: {base_path}")

    def save_flattened_source(self, contract_address, source_code):
        address_clean = contract_address.replace("0x", "")
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        base_path = f"contracts/{address_clean}/"
        os.makedirs(base_path, exist_ok=True)
        path = f"{base_path}{address_clean}_source_{timestamp}.sol"
        with open(path, "w", encoding="utf-8") as f:
            f.write(source_code)
        print(f"[+] Flattened source saved: {path}")

    def run(self, contract_address):
        contract_address = contract_address.lower().replace("0x", "")
        print(f"[*] Checking contract: 0x{contract_address}")

        info = self.fetcher.fetch_contract_source("0x" + contract_address)
        if not isinstance(info, dict):
            print(f"[!] Unexpected contract source info type for {contract_address}: {type(info)}")
            return
        if info:
            source_code = info["SourceCode"]
            if source_code.startswith("{{") and source_code.endswith("}}"):
                # Multi-file JSON format, remove outer braces
                source_code = source_code[1:-1]
                try:
                    source_code_json = json.loads(source_code)
                    sources_dict = source_code_json.get("sources", {})
                    self.save_multi_file_source(contract_address, sources_dict)
                    self.save_flattened_source(contract_address, source_code_json.get("content", ""))
                    print("[+] Multi-file source code found and saved.")
                except Exception as e:
                    print(f"[!] Failed to parse multi-file JSON: {e}")
            else:
                # Single file format, save directly as contract_address.sol
                output_dir = f"contracts/{contract_address}/"
                os.makedirs(output_dir, exist_ok=True)
                filepath = os.path.join(output_dir, f"{contract_address}.sol")
                with open(filepath, "w", encoding="utf-8") as f:
                    f.write(source_code)
                print(f"[+] Single-file source saved: {filepath}")
        else:
            print("[-] No verified source code found. Attempting decompilation...")
            bytecode = self.fetcher.fetch_contract_bytecode("0x" + contract_address)
            if not bytecode:
                print("[!] Failed to fetch bytecode. Abort.")
                return

            output_dir = f"contracts/{contract_address}/"
            os.makedirs(output_dir, exist_ok=True)
            bytecode_file = f"{output_dir}{contract_address}.bin"
            with open(bytecode_file, "w") as f:
                f.write(bytecode)

            result = decompile_bytecode(bytecode_file, name=contract_address, rpc_url=RPC_URL, output=output_dir)
            print(result)



if __name__ == "__main__":
    import sys

    if len(sys.argv) != 2:
        print("Usage: python3 getcode.py <contract_address>")
        sys.exit(1)

    address = sys.argv[1]
    fetcher = ContractFetcher()
    #print(fetcher.fetch_contract_source(address))
    tool = ContractDecompilerTool(fetcher)
    tool.run(address)
