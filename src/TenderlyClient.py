import json
import os
import hashlib
import logging
import requests
from web3 import Web3
from deeptx.config import settings


logger = logging.getLogger(__name__)


def generate_query_hash(**kwargs) -> str:
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


class TenderlySimulator:
    def __init__(self, api_key, account_id, project_slug, cache_dir: str = None):
        """
        Args:
        api_key: Tenderly API key
        account_id: Tenderly account ID
        project_slug: Tenderly project slug
        """
        self.api_key = api_key
        self.base_url = f"https://api.tenderly.co/api/v1/account/{account_id}/project/{project_slug}/simulate"
        self.headers = {"X-Access-Key": api_key, "Content-Type": "application/json"}
        self.cache_dir = cache_dir
        if self.cache_dir and not os.path.exists(self.cache_dir):
            os.makedirs(self.cache_dir)

    def simulate_transaction(
        self,
        network_id: str,
        from_address: str,
        to_address: str,
        input_data: str,
        value="0x0",
        block_number=None,
    ):
        """
        Simulate Ethereum transaction and return raw response

        Args:
        from_address: Sender address
        to_address: Recipient address
        network_id: Network ID (e.g., 1 for Ethereum mainnet)
        input_data: Transaction input data
        value: Transaction value in wei
        gas: Gas limit
        gas_price: Gas price
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
        query_hash = generate_query_hash(
            **{k: v for k, v in simulation_body.items() if v is not None}
        )

        query_cache_file_path = os.path.join(self.cache_dir or "", f"{query_hash}.json")
        if self.cache_dir and os.path.exists(query_cache_file_path):
            with open(query_cache_file_path, "r", encoding="utf-8") as f:
                return json.load(f)

        response = requests.post(
            self.base_url, headers=self.headers, json=simulation_body
        )
        response.raise_for_status()
        # Return raw response directly
        data = response.json()
        if self.cache_dir:
            logger.info(f"Cache query result to {query_cache_file_path}")
            with open(query_cache_file_path, "w", encoding="utf-8") as f:
                json.dump(data, f)
        return data


def get_transaction_params_by_hash(rpc_url: str, tx_hash):
    # Initialize web3
    w3 = Web3(Web3.HTTPProvider(rpc_url))

    # Get transaction information
    tx = w3.eth.get_transaction(tx_hash)
    if not tx:
        raise ValueError(f"Transaction with hash {tx_hash} not found.")
    # # Get chain ID
    chain_id = w3.eth.chain_id
    # Construct parameter dictionary
    tx_params = {
        "from_address": tx["from"],
        "to_address": tx["to"],
        "network_id": chain_id,
        "input_data": "0x" + tx["input"].hex(),
        "value": hex(tx["value"]),  # Convert to hex string
        "block_number": tx["blockNumber"],
        # "gas": tx["gas"],
        # "gas_price": hex(tx["gasPrice"]),  # Convert to hex string
    }
    # print(tx_params)
    return tx_params




tenderly = TenderlySimulator(
    **settings.tenderly, cache_dir=os.path.join(settings.CACHE_DIR, "tenderly")
)
