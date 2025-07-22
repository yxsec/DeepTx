# Simulation Service Usage Guide

## Overview

The `simulation_service.py` provides a unified interface for transaction simulation using multiple backends:
- **Foundry**: Local simulation using `cast run` command
- **Tenderly**: Cloud-based simulation using Tenderly API

## Quick Start

### 1. Basic Usage

```python
from src.simulation_service import simulation_service

# Simulate a transaction (auto-selects best available backend)
tx_hash = "0xff8e9226091d513fc936ecc670030eba03f34dbe60cd012122bd18be44248d32"
result = simulation_service.simulate_transaction(tx_hash, backend="auto")
```

### 2. Check Available Backends

```python
# Check what simulation backends are available
available_backends = simulation_service.get_available_backends()
print(f"Available: {available_backends}")  # ['foundry', 'tenderly']
```

### 3. Use Specific Backend

```python
# Use Foundry specifically
result = simulation_service.simulate_with_foundry(tx_hash)

# Use Tenderly specifically
result = simulation_service.simulate_with_tenderly(tx_hash)
```

## Installation Requirements

### Foundry (Local Simulation)
```bash
# Install Foundry
curl -L https://foundry.paradigm.xyz | bash
foundryup

# Verify installation
cast --version
```

### Tenderly (Cloud Simulation)
Set environment variables:
```bash
export TENDERLY_API_KEY="your_api_key"
export TENDERLY_ACCOUNT_ID="your_account_id"
export TENDERLY_PROJECT_SLUG="your_project_slug"
```

## API Reference

### SimulationService Class

#### `simulate_transaction(tx_hash, backend="auto", rpc_url=None, **kwargs)`

Main method to simulate a transaction.

**Parameters:**
- `tx_hash` (str): Transaction hash to simulate
- `backend` (str): Backend to use ("foundry", "tenderly", or "auto")
- `rpc_url` (str): RPC URL to use (optional)
- `**kwargs`: Additional backend-specific parameters

**Returns:**
- `Dict[str, Any]` or `str`: Simulation results

**Example:**
```python
# Auto-select backend
result = simulation_service.simulate_transaction(tx_hash)

# Use specific backend
result = simulation_service.simulate_transaction(tx_hash, backend="foundry")

# With custom RPC
result = simulation_service.simulate_transaction(
    tx_hash, 
    backend="tenderly", 
    rpc_url="https://eth-mainnet.g.alchemy.com/v2/your-key"
)
```

#### `simulate_with_foundry(tx_hash, rpc_url=None, **kwargs)`

Simulate using Foundry backend.

**Parameters:**
- `tx_hash` (str): Transaction hash
- `rpc_url` (str): RPC URL (optional)
- `quick` (bool): Use quick mode (default: True)
- `json_output` (bool): Return JSON output (default: True)
- `debug` (bool): Enable debug mode (default: False)
- `block` (str): Block to simulate against (optional)
- `state` (str): State to simulate against (optional)
- `evm_version` (str): EVM version to use (optional)
- `use_cache` (bool): Use caching (default: True)

**Example:**
```python
result = simulation_service.simulate_with_foundry(
    tx_hash,
    rpc_url="https://ethereum.therpc.io",
    quick=False,  # More detailed simulation
    debug=True,   # Enable debug output
    use_cache=True
)
```

#### `simulate_with_tenderly(tx_hash, rpc_url=None, **kwargs)`

Simulate using Tenderly backend.

**Parameters:**
- `tx_hash` (str): Transaction hash
- `rpc_url` (str): RPC URL to fetch transaction details
- `use_cache` (bool): Use caching (default: True)

**Example:**
```python
result = simulation_service.simulate_with_tenderly(
    tx_hash,
    rpc_url="https://ethereum.therpc.io",
    use_cache=True
)
```

#### `get_available_backends()`

Get list of available simulation backends.

**Returns:**
- `list`: List of available backend names

