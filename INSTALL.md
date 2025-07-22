# Installation Guide

## Quick Start

### 1. Clone the Repository

```bash
git clone <repository-url>
cd ethereum-transaction-analyzer
```

### 2. Install Dependencies

```bash
pip install -r requirements.txt
```

### 3. Set Environment Variables

```bash
export HEIMDALL_API_KEY="your_heimdall_api_key"
export RPC_URL="https://ethereum.therpc.io"
export ETHERSCAN_API_KEY="your_etherscan_api_key"
export OPENAI_API_KEY="your_openai_api_key"
export OPENAI_BASE_URL="https://api.openai.com/v1"  # Optional, defaults to OpenAI

# Optional: Tenderly Simulation Service
export TENDERLY_API_KEY="your_tenderly_api_key"
export TENDERLY_ACCOUNT_ID="your_tenderly_account_id"
export TENDERLY_PROJECT_SLUG="your_tenderly_project_slug"
```

### 4. Install Required Tools

#### Heimdall
Download and install [Heimdall](https://github.com/Jon-Becker/heimdall) binary and add it to your PATH.

#### Foundry (Optional)
For local transaction simulation, install [Foundry](https://book.getfoundry.sh/getting-started/installation):
```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### 5. Run the Tool

```bash
python3 main.py <transaction_hash>
```

## Manual Installation

If you prefer to install dependencies manually:

```bash
pip install pandas web3 requests openai numpy
```

## Development Setup

For development, install additional tools:

```bash
pip install pytest pytest-cov flake8 black
```

## Troubleshooting

### Common Issues

1. **Import Error**: Make sure you're running from the project root directory
2. **Heimdall not found**: Ensure Heimdall binary is in your PATH
3. **API Key errors**: Verify all environment variables are set correctly

### Testing

```bash
python -m pytest tests/
```

### Code Formatting

```bash
black src/ tests/
flake8 src/ tests/
``` 