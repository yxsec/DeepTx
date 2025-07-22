"""
Ethereum Transaction Analysis Tool
=================================

A comprehensive tool for analyzing Ethereum transactions with security assessment,
multi-model LLM analysis, and consensus checking.

This package provides:
- Transaction analysis and trace extraction
- Contract source code fetching and decompilation
- Security database checking
- Multi-model LLM analysis
- Consensus algorithms with self-reflection
"""

__version__ = "1.0.0"
__author__ = "Ethereum Security Research Team"
__description__ = "Comprehensive Ethereum transaction analysis tool with security assessment"

# Import main functions for easy access
from .transaction_analyzer import run_transaction_analysis
from .security_checker import analyze_transaction_output
from .llm_analyzer import run_multi_model_analysis
from .consensus_engine import run_consensus_analysis, ConsensusChecker
from .heimdall_client import inspect_transaction
from .contract_fetcher import ContractFetcher, ContractDecompilerTool

__all__ = [
    'run_transaction_analysis',
    'analyze_transaction_output',
    'run_multi_model_analysis',
    'run_consensus_analysis',
    'inspect_transaction',
    'ConsensusChecker',
    'ContractFetcher',
    'ContractDecompilerTool'
] 