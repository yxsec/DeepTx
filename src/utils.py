from typing import List, Dict, Any
import json

def load_json(path: str) -> Dict[str, Any]:
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return json.load(f)
    except Exception as e:
        print(f"Error loading {path}: {e}")
        return {}

def load_text(path: str) -> str:
    """Load text file"""
    try:
        with open(path, 'r', encoding='utf-8') as f:
            return f.read()
    except Exception as e:
        print(f"Error loading {path}: {e}")
        return ""

def load_csv(path: str) -> List[Dict[str, Any]]:
    """Load CSV file"""
    try:
        import pandas as pd
        df = pd.read_csv(path)
        return df.to_dict('records')
    except Exception as e:
        print(f"Error loading {path}: {e}")
        return []

def extract_call_trace_recursive(call_trace: dict, depth: int = 0, traces: List[Dict] = None) -> List[Dict]:
    if traces is None:
        traces = []
    
    from_addr = call_trace.get('from', '')
    to_addr = call_trace.get('to', '')
    call_type = call_trace.get('call_type', '')
    function_name = call_trace.get('function_name', '')
    
    # If function_name is empty, try to get signature from input or function_selector
    if not function_name:
        # Try function_selector first
        function_selector = call_trace.get('function_selector', '')
        if not function_selector:
            # Extract from input (first 4 bytes after 0x)
            input_data = call_trace.get('input', '')
            if input_data and input_data.startswith('0x') and len(input_data) >= 10:
                function_selector = input_data[2:10]  # Remove 0x and get first 8 chars (4 bytes)
        
        # Generate Unresolved_[signature] format
        if function_selector:
            # Remove 0x prefix if present
            sig = function_selector[2:] if function_selector.startswith('0x') else function_selector
            function_name = f"Unresolved_{sig}"
        else:
            function_name = ''
    
    traces.append({
        'depth': depth,
        'from': from_addr,
        'to': to_addr,
        'call_type': call_type,
        'function': function_name
    })
    
    # Process subcalls
    calls = call_trace.get('calls')
    if calls and isinstance(calls, list):
        for subcall in calls:
            extract_call_trace_recursive(subcall, depth + 1, traces)
    
    return traces

def extract_all_call_traces(result: dict, exclude_types: List[str] = None) -> List[Dict]:
    traces = []
    
    call_trace = result.get('transaction', {}).get('transaction_info', {}).get('call_trace')
    
    if call_trace is None:
        return traces
    
    traces = extract_call_trace_recursive(call_trace, depth=0)
    
    if exclude_types:
        traces = [t for t in traces if t['call_type'] not in exclude_types]
    
    return traces

def extract_transfer_events(result: dict) -> List[Dict]:
    transfers = []
    
    if not result.get('transaction', {}).get('status', False):
        return transfers
    
    logs = result.get('transaction', {}).get('transaction_info', {}).get('logs')
    
    if logs is None:
        return transfers
    
    for log in logs:
        if log.get('name') == 'Transfer':
            inputs = log.get('inputs', [])
            
            from_addr = None
            to_addr = None
            value = None
            
            for input_item in inputs:
                param_name = input_item.get('name', '').lower()
                param_value = input_item.get('value')
                
                if param_name == 'from':
                    from_addr = param_value
                elif param_name == 'to':
                    to_addr = param_value
                elif param_name in ['value', 'amount', 'tokenid']:
                    value = param_value
            
            token_address = log.get('raw', {}).get('address', '')
            
            if from_addr and to_addr and value:
                transfers.append({
                    'token_address': token_address,
                    'name': '',  
                    'symbol': '',  
                    'from': from_addr,
                    'to': to_addr,
                    'value': str(value)
                })
    
    return transfers


def extract_eth_transfers(result: dict) -> List[Dict]:
    transfers = []
    
    balance_diff = result.get('transaction', {}).get('transaction_info', {}).get('balance_diff')
    
    if balance_diff is None:
        return transfers
    
    balance_changes = {}
    for change in balance_diff:
        addr = change.get('address', '')
        original = int(change.get('original', '0'))
        dirty = int(change.get('dirty', '0'))
        diff = dirty - original
        
        if diff != 0 and not change.get('is_miner', False):
            balance_changes[addr] = diff
    
    decreases = {addr: -diff for addr, diff in balance_changes.items() if diff < 0}
    increases = {addr: diff for addr, diff in balance_changes.items() if diff > 0}
    
    for from_addr, amount in decreases.items():
        for to_addr, recv_amount in increases.items():
            if amount == recv_amount:
                transfers.append({
                    'token_address': '0x0000000000000000000000000000000000000000',  
                    'name': 'Ethereum',
                    'symbol': 'ETH',
                    'from': from_addr,
                    'to': to_addr,
                    'value': str(amount)
                })
                break
    
    return transfers


def extract_asset_changes(result: dict) -> List[Dict]:
    transfers = []
    
    asset_changes = result.get('transaction', {}).get('transaction_info', {}).get('asset_changes')
    
    if asset_changes is None:
        return transfers
    
    for change in asset_changes:
        change_type = change.get('type', '').upper()
        
        if change_type in ['TRANSFER', 'ERC20_TRANSFER', 'ERC721_TRANSFER', 'ERC1155_TRANSFER']:
            token_info = change.get('token_info', {})
            
            token_address = (
                token_info.get('contract_address', '') or 
                change.get('token_address', '') or 
                change.get('asset', '')
            )
            
            transfers.append({
                'token_address': token_address,
                'name': token_info.get('name', ''),
                'symbol': token_info.get('symbol', ''),
                'from': change.get('from', ''),
                'to': change.get('to', ''),
                'value': str(change.get('amount', '') or change.get('value', '') or change.get('token_id', ''))
            })
    
    return transfers
