 #!/usr/bin/env python3
"""
Unified Simulation Service
==========================

This module provides a unified interface for transaction simulation using multiple backends:
- Foundry (cast run)
- Tenderly API
- Heimdall (transaction inspection)

Supports caching, multiple simulation types, and comprehensive transaction analysis.
"""

import subprocess
import shutil
import json
import os
import logging
import hashlib
import requests
from pathlib import Path
from typing import Dict, Any, Optional, Union
from web3 import Web3

# Configure logging
logger = logging.getLogger(__name__)


class FoundryService:
    """Service for Foundry-based transaction simulation using cast run."""
    
    def __init__(self, cache_dir: str = None):
        """
        Initialize the FoundryService.
        Checks if the Foundry's cast command exists in the system.
        
        Args:
            cache_dir: Directory for caching simulation results
        """
        self.cast_path = shutil.which("cast")
        if self.cast_path is None:
            logger.error("Foundry's 'cast' command not found")
            raise RuntimeError(
                "Foundry's 'cast' command not found. Please install Foundry: https://book.getfoundry.sh/getting-started/installation"
            )
        logger.info(f"Found cast command at: {self.cast_path}")

        self.cache_dir = cache_dir
        if self.cache_dir and not os.path.exists(self.cache_dir):
            os.makedirs(self.cache_dir)

    def simulate_transaction(
        self,
        tx_hash: str,
        rpc_url: str = None,
        quick: bool = True,
        json_output: bool = True,
        block: str = None,
        state: str = None,
        debug: bool = False,
        evm_version: str = None,
        extra_args: list = None,
        use_cache: bool = True,
    ) -> Union[Dict[str, Any], str]:
        """
        Execute 'cast run' command to simulate a transaction.

        Args:
            tx_hash: The transaction hash to simulate
            rpc_url: The RPC URL to use
            quick: Whether to use quick mode
            json_output: Whether to output the result as JSON
            block: The block to execute the call against
            state: The state to execute the call against
            debug: Whether to enable debug mode
            evm_version: The EVM version to use
            extra_args: Additional arguments to pass to the cast run command
            use_cache: Whether to use cache

        Returns:
            The result of the cast run command. Returns a dict if json_output is True, otherwise a string
        """
        logger.info(f"Foundry simulation called for tx: {tx_hash}")

        # Use only tx_hash as the cache key
        cache_file_path = (
            os.path.join(self.cache_dir, f"foundry_{tx_hash}.json") if self.cache_dir else None
        )

        # Check if cached result exists
        if use_cache and self.cache_dir and os.path.exists(cache_file_path):
            logger.info(f"Using cached Foundry result for tx: {tx_hash}")
            with open(cache_file_path, "r") as f:
                cached_data = json.load(f)
                return cached_data

        # If no cached result or cache is disabled, execute the command
        cmd = [self.cast_path, "run", tx_hash]

        if rpc_url:
            cmd.extend(["--rpc-url", rpc_url])
        if quick:
            cmd.append("--quick")
        if json_output:
            cmd.append("--json")

        if block:
            cmd.extend(["--block", block])

        if state:
            cmd.extend(["--state", state])

        if debug:
            cmd.append("--debug")

        if evm_version:
            cmd.extend(["--evm-version", evm_version])

        if extra_args:
            cmd.extend(extra_args)

        logger.info(f"Executing Foundry cast command for tx: {tx_hash}")

        try:
            result = subprocess.run(cmd, check=True, capture_output=True, text=True)

            if json_output:
                try:
                    data = json.loads(result.stdout)
                    # Cache the result if caching is enabled
                    if use_cache and self.cache_dir:
                        logger.info(f"Caching Foundry result for tx: {tx_hash}")
                        with open(cache_file_path, "w") as f:
                            json.dump(data, f)
                    return data
                except json.JSONDecodeError:
                    logger.warning(f"Failed to parse JSON output for tx: {tx_hash}")
                    # If JSON parsing fails, return the raw output
                    return result.stdout
            else:
                output = result.stdout
                # Cache the result if caching is enabled and output is JSON
                if use_cache and self.cache_dir and json_output:
                    try:
                        data = json.loads(output)
                        logger.info(f"Caching Foundry result for tx: {tx_hash}")
                        with open(cache_file_path, "w") as f:
                            json.dump(data, f)
                    except json.JSONDecodeError:
                        pass
                return output
        except subprocess.CalledProcessError as e:
            error_msg = f"Error executing Foundry cast run for tx {tx_hash}: {e.stderr}"
            logger.error(error_msg)
            raise RuntimeError(error_msg)


