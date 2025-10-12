# Installation Guide

## Overview

**Two Analysis Modes:**
1. **Historical** - Analyze past on-chain transactions
2. **Simulation** - Preview transactions before execution (requires Tenderly)

## Requirements

- Python 3.8+
- Rust (for Heimdall)
- API Keys: Transpose, Etherscan, OpenAI
- Optional: Tenderly (simulation only)

## Installation

### 1. Install Heimdall

```bash
curl https://sh.rustup.rs -sSf | sh
curl -L http://get.heimdall.rs | bash
bifrost  # Open new terminal first
```

### 2. Install Python Dependencies

```bash
pip install -r requirements.txt
```

### 3. Configure Environment

```bash
cp env.example .env
```

Edit `.env`:

```bash
# Required
TRANSPOSE_API_KEY=your_key
ETHERSCAN_API_KEY=your_key
OPENAI_API_KEY=your_key

# Optional
RPC_URL=https://ethereum.therpc.io

# Simulation only
TENDERLY_API_KEY=your_key
TENDERLY_ACCOUNT_ID=your_id
TENDERLY_PROJECT_SLUG=your_project
```

## Get API Keys

### Required

**Transpose** - https://www.transpose.io/
- Free: 100K requests/month

**Etherscan** - https://etherscan.io/apis
- Free: 5 requests/second

**OpenAI** - https://platform.openai.com/api-keys

### Optional (Simulation)

**Tenderly** - https://tenderly.co/
- Settings → Authorization → Generate Access Token
- Find Account ID in Settings → Account
- Project Slug from URL: `dashboard.tenderly.co/{account}/{project}`

```bash
# Example
TENDERLY_ACCOUNT_ID=johndoe
TENDERLY_PROJECT_SLUG=ethereum-project
```

## Verify Setup

```bash
# Test imports
python3 -c "import pandas, web3, openai; print('OK')"

# Test Heimdall
heimdall --version

# Test environment
python3 -c "from dotenv import load_dotenv; import os; load_dotenv(); print('API Keys:', 'Set' if os.getenv('OPENAI_API_KEY') else 'Missing')"
```

## Quick Test

### Historical Mode

```bash
python3 main.py 0xff8e9226091d513fc936ecc670030eba03f34dbe60cd012122bd18be44248d32
```

### Simulation Mode

```bash
# Simulate USDC transfer: 100 USDC from Alice to Bob
python3 main.py -s true \
  --contract 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48 \
  --function 'transfer(address,uint256)' \
  0x742d35Cc6634C0532925a3b844Bc9e7595f0bEb0 100000000 \
  --from 0xd8dA6BF26964aF9D7eEd9e03E53415D37aA96045
```

## Troubleshooting

**Heimdall not found:**
```bash
export PATH="$HOME/.bifrost/bin:$PATH"
echo 'export PATH="$HOME/.bifrost/bin:$PATH"' >> ~/.zshrc
```


**Tenderly errors:**
```bash
# Verify credentials
python3 -c "import os; from dotenv import load_dotenv; load_dotenv(); print('Key:', os.getenv('TENDERLY_API_KEY')[:10])"

# Test API
curl -H "X-Access-Key: $TENDERLY_API_KEY" \
  https://api.tenderly.co/api/v1/account/$TENDERLY_ACCOUNT_ID/projects
```

**Alternative RPC:**
```bash
RPC_URL=https://eth.llamarpc.com
# or
RPC_URL=https://rpc.ankr.com/eth
```

## Resources

- Heimdall: https://github.com/Jon-Becker/heimdall-rs
- Tenderly: https://docs.tenderly.co/simulations-and-forks/simulation-api
- Web3.py: https://web3py.readthedocs.io/

---

**Start with historical mode. Add simulation later if needed.**
