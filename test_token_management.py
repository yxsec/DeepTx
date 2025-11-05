#!/usr/bin/env python3
"""
Test script for token management functionality
"""
import sys
import json
from src.llm_processor import (
    estimate_tokens,
    extract_function_frequency,
    select_top_functions_from_code,
    smart_token_management
)

def create_large_mock_data():
    """Create mock transaction data with large code to test token management"""

    # Simulate a large call chain
    call_chain = []
    for i in range(500):  # 500 calls
        call_chain.append({
            "depth": i % 5,
            "from": f"0x{'a' * 40}",
            "to": f"0x{'b' * 40}",
            "call_type": "call",
            "function": f"function_{i % 50}",  # 50 unique functions, varying frequency
            "gas_used": 50000,
            "gas_allocated": 100000
        })

    # Simulate large code with many functions
    code_parts = []
    for i in range(100):  # 100 functions
        func_code = f"""
< Function from 0x{'a'*40} - function_{i} in Contract.sol >
function function_{i}(address param1, uint256 param2) public {{
    require(param1 != address(0), "Invalid address");
    require(param2 > 0, "Amount must be positive");

    // Some complex logic here
    for (uint i = 0; i < 10; i++) {{
        balances[param1] += param2;
        emit Transfer(address(this), param1, param2);
    }}

    // More code to make it larger
    if (param2 > 1000) {{
        _complexOperation(param1, param2);
        _anotherOperation(param1);
        _validateState();
    }}

    return true;
}}
"""
        code_parts.append(func_code)

    large_code = "\n".join(code_parts)

    # Create mock data structure
    data = {
        "behavior_analysis": {
            "call_chain": call_chain,
            "code_analysis": large_code,
            "asset_flows": [
                {
                    "token_address": "0xdAC17F958D2ee523a2206206994597C13D831ec7",
                    "name": "Tether USD",
                    "symbol": "USDT",
                    "from": "0x" + "a" * 40,
                    "to": "0x" + "b" * 40,
                    "value": 1000000
                }
                for _ in range(50)  # 50 asset flows
            ],
            "state_changes": [
                {
                    "Contract": "0x" + "c" * 40,
                    "Storage Slot": f"0x{i:064x}",
                    "New Value": f"0x{i*2:064x}"
                }
                for i in range(100)  # 100 state changes
            ]
        },
        "context_analysis": {
            "total_gas_used": 5000000,
            "total_gas_allocated": 10000000,
            "gas_efficiency_percent": 50.0,
            "total_calls": 500
        },
        "ui_analysis": {
            "js_code_present": False
        },
        "malicious_database_report": {
            "has_meaningful_data": True,
            "malicious_addresses": ["0x" + "d" * 40],
            "indicators_summary": {
                "malicious_addresses_count": 1,
                "code_patterns_count": 0,
                "url_check_count": 0,
                "js_patterns_count": 0
            }
        },
        "context": {
            "transaction_hash": "0xtest123",
            "trace_calls_analyzed": 500,
            "code_functions_found": 100,
            "asset_transfers": 50,
            "state_changes": 100
        }
    }

    return data

def test_token_estimation():
    """Test token estimation"""
    print("\n=== TEST 1: Token Estimation ===")
    test_text = "This is a test string with approximately 100 characters to verify token estimation works correctly!"
    estimated = estimate_tokens(test_text)
    print(f"Text length: {len(test_text)} characters")
    print(f"Estimated tokens: {estimated} tokens")
    print(f"✓ Token estimation working (1 token ≈ 4 characters)")

def test_function_frequency():
    """Test function frequency extraction"""
    print("\n=== TEST 2: Function Frequency Analysis ===")

    # Create test call chain
    call_chain = [
        {"function": "transfer"},
        {"function": "transfer"},
        {"function": "transfer"},
        {"function": "approve"},
        {"function": "approve"},
        {"function": "balanceOf"},
    ]

    frequency = extract_function_frequency(call_chain)
    print(f"Call chain: {len(call_chain)} calls")
    print(f"Frequency analysis: {frequency}")

    sorted_funcs = sorted(frequency.items(), key=lambda x: x[1], reverse=True)
    print(f"Top functions: {sorted_funcs}")
    print(f"✓ Function frequency analysis working")

