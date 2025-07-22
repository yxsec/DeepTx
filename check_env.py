#!/usr/bin/env python3
"""
Environment Variable Checker
============================

This script checks if all required environment variables are set correctly.
"""

import os
import sys

def check_environment():
    """Check if all required environment variables are set."""
    required_vars = [
        "HEIMDALL_API_KEY",
        "ETHERSCAN_API_KEY", 
        "OPENAI_API_KEY"
    ]
    
    optional_vars = [
        "RPC_URL",
        "OPENAI_BASE_URL",
        "TENDERLY_API_KEY",
        "TENDERLY_ACCOUNT_ID", 
        "TENDERLY_PROJECT_SLUG"
    ]
    
    print("🔍 Checking environment variables...")
    print("=" * 50)
    
    # Check required variables
    missing_required = []
    for var in required_vars:
        value = os.environ.get(var)
        if value:
            # Mask the API key for security
            masked_value = value[:8] + "..." + value[-4:] if len(value) > 12 else "***"
            print(f"✅ {var}: {masked_value}")
        else:
            print(f"❌ {var}: NOT SET")
            missing_required.append(var)
    
    print()
    
    # Check optional variables
    for var in optional_vars:
        value = os.environ.get(var)
        if value:
            print(f"✅ {var}: {value}")
        else:
            print(f"⚠️  {var}: NOT SET (optional)")
    
    print("=" * 50)
    
    if missing_required:
        print(f"\n❌ Missing required environment variables: {', '.join(missing_required)}")
        print("\nPlease set the missing variables:")
        for var in missing_required:
            print(f"export {var}='your_{var.lower()}_here'")
        return False
    else:
        print("\n✅ All required environment variables are set!")
        return True

if __name__ == "__main__":
    success = check_environment()
    sys.exit(0 if success else 1) 