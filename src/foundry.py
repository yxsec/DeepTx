import subprocess
import shutil
import json
import os
import logging

from deeptx.config import settings

# Configure logging
logger = logging.getLogger(__name__)


class FoundryService:
    def __init__(self, cache_dir):
        """
        Initialize the FoundryService.
        Checks if the Foundry's cast command exists in the system.
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

    def cast_run(
        self,
        tx_hash,
        rpc_url=None,
        quick=True,
        json_output=True,
        block=None,
        state=None,
        debug=False,
        evm_version=None,
        extra_args=None,
        use_cache=True,
    ):
        """
        Execute 'cast run' command to simulate a transaction.

        Args:
            tx_hash (str): The transaction hash to simulate.
            rpc_url (str, optional): The RPC URL to use.
            json_output (bool, optional): Whether to output the result as JSON. Defaults to True.
            block (str, optional): The block to execute the call against.
            state (str, optional): The state to execute the call against.
            debug (bool, optional): Whether to enable debug mode. Defaults to False.
            evm_version (str, optional): The EVM version to use.
            extra_args (list, optional): Additional arguments to pass to the cast run command.
            use_cache (bool, optional): Whether to use cache. Defaults to True.

        Returns:
            dict or str: The result of the cast run command. Returns a dict if json_output is True, otherwise a string.
        """
        logger.info(f"Cast run called for tx: {tx_hash}")

        # Use only tx_hash as the cache key
        cache_file_path = (
            os.path.join(self.cache_dir, f"{tx_hash}.json") if self.cache_dir else None
        )

        # Check if cached result exists
        if use_cache and self.cache_dir and os.path.exists(cache_file_path):
            logger.info(f"Using cached result for tx: {tx_hash}")
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

        logger.info(f"Executing cast command for tx: {tx_hash}")

        try:
            result = subprocess.run(cmd, check=True, capture_output=True, text=True)

            if json_output:
                try:
                    data = json.loads(result.stdout)
                    # Cache the result if caching is enabled
                    if use_cache and self.cache_dir:
                        logger.info(f"Caching result for tx: {tx_hash}")
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
                        logger.info(f"Caching result for tx: {tx_hash}")
                        with open(cache_file_path, "w") as f:
                            json.dump(data, f)
                    except json.JSONDecodeError:
                        pass
                return output
        except subprocess.CalledProcessError as e:
            error_msg = f"Error executing cast run for tx {tx_hash}: {e.stderr}"
            logger.error(error_msg)
            raise RuntimeError(error_msg)


foundry = FoundryService(os.path.join(settings.CACHE_DIR, "foundry"))
