import json
import os
import sys
from .tenderly import TenderlySimulator, get_transaction_params_by_hash
from .utils import extract_all_call_traces, extract_asset_changes, extract_transfer_events, extract_eth_transfers
import csv
from typing import List

# Tenderly API configuration
api_key = os.environ.get("TENDERLY_API_KEY")
account_id = os.environ.get("TENDERLY_ACCOUNT_ID")
project_slug = os.environ.get("TENDERLY_PROJECT_SLUG")

def simulate_transaction(
    contract_address: str,
    function_signature: str = None,
    params: List = None,
    from_address: str = "0x0000000000000000000000000000000000000000",
    value: str = "0x0",
    network_id: str = "1",
    block_number: int = None,
    tx_hash: str = None,
    rpc_url: str = None
) -> tuple:
    """
    Simulate transaction and save result
    
    Returns:
        (result_dict, output_dir)
    """
    from web3 import Web3
    

    simulator = TenderlySimulator(
        api_key=api_key,
        account_id=account_id,
        project_slug=project_slug
    )
    

    if tx_hash and rpc_url:
        tx_params = get_transaction_params_by_hash(rpc_url, tx_hash)
        result = simulator.simulate_transaction(**tx_params)
        simulation_id = tx_hash
    else:
        if function_signature and params is not None:
            w3 = Web3()
            function_selector = w3.keccak(text=function_signature)[:4].hex()
            param_types = function_signature.split('(')[1].rstrip(')').split(',')
            
            if param_types and param_types != ['']:
                encoded_params = w3.codec.encode(param_types, params).hex()
                input_data = '0x' + function_selector + encoded_params
            else:
                input_data = '0x' + function_selector
        else:
            input_data = "0x"
        
        result = simulator.simulate_transaction(
            network_id=network_id,
            from_address=from_address,
            to_address=contract_address,
            input_data=input_data,
            value=value,
            block_number=block_number
        )
        
        simulation_id = result.get('transaction', {}).get('hash', 'unknown')
    
    chain_id = result.get('transaction', {}).get('network_id', '1')
    
    output_dir = os.path.join('output', str(chain_id), simulation_id)
    os.makedirs(output_dir, exist_ok=True)
    
    trace_file = os.path.join(output_dir, 'decoded_trace.json')
    with open(trace_file, 'w', encoding='utf-8') as f:
        json.dump(result, f, indent=2)
    
    return result, output_dir


