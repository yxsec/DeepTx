#!/usr/bin/env python3
"""
Test API connections
"""
import os
from dotenv import load_dotenv
from openai import OpenAI
import requests

load_dotenv()

def test_openai_api():
    """Test OpenAI API connection"""
    print("\n=== Testing OpenAI API ===")
    try:
        api_key = os.environ.get("OPENAI_API_KEY")
        if not api_key:
            print("❌ OPENAI_API_KEY not found")
            return False

        print(f"✓ API Key found: {api_key[:20]}...")

        client = OpenAI(
            api_key=api_key,
            base_url=os.environ.get("OPENAI_BASE_URL", "https://api.openai.com/v1")
        )

        # Test with a simple completion
        response = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "user", "content": "Say 'API test successful' if you can read this."}
            ],
            max_tokens=50
        )

        result = response.choices[0].message.content
        print(f"✓ OpenAI API Response: {result}")
        return True

    except Exception as e:
        print(f"❌ OpenAI API Error: {e}")
        return False

def test_etherscan_api():
    """Test Etherscan API connection"""
    print("\n=== Testing Etherscan API ===")
    try:
        api_key = os.environ.get("ETHERSCAN_API_KEY")
        api_url = os.environ.get("ETHERSCAN_API_URL", "https://api.etherscan.io/api")

        if not api_key:
            print("❌ ETHERSCAN_API_KEY not found")
            return False

        print(f"✓ API Key found: {api_key[:10]}...")
        print(f"✓ API URL: {api_url}")

        # Test with a simple request (get ETH balance)
        test_address = "0xde0b295669a9fd93d5f28d9ec85e40f4cb697bae"  # Ethereum Foundation
        url = f"{api_url}?module=account&action=balance&address={test_address}&tag=latest&apikey={api_key}"

        response = requests.get(url, timeout=10)
        data = response.json()

        if data.get("status") == "1":
            print(f"✓ Etherscan API working: Balance query successful")
            return True
        else:
            print(f"⚠ Etherscan API response: {data}")
            return False

    except Exception as e:
        print(f"❌ Etherscan API Error: {e}")
        return False

def test_rpc_connection():
    """Test RPC connection"""
    print("\n=== Testing RPC Connection ===")
    try:
        rpc_url = os.environ.get("RPC_URL", "https://ethereum.therpc.io")
        print(f"✓ RPC URL: {rpc_url}")

        # Test with eth_blockNumber
        payload = {
            "jsonrpc": "2.0",
            "method": "eth_blockNumber",
            "params": [],
            "id": 1
        }

        response = requests.post(rpc_url, json=payload, timeout=10)
        data = response.json()

        if "result" in data:
            block_number = int(data["result"], 16)
            print(f"✓ RPC connected: Current block {block_number:,}")
            return True
        else:
            print(f"⚠ RPC response: {data}")
            return False

    except Exception as e:
        print(f"❌ RPC Error: {e}")
        return False

def main():
    print("="*70)
    print("API CONNECTION TEST")
    print("="*70)

    results = {
        "OpenAI": test_openai_api(),
        "Etherscan": test_etherscan_api(),
        "RPC": test_rpc_connection()
    }

    print("\n" + "="*70)
    print("TEST RESULTS")
    print("="*70)

    for service, status in results.items():
        status_icon = "✅" if status else "❌"
        print(f"{status_icon} {service}: {'PASSED' if status else 'FAILED'}")

    all_passed = all(results.values())
    print("\n" + "="*70)
    if all_passed:
        print("✅ ALL API CONNECTIONS SUCCESSFUL")
    else:
        print("⚠ SOME API CONNECTIONS FAILED")
    print("="*70)

    return 0 if all_passed else 1

if __name__ == "__main__":
    import sys
    sys.exit(main())
