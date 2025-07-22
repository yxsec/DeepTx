#!/usr/bin/env python3
"""
Simulation Service Usage Examples
=================================

This example demonstrates how to use the unified simulation service
to simulate transactions using different backends (Foundry and Tenderly).
"""

import os
import sys
sys.path.append('src')

from simulation_service import simulation_service

def example_1_basic_usage():
    """Example 1: Basic usage with auto-selected backend."""
    print("\n📋 Example 1: Basic Usage (Auto-select backend)")
    print("=" * 60)
    
    # Example transaction hash
    tx_hash = "0xff8e9226091d513fc936ecc670030eba03f34dbe60cd012122bd18be44248d32"
    
    try:
        # Auto-select the best available backend
        result = simulation_service.simulate_transaction(tx_hash, backend="auto")
        print(f"✅ Simulation completed successfully")
        print(f"Result type: {type(result)}")
        
        if isinstance(result, dict):
            print(f"Result keys: {list(result.keys())}")
            # Show some key information if available
            if 'gas_used' in result:
                print(f"Gas used: {result['gas_used']}")
            if 'success' in result:
                print(f"Success: {result['success']}")
        else:
            print(f"Result length: {len(str(result))} characters")
            
    except Exception as e:
        print(f"❌ Simulation failed: {e}")


def example_2_foundry_specific():
    """Example 2: Use Foundry backend specifically."""
    print("\n📋 Example 2: Foundry Backend")
    print("=" * 60)
    
    tx_hash = "0xff8e9226091d513fc936ecc670030eba03f34dbe60cd012122bd18be44248d32"
    
    try:
        # Use Foundry backend with specific options
        result = simulation_service.simulate_with_foundry(
            tx_hash,
            rpc_url="https://ethereum.therpc.io",
            quick=True,
            json_output=True,
            debug=False
        )
        print(f"✅ Foundry simulation completed")
        print(f"Result type: {type(result)}")
        
        if isinstance(result, dict):
            print(f"Result keys: {list(result.keys())}")
            
    except Exception as e:
        print(f"❌ Foundry simulation failed: {e}")
        print("💡 Make sure Foundry is installed: https://book.getfoundry.sh/getting-started/installation")


def example_3_tenderly_specific():
    """Example 3: Use Tenderly backend specifically."""
    print("\n📋 Example 3: Tenderly Backend")
    print("=" * 60)
    
    tx_hash = "0xff8e9226091d513fc936ecc670030eba03f34dbe60cd012122bd18be44248d32"
    
    try:
        # Use Tenderly backend
        result = simulation_service.simulate_with_tenderly(
            tx_hash,
            rpc_url="https://ethereum.therpc.io",
            use_cache=True
        )
        print(f"✅ Tenderly simulation completed")
        print(f"Result type: {type(result)}")
        
        if isinstance(result, dict):
            print(f"Result keys: {list(result.keys())}")
            # Show simulation details
            if 'simulation' in result:
                sim = result['simulation']
                if 'gas_used' in sim:
                    print(f"Gas used: {sim['gas_used']}")
                if 'status' in sim:
                    print(f"Status: {sim['status']}")
                    
    except Exception as e:
        print(f"❌ Tenderly simulation failed: {e}")
        print("💡 Make sure Tenderly environment variables are set:")
        print("   - TENDERLY_API_KEY")
        print("   - TENDERLY_ACCOUNT_ID")
        print("   - TENDERLY_PROJECT_SLUG")


def example_4_backend_selection():
    """Example 4: Check available backends and select manually."""
    print("\n📋 Example 4: Backend Selection")
    print("=" * 60)
    
    # Check what backends are available
    available_backends = simulation_service.get_available_backends()
    print(f"Available backends: {available_backends}")
    
    if not available_backends:
        print("❌ No simulation backends available")
        print("\nTo enable simulation backends:")
        print("1. Install Foundry: https://book.getfoundry.sh/getting-started/installation")
        print("2. Set Tenderly environment variables (optional):")
        print("   - TENDERLY_API_KEY")
        print("   - TENDERLY_ACCOUNT_ID") 
        print("   - TENDERLY_PROJECT_SLUG")
        return
    
    tx_hash = "0xff8e9226091d513fc936ecc670030eba03f34dbe60cd012122bd18be44248d32"
    
    # Try each available backend
    for backend in available_backends:
        print(f"\n🔄 Trying {backend} backend...")
        try:
            if backend == "foundry":
                result = simulation_service.simulate_with_foundry(tx_hash)
            elif backend == "tenderly":
                result = simulation_service.simulate_with_tenderly(tx_hash)
            else:
                result = simulation_service.simulate_transaction(tx_hash, backend=backend)
            
            print(f"✅ {backend.capitalize()} simulation successful")
            print(f"Result type: {type(result)}")
            
        except Exception as e:
            print(f"❌ {backend.capitalize()} simulation failed: {e}")