def extract_and_save_asset_flows(result: dict, output_dir: str):
    """Extract asset flows and save to CSV (silent)"""
    asset_transfers = extract_asset_changes(result)
    token_transfers = extract_transfer_events(result)
    eth_transfers = extract_eth_transfers(result)
    
    all_transfers = asset_transfers + token_transfers + eth_transfers
    seen = set()
    unique_transfers = []
    for transfer in all_transfers:
        key = (transfer['token_address'], transfer['from'], transfer['to'], transfer['value'])
        if key not in seen:
            seen.add(key)
            unique_transfers.append(transfer)
    
    output_file = os.path.join(output_dir, 'asset_flows.csv')
    fieldnames = ['token_address', 'name', 'symbol', 'from', 'to', 'value']
    
    with open(output_file, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        if unique_transfers:
            writer.writerows(unique_transfers)


def extract_and_save_call_trace(result: dict, output_dir: str):
    """Extract call trace and save to CSV (silent)"""
    # Extract call traces (excluding JUMPDEST and STATICCALL)
    exclude_types = ['JUMPDEST', 'STATICCALL']
    traces = extract_all_call_traces(result, exclude_types=exclude_types)
    
    output_file = os.path.join(output_dir, 'call_trace.csv')
    fieldnames = ['depth', 'from', 'to', 'call_type', 'function']
    
    with open(output_file, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames, extrasaction='ignore')
        writer.writeheader()
        if traces:
            writer.writerows(traces)


def extract_and_save_state_changes(result: dict, output_dir: str):
    """Extract state changes and save to CSV"""
    
    def simplify_hex(hex_str: str) -> str:
        """Simplify hex string by removing leading zeros"""
        if not hex_str or not isinstance(hex_str, str):
            return hex_str
        
        # Remove 0x prefix if present
        if hex_str.startswith('0x') or hex_str.startswith('0X'):
            prefix = hex_str[:2]
            hex_value = hex_str[2:]
        else:
            prefix = ''
            hex_value = hex_str
        
        # Remove leading zeros, but keep at least one digit
        hex_value = hex_value.lstrip('0') or '0'
        
        return prefix + hex_value
    
    state_changes = []
    
    # Get state_diff from transaction_info
    state_diff = result.get('transaction', {}).get('transaction_info', {}).get('state_diff')
    
    # Extract raw storage changes if state_diff exists
    if state_diff and isinstance(state_diff, list):
        for diff in state_diff:
            raw_changes = diff.get('raw')
            if raw_changes and isinstance(raw_changes, list):
                for change in raw_changes:
                    contract = change.get('address', '')
                    storage_slot = change.get('key', '')
                    new_value = change.get('dirty', '')
                    
                    if contract and storage_slot:
                        state_changes.append({
                            'Contract': contract,
                            'Storage Slot': simplify_hex(storage_slot),
                            'New Value': simplify_hex(new_value)
                        })
    
    output_file = os.path.join(output_dir, 'state_changes.csv')
    fieldnames = ['Contract', 'Storage Slot', 'New Value']
    
    with open(output_file, 'w', newline='', encoding='utf-8') as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        if state_changes:
            writer.writerows(state_changes)


def extract_and_save_addresses(result: dict, output_dir: str):
    """Extract contract addresses from contract_ids"""
    # Get contract_ids from transaction
    contract_ids = result.get('transaction', {}).get('contract_ids', [])
    
    addresses = []
    if contract_ids:
        for contract_id in contract_ids:
            if isinstance(contract_id, str) and ':' in contract_id:
                # Split by ':' and take the last part (address)
                address = contract_id.split(':')[-1]
                if address and address not in addresses:
                    addresses.append(address)
    
    # Save to text file
    output_file = os.path.join(output_dir, 'address.txt')
    with open(output_file, 'w', encoding='utf-8') as f:
        for address in addresses:
            f.write(f"{address}\n")


def simulation():
    """Main function"""
    
    if len(sys.argv) < 2:
        print("Usage:")
        print("  python3 main.py --tx-hash <hash> --rpc-url <url>")
        print("  python3 main.py --contract <address> --function <signature> [params] [--from <addr>] [--value <hex>] [--block <num>]")
        print("\nExamples:")
        print("  python3 main.py --tx-hash 0xabc... --rpc-url https://eth.llamarpc.com")
        print("  python3 main.py --contract 0xA0b8... --function 'balanceOf(address)' 0x742d...")
        print("  python3 main.py --contract 0xA0b8... --function 'transfer(address,uint256)' 0xRecip 1000 --from 0xAddr")
        sys.exit(1)
    
    # Parse arguments
    args = sys.argv[1:]
    
    # Parse optional parameters
    from_address = "0x0000000000000000000000000000000000000000"
    value = "0x0"
    block_number = None
    
    if '--from' in args:
        from_idx = args.index('--from')
        from_address = args[from_idx + 1]
    
    if '--value' in args:
        value_idx = args.index('--value')
        value = args[value_idx + 1]
    
    if '--block' in args:
        block_idx = args.index('--block')
        block_number = int(args[block_idx + 1])
    
    if '--tx-hash' in args:
        # Method 1: From transaction hash
        tx_hash_idx = args.index('--tx-hash')
        tx_hash = args[tx_hash_idx + 1]
        
        rpc_url_idx = args.index('--rpc-url')
        rpc_url = args[rpc_url_idx + 1]
        
        result, output_dir = simulate_transaction(
            contract_address=None,
            tx_hash=tx_hash,
            rpc_url=rpc_url
        )
        
    elif '--contract' in args:
        # Method 2: Custom contract call
        contract_idx = args.index('--contract')
        contract_address = args[contract_idx + 1]
        
        function_signature = None
        params = []
        
        if '--function' in args:
            func_idx = args.index('--function')
            function_signature = args[func_idx + 1]
            
            # Get parameters (exclude optional flags)
            params_start = func_idx + 2
            optional_flags = ['--from', '--value', '--block']
            params = []
            
            for i in range(params_start, len(args)):
                if args[i] in optional_flags:
                    break
                params.append(args[i])
            
            # Convert parameter types
            converted_params = []
            for param in params:
                if param.startswith('0x') and len(param) == 42:
                    converted_params.append(param)
                elif param.isdigit():
                    converted_params.append(int(param))
                else:
                    converted_params.append(param)
            params = converted_params
        
        result, output_dir = simulate_transaction(
            contract_address=contract_address,
            function_signature=function_signature,
            params=params,
            from_address=from_address,
            value=value,
            block_number=block_number
        )
    else:
        print("Error: Must specify either --tx-hash or --contract")
        sys.exit(1)
    
    status = result.get('transaction', {}).get('status', False)
    
    extract_and_save_asset_flows(result, output_dir)
    extract_and_save_call_trace(result, output_dir)
    extract_and_save_state_changes(result, output_dir)
    extract_and_save_addresses(result, output_dir)
    
    #print(f"\n{output_dir}")
    if not status:
        print("Simulation failed.")
        sys.exit(1)
    else:
        return output_dir