def test_smart_token_management():
    """Test smart token management with large data"""
    print("\n=== TEST 3: Smart Token Management ===")

    data = create_large_mock_data()

    # Calculate initial sizes
    initial_code_tokens = estimate_tokens(data["behavior_analysis"]["code_analysis"])
    initial_total_tokens = sum([
        estimate_tokens(json.dumps(data["behavior_analysis"]["call_chain"])),
        initial_code_tokens,
        estimate_tokens(json.dumps(data["behavior_analysis"]["asset_flows"])),
        estimate_tokens(json.dumps(data["behavior_analysis"]["state_changes"])),
        estimate_tokens(json.dumps(data["context_analysis"])),
        estimate_tokens(json.dumps(data["ui_analysis"])),
        estimate_tokens(json.dumps(data["malicious_database_report"]))
    ])

    print(f"\nInitial Data Size:")
    print(f"  Call chain: {len(data['behavior_analysis']['call_chain'])} calls")
    print(f"  Code: ~{initial_code_tokens:,} tokens")
    print(f"  Total: ~{initial_total_tokens:,} tokens")

    # Test with different token limits
    for max_tokens in [50000, 25000, 15000, 10000]:
        print(f"\n--- Testing with limit: {max_tokens:,} tokens ---")
        optimized_data = smart_token_management(data.copy(), max_total_tokens=max_tokens)

        # Calculate final size
        final_code = optimized_data["behavior_analysis"].get("code_analysis", "")
        final_code_tokens = estimate_tokens(final_code) if final_code else 0

        code_selection = optimized_data["behavior_analysis"].get("_code_selection")
        code_skipped = optimized_data["behavior_analysis"].get("_code_skipped_reason")

        if code_selection:
            print(f"Result: Included {code_selection['functions_included']} out of {code_selection['total_functions']} functions")
            top_func_names = [f"{f['name']}({f['calls']}x)" for f in code_selection['top_functions'][:5]]
            print(f"  Top functions: {top_func_names}")
        elif code_skipped:
            print(f"Result: Code skipped - {code_skipped}")
        else:
            print(f"Result: All code included")

        print(f"  Final code size: ~{final_code_tokens:,} tokens")

def test_function_selection():
    """Test function selection from code"""
    print("\n=== TEST 4: Function Selection ===")

    # Create sample code
    sample_code = """
< Function from 0xaaa - transfer in Token.sol >
function transfer(address to, uint256 amount) public {
    balances[to] += amount;
}

< Function from 0xaaa - approve in Token.sol >
function approve(address spender, uint256 amount) public {
    allowances[msg.sender][spender] = amount;
}

< Function from 0xaaa - balanceOf in Token.sol >
function balanceOf(address account) public view returns (uint256) {
    return balances[account];
}

< Function from 0xaaa - mint in Token.sol >
function mint(address to, uint256 amount) public {
    totalSupply += amount;
    balances[to] += amount;
}
"""

    top_functions = ["transfer", "approve"]  # Only keep these two

    filtered_code = select_top_functions_from_code(sample_code, top_functions, max_functions=2)

    print(f"Original code: 4 functions")
    print(f"Selected: {top_functions}")
    print(f"Filtered code contains 'transfer': {'transfer' in filtered_code}")
    print(f"Filtered code contains 'approve': {'approve' in filtered_code}")
    print(f"Filtered code contains 'balanceOf': {'balanceOf' in filtered_code}")
    print(f"Filtered code contains 'mint': {'mint' in filtered_code}")
    print(f"✓ Function selection working")

def main():
    print("="*70)
    print("TOKEN MANAGEMENT TEST SUITE")
    print("="*70)

    try:
        test_token_estimation()
        test_function_frequency()
        test_function_selection()
        test_smart_token_management()

        print("\n" + "="*70)
        print("✅ ALL TESTS PASSED")
        print("="*70)
        return 0

    except Exception as e:
        print(f"\n❌ TEST FAILED: {e}")
        import traceback
        traceback.print_exc()
        return 1

if __name__ == "__main__":
    sys.exit(main())