**Example:**
```python
backends = simulation_service.get_available_backends()
print(backends)  # ['foundry', 'tenderly']
```

## Advanced Usage

### 1. Batch Simulation

```python
tx_hashes = [
    "0x1234567890abcdef...",
    "0xabcdef1234567890...",
    "0x9876543210fedcba..."
]

results = {}
for tx_hash in tx_hashes:
    try:
        result = simulation_service.simulate_transaction(tx_hash, backend="auto")
        results[tx_hash] = {"success": True, "result": result}
    except Exception as e:
        results[tx_hash] = {"success": False, "error": str(e)}
```

### 2. Custom Parameters

```python
# Foundry with custom parameters
result = simulation_service.simulate_with_foundry(
    tx_hash,
    rpc_url="https://eth-mainnet.g.alchemy.com/v2/your-key",
    quick=False,      # More detailed simulation
    debug=True,       # Enable debug output
    block="latest",   # Simulate against latest block
    evm_version="london"
)

# Tenderly with custom parameters
result = simulation_service.simulate_with_tenderly(
    tx_hash,
    rpc_url="https://eth-mainnet.g.alchemy.com/v2/your-key",
    use_cache=False   # Disable caching
)
```

### 3. Error Handling

```python
try:
    result = simulation_service.simulate_transaction(tx_hash, backend="auto")
    print("Simulation successful")
except RuntimeError as e:
    print(f"Backend error: {e}")
except ValueError as e:
    print(f"Invalid parameters: {e}")
except Exception as e:
    print(f"Unexpected error: {e}")
```

## Caching

The simulation service automatically caches results to improve performance:

- **Cache Location**: `cache/simulation/` directory
- **Foundry Cache**: `cache/simulation/foundry/`
- **Tenderly Cache**: `cache/simulation/tenderly/`
- **Cache Keys**: Transaction hash for Foundry, query hash for Tenderly

### Disable Caching

```python
# Disable caching for a single simulation
result = simulation_service.simulate_with_foundry(tx_hash, use_cache=False)
result = simulation_service.simulate_with_tenderly(tx_hash, use_cache=False)
```

## Backend Comparison

| Feature | Foundry | Tenderly |
|---------|---------|----------|
| **Type** | Local | Cloud |
| **Speed** | Fast | Medium |
| **Accuracy** | High | High |
| **Setup** | Install Foundry | API Keys |
| **Cost** | Free | API Credits |
| **Offline** | Yes | No |
| **Custom RPC** | Yes | Yes |

## Troubleshooting

### Foundry Issues

1. **"cast command not found"**
   ```bash
   # Install Foundry
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   ```

2. **RPC connection errors**
   - Check your RPC URL
   - Ensure you have sufficient rate limits

### Tenderly Issues

1. **"Tenderly service not available"**
   ```bash
   # Set environment variables
   export TENDERLY_API_KEY="your_key"
   export TENDERLY_ACCOUNT_ID="your_account"
   export TENDERLY_PROJECT_SLUG="your_project"
   ```

2. **API rate limits**
   - Check your Tenderly plan limits
   - Use caching to reduce API calls

### General Issues

1. **No backends available**
   - Install Foundry or set up Tenderly
   - Check environment variables

2. **Cache issues**
   - Clear cache directory: `rm -rf cache/simulation/`
   - Check file permissions

## Examples

Run the complete example:
```bash
python3 simulation_example.py
```

This will demonstrate:
- Basic usage
- Backend-specific simulation
- Error handling
- Batch processing
- Custom parameters

## Integration with Main Tool

The simulation service can be integrated with the main transaction analysis tool:

```python
from src.simulation_service import simulation_service
from src.transaction_analyzer import run_transaction_analysis

# Run transaction analysis
run_transaction_analysis(tx_hash)

# Then simulate the transaction
simulation_result = simulation_service.simulate_transaction(tx_hash, backend="auto")

# Combine results for comprehensive analysis
# ... your analysis logic here
``` 