class TenderlyService:
    """Service for Tenderly-based transaction simulation."""
    
    def __init__(self, api_key: str, account_id: str, project_slug: str, cache_dir: str = None):
        """
        Initialize TenderlyService.
        
        Args:
            api_key: Tenderly API key
            account_id: Tenderly account ID
            project_slug: Tenderly project slug
            cache_dir: Directory for caching simulation results
        """
        self.api_key = api_key
        self.base_url = f"https://api.tenderly.co/api/v1/account/{account_id}/project/{project_slug}/simulate"
        self.headers = {"X-Access-Key": api_key, "Content-Type": "application/json"}
        self.cache_dir = cache_dir
        if self.cache_dir and not os.path.exists(self.cache_dir):
            os.makedirs(self.cache_dir)

    def _generate_query_hash(self, **kwargs) -> str:
        """
        Generate query hash for caching

        Args:
            **kwargs: Key-value pairs to include in hash calculation

        Returns:
            str: Query hash value
        """
        # Sort by keys to ensure same parameters generate same hash
        sorted_items = sorted(kwargs.items())
        # Convert parameters to string and concatenate
        param_str = "-".join([f"{k}:{v}" for k, v in sorted_items])
        return hashlib.sha256(param_str.encode()).hexdigest()

    def simulate_transaction(
        self,
        network_id: str,
        from_address: str,
        to_address: str,
        input_data: str,
        value: str = "0x0",
        block_number: int = None,
        use_cache: bool = True,
    ) -> Dict[str, Any]:
        """
        Simulate Ethereum transaction and return raw response

        Args:
            network_id: Network ID (e.g., 1 for Ethereum mainnet)
            from_address: Sender address
            to_address: Recipient address
            input_data: Transaction input data
            value: Transaction value in wei
            block_number: Block number to simulate against
            use_cache: Whether to use cache

        Returns:
            Dict containing simulation results
        """
        simulation_body = {
            "network_id": network_id,
            "from": from_address,
            "to": to_address,
            "input": input_data,
            "value": value,
            "block_number": block_number,
            "simulation_type": "full",
            "save": False,
        }

        # Generate query hash
        query_hash = self._generate_query_hash(
            **{k: v for k, v in simulation_body.items() if v is not None}
        )

        query_cache_file_path = os.path.join(self.cache_dir or "", f"tenderly_{query_hash}.json")
        if use_cache and self.cache_dir and os.path.exists(query_cache_file_path):
            with open(query_cache_file_path, "r", encoding="utf-8") as f:
                return json.load(f)

        response = requests.post(
            self.base_url, headers=self.headers, json=simulation_body
        )
        response.raise_for_status()
        
        # Return raw response directly
        data = response.json()
        if use_cache and self.cache_dir:
            logger.info(f"Cache Tenderly query result to {query_cache_file_path}")
            with open(query_cache_file_path, "w", encoding="utf-8") as f:
                json.dump(data, f)
        return data

    def simulate_transaction_by_hash(
        self, 
        tx_hash: str, 
        rpc_url: str, 
        use_cache: bool = True
    ) -> Dict[str, Any]:
        """
        Simulate transaction using transaction hash.
        
        Args:
            tx_hash: Transaction hash to simulate
            rpc_url: RPC URL to fetch transaction details
            use_cache: Whether to use cache
            
        Returns:
            Dict containing simulation results
        """
        # Initialize web3
        w3 = Web3(Web3.HTTPProvider(rpc_url))

        # Get transaction information
        tx = w3.eth.get_transaction(tx_hash)
        if not tx:
            raise ValueError(f"Transaction with hash {tx_hash} not found.")
        
        # Get chain ID
        chain_id = w3.eth.chain_id
        
        # Construct parameter dictionary
        tx_params = {
            "network_id": chain_id,
            "from_address": tx["from"],
            "to_address": tx["to"],
            "input_data": "0x" + tx["input"].hex(),
            "value": hex(tx["value"]),  # Convert to hex string
            "block_number": tx["blockNumber"],
        }
        
        return self.simulate_transaction(**tx_params, use_cache=use_cache)


