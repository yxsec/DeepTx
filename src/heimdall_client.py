import subprocess
import os
import sys
import re
from typing import List, Optional

def _validate_hex_string(value: str, name: str, expected_length: Optional[int] = None) -> None:
    """Validate that a string is a valid hex value."""
    if not value:
        return

    if not re.match(r'^0x[0-9a-fA-F]+$', value):
        raise ValueError(f"Invalid {name}: must be a hex string starting with 0x")

    if expected_length and len(value) != expected_length:
        raise ValueError(f"Invalid {name}: expected length {expected_length}, got {len(value)}")

def _validate_url(url: str) -> None:
    """Validate that a URL is safe and well-formed."""
    if not url:
        return

    # Basic URL validation - must start with http:// or https://
    if not re.match(r'^https?://', url):
        raise ValueError(f"Invalid RPC URL: must start with http:// or https://")

    # Prevent command injection through URL
    dangerous_chars = [';', '&', '|', '`', '$', '(', ')', '<', '>', '\n', '\r']
    if any(char in url for char in dangerous_chars):
        raise ValueError(f"Invalid RPC URL: contains dangerous characters")

def run_heimdall(command: List[str], rpc_url: Optional[str] = None, tx_hash: Optional[str] = None, tx_dir: Optional[str] = None) -> str:
    # Validate inputs to prevent command injection
    if tx_hash:
        _validate_hex_string(tx_hash, "transaction hash", 66)  # 0x + 64 hex chars

    if rpc_url:
        _validate_url(rpc_url)
        command += ['--rpc-url', rpc_url]

    # Validate command arguments
    allowed_commands = ['inspect', 'decompile', 'decode', 'disassemble', 'cfg']
    if command and command[0] not in allowed_commands:
        raise ValueError(f"Invalid heimdall command: {command[0]}. Allowed: {allowed_commands}")

    result = subprocess.run(
        ['heimdall'] + command + ['-q'],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )

    stdout = (result.stdout or "").strip()
    stderr = (result.stderr or "").strip()

    if result.returncode != 0:
        print(f"Command failed: {stderr}")
        sys.exit(1)

    output_to_return = stdout

    if tx_hash and command and command[0] == 'inspect':
        out_dir = tx_dir or "."  
        os.makedirs(out_dir, exist_ok=True)

        filtered_output_lines = []
        found = False
        for line in stdout.splitlines():
            if not found and "heimdall::inspect(" in line:
                found = True
            if found:
                filtered_output_lines.append(line)

        if not found:
            print("Could not find 'heimdall::inspect(' in stdout, saving full stdout instead.")
            filtered_output_lines = stdout.splitlines()
        output_to_return = "\n".join(filtered_output_lines)

    return output_to_return


def decompile_bytecode(bytecode, name='Contract', include_sol=True, include_yul=False, use_default=True, rpc_url=None, output=None):
    command = ['decompile', bytecode, '-n', name]

    if include_sol:
        command.append('--include-sol')
    if include_yul:
        command.append('--include-yul')
    if use_default:
        command.append('--default')

    if output:
        command += ['--output', output]

    return run_heimdall(command, rpc_url)


def inspect_transaction(tx_hash, api_key=None, rpc_url=None, tx_dir=None):
    command = ['inspect', tx_hash]
    if api_key:
        command += ['-t', api_key]

    output = run_heimdall(command, rpc_url, tx_hash, tx_dir)
    if not output:
        print(f"Failed to inspect transaction {tx_hash}")
        return None

    return output