def example_5_custom_parameters():
    """Example 5: Using custom parameters for simulation."""
    print("\n📋 Example 5: Custom Parameters")
    print("=" * 60)
    
    tx_hash = "0xff8e9226091d513fc936ecc670030eba03f34dbe60cd012122bd18be44248d32"
    
    # Custom RPC URL
    custom_rpc = "https://eth-mainnet.g.alchemy.com/v2/your-api-key"
    
    try:
        # Use custom parameters
        result = simulation_service.simulate_transaction(
            tx_hash,
            backend="auto",
            rpc_url=custom_rpc,
            # Additional parameters for Foundry
            quick=False,  # More detailed simulation
            debug=True,   # Enable debug output
            # Additional parameters for Tenderly
            use_cache=True
        )
        print(f"✅ Custom simulation completed")
        print(f"Result type: {type(result)}")
        
    except Exception as e:
        print(f"❌ Custom simulation failed: {e}")


def example_6_batch_simulation():
    """Example 6: Simulate multiple transactions."""
    print("\n📋 Example 6: Batch Simulation")
    print("=" * 60)
    
    # Multiple transaction hashes
    tx_hashes = [
        "0xff8e9226091d513fc936ecc670030eba03f34dbe60cd012122bd18be44248d32",
        "0x1234567890abcdef1234567890abcdef1234567890abcdef1234567890abcdef",
        "0xabcdef1234567890abcdef1234567890abcdef1234567890abcdef1234567890"
    ]
    
    results = {}
    
    for i, tx_hash in enumerate(tx_hashes, 1):
        print(f"\n🔄 Simulating transaction {i}/{len(tx_hashes)}: {tx_hash[:10]}...")
        try:
            result = simulation_service.simulate_transaction(tx_hash, backend="auto")
            results[tx_hash] = {"success": True, "result": result}
            print(f"✅ Transaction {i} simulation successful")
        except Exception as e:
            results[tx_hash] = {"success": False, "error": str(e)}
            print(f"❌ Transaction {i} simulation failed: {e}")
    
    # Summary
    successful = sum(1 for r in results.values() if r["success"])
    print(f"\n📊 Batch simulation summary:")
    print(f"Total transactions: {len(tx_hashes)}")
    print(f"Successful: {successful}")
    print(f"Failed: {len(tx_hashes) - successful}")


def main():
    """Run all examples."""
    print("🔍 Simulation Service Examples")
    print("=" * 60)
    
    # Check environment
    print("Environment check:")
    foundry_available = simulation_service.foundry is not None
    tenderly_available = simulation_service.tenderly is not None
    print(f"  Foundry: {'✅ Available' if foundry_available else '❌ Not available'}")
    print(f"  Tenderly: {'✅ Available' if tenderly_available else '❌ Not available'}")
    print(f"  Cache directory: {simulation_service.cache_dir}")
    
    # Run examples
    example_1_basic_usage()
    example_2_foundry_specific()
    example_3_tenderly_specific()
    example_4_backend_selection()
    example_5_custom_parameters()
    example_6_batch_simulation()
    
    print("\n" + "=" * 60)
    print("🎉 All examples completed!")
    print("\n💡 Tips:")
    print("- Results are cached in the cache directory for faster subsequent runs")
    print("- Use 'backend=\"auto\"' to automatically select the best available backend")
    print("- Check available backends with get_available_backends()")
    print("- Set environment variables for Tenderly to enable cloud simulation")


if __name__ == "__main__":
    main() 