class SimulationService:
    """Unified simulation service that combines multiple backends."""
    
    def __init__(self, cache_dir: str = "cache/simulation"):
        """
        Initialize the unified simulation service.
        
        Args:
            cache_dir: Base directory for caching simulation results
        """
        self.cache_dir = cache_dir
        if self.cache_dir and not os.path.exists(self.cache_dir):
            os.makedirs(self.cache_dir)
        
        # Initialize services
        self.foundry = None
        self.tenderly = None
        
        # Try to initialize Foundry service
        try:
            self.foundry = FoundryService(os.path.join(self.cache_dir, "foundry"))
            logger.info("Foundry service initialized successfully")
        except RuntimeError as e:
            logger.warning(f"Foundry service not available: {e}")
        
        # Try to initialize Tenderly service
        try:
            api_key = os.environ.get("TENDERLY_API_KEY")
            account_id = os.environ.get("TENDERLY_ACCOUNT_ID")
            project_slug = os.environ.get("TENDERLY_PROJECT_SLUG")
            
            if api_key and account_id and project_slug:
                self.tenderly = TenderlyService(
                    api_key, account_id, project_slug, 
                    os.path.join(self.cache_dir, "tenderly")
                )
                logger.info("Tenderly service initialized successfully")
            else:
                logger.warning("Tenderly service not available: missing environment variables")
        except Exception as e:
            logger.warning(f"Tenderly service not available: {e}")

    def simulate_with_foundry(
        self, 
        tx_hash: str, 
        rpc_url: str = None, 
        **kwargs
    ) -> Union[Dict[str, Any], str]:
        """
        Simulate transaction using Foundry.
        
        Args:
            tx_hash: Transaction hash to simulate
            rpc_url: RPC URL to use
            **kwargs: Additional arguments for Foundry simulation
            
        Returns:
            Simulation results
        """
        if not self.foundry:
            raise RuntimeError("Foundry service not available")
        
        return self.foundry.simulate_transaction(tx_hash, rpc_url=rpc_url, **kwargs)

    def simulate_with_tenderly(
        self, 
        tx_hash: str, 
        rpc_url: str = None, 
        **kwargs
    ) -> Dict[str, Any]:
        """
        Simulate transaction using Tenderly.
        
        Args:
            tx_hash: Transaction hash to simulate
            rpc_url: RPC URL to fetch transaction details
            **kwargs: Additional arguments for Tenderly simulation
            
        Returns:
            Simulation results
        """
        if not self.tenderly:
            raise RuntimeError("Tenderly service not available")
        
        if not rpc_url:
            rpc_url = os.environ.get("RPC_URL", "https://ethereum.therpc.io")
        
        return self.tenderly.simulate_transaction_by_hash(tx_hash, rpc_url, **kwargs)

    def simulate_transaction(
        self, 
        tx_hash: str, 
        backend: str = "auto", 
        rpc_url: str = None,
        **kwargs
    ) -> Union[Dict[str, Any], str]:
        """
        Simulate transaction using specified or auto-selected backend.
        
        Args:
            tx_hash: Transaction hash to simulate
            backend: Backend to use ("foundry", "tenderly", or "auto")
            rpc_url: RPC URL to use
            **kwargs: Additional arguments for simulation
            
        Returns:
            Simulation results
        """
        if backend == "foundry":
            return self.simulate_with_foundry(tx_hash, rpc_url, **kwargs)
        elif backend == "tenderly":
            return self.simulate_with_tenderly(tx_hash, rpc_url, **kwargs)
        elif backend == "auto":
            # Try Foundry first, then Tenderly
            if self.foundry:
                try:
                    return self.simulate_with_foundry(tx_hash, rpc_url, **kwargs)
                except Exception as e:
                    logger.warning(f"Foundry simulation failed: {e}")
            
            if self.tenderly:
                try:
                    return self.simulate_with_tenderly(tx_hash, rpc_url, **kwargs)
                except Exception as e:
                    logger.warning(f"Tenderly simulation failed: {e}")
            
            raise RuntimeError("No simulation backend available")
        else:
            raise ValueError(f"Unknown backend: {backend}")

    def get_available_backends(self) -> list:
        """
        Get list of available simulation backends.
        
        Returns:
            List of available backend names
        """
        backends = []
        if self.foundry:
            backends.append("foundry")
        if self.tenderly:
            backends.append("tenderly")
        return backends


# Global simulation service instance
simulation_service = SimulationService()