import subprocess
import os
import sys

def run_heimdall(command, rpc_url=None, tx_hash=None, tx_dir=None):
    if rpc_url:
        command += ['--rpc-url', rpc_url]

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
