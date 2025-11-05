import json
import requests
from web3 import Web3
from .utils import retry_with_exponential_backoff

class TenderlySimulator:
    def __init__(self, api_key, account_id, project_slug):
        """
        Args:
        api_key: Tenderly API key
        account_id: Tenderly account ID
        project_slug: Tenderly project slug
        """
        self.api_key = api_key
        self.base_url = f"https://api.tenderly.co/api/v1/account/{account_id}/project/{project_slug}/simulate"
        self.headers = {"X-Access-Key": api_key, "Content-Type": "application/json"}

    @retry_with_exponential_backoff(max_retries=3, initial_delay=2.0, exceptions=(requests.RequestException, Exception))
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
        Simulate transaction and return raw response

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

        response = requests.post(
            self.base_url, headers=self.headers, json=simulation_body, timeout=30
        )

        if response.status_code != 200:
            error_msg = f"Tenderly API error: {response.status_code}"
            try:
                error_data = response.json()
                error_msg += f"\nDetails: {json.dumps(error_data, indent=2)}"
            except Exception as e:
                error_msg += f"\nResponse: {response.text}"
            raise Exception(error_msg)

        return response.json()


def get_transaction_params_by_hash(rpc_url: str, tx_hash):
    w3 = Web3(Web3.HTTPProvider(rpc_url))
    tx = w3.eth.get_transaction(tx_hash)
    if not tx:
        raise ValueError(f"Transaction with hash {tx_hash} not found.")

    chain_id = w3.eth.chain_id
    tx_params = {
        "from_address": tx["from"],
        "to_address": tx["to"],  
        "network_id": str(chain_id),           
        "input_data": tx["input"].hex(),      
        "value": hex(tx["value"]),
        "block_number": tx["blockNumber"],      
    }
    return tx_params