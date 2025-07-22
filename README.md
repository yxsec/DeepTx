# DeepTx

A comprehensive tool for analyzing Ethereum transactions with security assessment, multi-model LLM analysis, and consensus checking.

## Features

- **Transaction Analysis**: Complete transaction inspection and trace extraction
- **Contract Analysis**: Source code fetching and decompilation
- **Security Assessment**: Malicious address and pattern detection
- **Multi-Model LLM Analysis**: Analysis using multiple AI models
- **Consensus Engine**: Self-reflection and weighted voting algorithms
- **Comprehensive Reporting**: Detailed security assessment reports

## Quick Start

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd work
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Set up environment variables (required):
```bash
export HEIMDALL_API_KEY="your_heimdall_api_key"
export RPC_URL="your_ethereum_rpc_url"
export ETHERSCAN_API_KEY="your_etherscan_api_key"
export OPENAI_API_KEY="your_openai_api_key"
export OPENAI_BASE_URL="https://api.openai.com/v1"  # Optional, defaults to OpenAI
```

**Note**: All API keys are required. The tool will validate them at startup and provide clear error messages if any are missing.

### 4. Verify Environment Setup

Check if all environment variables are set correctly:

```bash
python3 check_env.py
```

### Usage

Run the complete analysis on a transaction:

```bash
python3 main.py <transaction_hash>
```

Example:
```bash
python3 main.py 0xff8e9226091d513fc936ecc670030eba03f34dbe60cd012122bd18be44248d32
```

### Analysis Process

The tool performs a 4-step analysis:

1. **Transaction Analysis**: Trace extraction, contract fetching, function analysis
2. **Security Check**: Malicious address and pattern detection
3. **Multi-Model LLM Analysis**: Analysis using GPT-4o-mini, GPT-3.5-turbo, and GPT-4o
4. **Final Report**: Consensus-based security assessment

### Output

Results are saved in `output/1/<transaction_hash>/`:
- `decoded_trace.json`: Transaction trace data
- `code.txt`: Extracted function code
- `asset_flows.csv`: Token transfer analysis
- `gas_usage.csv`: Gas consumption analysis
- `state_changes.csv`: State modification analysis
- `security_analysis_*.json`: Individual model reports
- `consensus_final_report.json`: Consensus analysis result
- `final_comprehensive_report.json`: Final comprehensive report

### Enhanced Security Analysis

The tool supports both interactive and file-based input for enhanced security analysis:

#### Interactive Mode (Default)
When running the analysis, the program will automatically prompt you for:
- **URLs to analyze**: Enter URLs one per line, press Enter twice to finish
- **JavaScript code to analyze**: Enter JavaScript code line by line, press Enter twice to finish

#### File-Based Mode (Optional)
You can pre-create these files in the transaction output directory:

1. **URL Analysis** (`output/1/<tx_hash>/url.txt`):
   ```
   https://example.com/suspicious-site
   http://malicious-domain.org
   https://phishing-site.com
   ```

2. **JavaScript Analysis** (`output/1/<tx_hash>/js.txt`):
   ```
   // JavaScript code to analyze for security patterns
   function suspiciousFunction() {
       // Code that will be checked for malicious patterns
   }
   ```

The tool will automatically detect existing files and skip the interactive prompts if files are found.

## Project Structure

```
open-source/
├── main.py                      # Main entry point
├── src/                         # Core modules
│   ├── transaction_analyzer.py  # Transaction analysis logic
│   ├── security_checker.py      # Security database checking
│   ├── llm_analyzer.py          # Multi-model LLM analysis
│   ├── consensus_engine.py      # Consensus algorithms
│   ├── llm_processor.py         # LLM query processing
│   ├── heimdall_client.py       # Heimdall integration
│   ├── contract_fetcher.py      # Contract source fetching
│   ├── simulation_service.py    # Unified simulation service (Foundry + Tenderly)
│   ├── foundry.py              # Foundry simulation service
│   └── TenderlyClient.py       # Tenderly simulation service
├── contracts/                   # Contract source code storage
├── output/                      # Analysis results
├── malicious_database/          # Security databases
├── cache/                       # Simulation cache directory
├── env.example                  # Environment variables template
├── check_env.py                 # Environment validation script
└── requirements.txt             # Python dependencies
```

## Core Modules

### transaction_analyzer.py
Core transaction analysis including trace extraction, contract fetching, and function analysis.

### security_checker.py
Security database checking for malicious addresses, suspicious patterns, and URLs.

### llm_analyzer.py
Multi-model LLM analysis using different AI models with comparison and consensus.

### consensus_engine.py
Consensus algorithms with self-reflection and weighted voting mechanisms.

### llm_processor.py
LLM query processing and enhanced feature analysis.

### heimdall_client.py
Heimdall CLI integration for transaction inspection.

### contract_fetcher.py
Contract source code fetching and decompilation.

### simulation_service.py
Unified simulation service that combines Foundry and Tenderly backends for transaction simulation.

### foundry.py
Foundry simulation service using cast run command for transaction simulation.

### TenderlyClient.py
Tenderly API integration for transaction simulation and analysis.

## Dependencies

- **pandas**: Data manipulation and analysis
- **web3**: Ethereum blockchain interaction
- **openai**: LLM API integration
- **requests**: HTTP requests
- **json**: JSON data processing

## Configuration

### Environment Variables

- `HEIMDALL_API_KEY`: API key for Heimdall service (required)
- `RPC_URL`: Ethereum RPC endpoint (optional, defaults to public endpoint)
- `ETHERSCAN_API_KEY`: Etherscan API key for contract fetching (required)
- `OPENAI_API_KEY`: OpenAI API key for LLM analysis (required)
- `OPENAI_BASE_URL`: OpenAI API base URL (optional, defaults to OpenAI)
- `TENDERLY_API_KEY`: Tenderly API key for simulation (optional)
- `TENDERLY_ACCOUNT_ID`: Tenderly account ID for simulation (optional)
- `TENDERLY_PROJECT_SLUG`: Tenderly project slug for simulation (optional)

### API Keys

The tool uses several external services:
- **Heimdall**: Transaction inspection and trace extraction
- **OpenAI**: LLM analysis (GPT-4o-mini, GPT-3.5-turbo, GPT-4o)
- **Etherscan**: Contract source code fetching
- **Tenderly**: Transaction simulation and analysis (optional)
- **Foundry**: Local transaction simulation using cast run (optional)

## Security Features

- **Malicious Address Detection**: Checks against known malicious addresses
- **Suspicious Pattern Recognition**: Identifies suspicious code patterns
- **URL Reputation Analysis**: Analyzes URLs for malicious content
- **JavaScript Security**: Detects malicious JavaScript patterns
- **Multi-Model Validation**: Uses multiple AI models for consensus

## Analysis Categories

The tool analyzes transactions across 4 categories:

1. **Behavior Analysis**: Function calls, asset movements, state changes
2. **Context Analysis**: Gas usage, transaction efficiency
3. **UI Analysis**: JavaScript code security
4. **Database Analysis**: Threat intelligence from security databases

## Risk Assessment

The tool provides risk levels:
- **Safe**: No security concerns detected
- **Suspicious**: Some concerning patterns but not clearly malicious
- **Malicious**: Clear evidence of malicious behavior
