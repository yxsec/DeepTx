import subprocess
import logging
import os

# Setup logging
logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(levelname)s - %(message)s")


def run_heimdall(command, rpc_url=None, tx_hash=None):
    """Run a heimdall command with optional RPC URL and selectively save trace output."""
    if rpc_url:
        command += ['--rpc-url', rpc_url]

    logging.info(f"Running: heimdall {' '.join(command)}")
    result = subprocess.run(
        ['heimdall'] + command,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True
    )

    stdout = result.stdout.strip()
    stderr = result.stderr.strip()

    if result.returncode != 0:
        logging.error(f"Command failed: {stderr}")

    if tx_hash and command[0] == 'inspect':
        tx_hash_clean = tx_hash.lower()
        out_dir = os.path.join("output", "1", tx_hash_clean)
        os.makedirs(out_dir, exist_ok=True)

        # Filter stdout from the first appearance of 'heimdall::inspect('
        filtered_output = ""
        found = False
        for line in stdout.splitlines():
            if not found and "heimdall::inspect(" in line:
                found = True
            if found:
                filtered_output += line + "\n"

        if not found:
            logging.warning("Could not find 'heimdall::inspect(' in stdout, saving full stdout instead.")
            filtered_output = stdout

        trace_path = os.path.join(out_dir, "trace.txt")
        with open(trace_path, "w", encoding="utf-8") as f:
            f.write(filtered_output)
        logging.info(f"[+] Saved raw trace output to {trace_path}")

    return stdout

def view_config(rpc_url=None):
    return run_heimdall(['config'], rpc_url)


def set_config(key, value, rpc_url=None):
    return run_heimdall(['config', key, value], rpc_url)


def disassemble_bytecode(bytecode, rpc_url=None):
    """Disassemble EVM bytecode."""
    return run_heimdall(['disassemble', bytecode], rpc_url)


def decode_calldata(target, explain=True, openai_api_key=None, use_default=True, rpc_url=None):
    """Decode calldata with optional explanation via OpenAI."""
    command = ['decode', target]
    if openai_api_key:
        command += ['-o', openai_api_key]  # This is the OpenAI API key, not output path
    if explain:
        command.append('--explain')
    if use_default:
        command.append('--default')
    return run_heimdall(command, rpc_url)


def decompile_bytecode(bytecode, name='Contract', include_sol=True, include_yul=False, use_default=True, rpc_url=None, output=None):
    """Decompile contract bytecode, optionally inferring output directory."""
    command = ['decompile', bytecode, '-n', name]

    if include_sol:
        command.append('--include-sol')
    if include_yul:
        command.append('--include-yul')
    if use_default:
        command.append('--default')

    if output is None:
        inferred = _infer_output_path_from_input(bytecode)
        if inferred:
            output = inferred

    if output:
        command += ['--output', output]  # ✅ Changed to --output instead of --out

    return run_heimdall(command, rpc_url)



def generate_cfg(bytecode, color_edges=True, output=None, rpc_url=None):
    """Generate CFG graph for bytecode."""
    command = ['cfg', bytecode]
    if color_edges:
        command.append('-c')

    if output is None:
        inferred = _infer_output_path_from_input(bytecode)
        if inferred:
            output = inferred

    if output:
        command += ['-o', output]

    return run_heimdall(command, rpc_url)


def dump_storage(target, api_key, from_block=None, to_block=None, chain='ethereum', no_tui=False, rpc_url=None):
    """Dump contract storage changes."""
    command = ['dump', target, '-t', api_key, '--chain', chain]
    if from_block:
        command += ['--from-block', from_block]
    if to_block:
        command += ['--to-block', to_block]
    if no_tui:
        command.append('--no-tui')
    return run_heimdall(command, rpc_url)


def inspect_transaction(tx_hash, api_key=None, rpc_url=None):
    """Inspect Ethereum transaction trace."""
    command = ['inspect', tx_hash]
    if api_key:
        command += ['-t', api_key]

    output = run_heimdall(command, rpc_url)
    if not output:
        logging.error(f"Failed to inspect transaction {tx_hash}")
        return None
    tx_dir = os.path.join("output", "1", tx_hash.lower())
    os.makedirs(tx_dir, exist_ok=True)
    trace_txt_path = os.path.join(tx_dir, "trace.txt")

    with open(trace_txt_path, "w", encoding="utf-8") as f:
        f.write(output)

    print(f"[+] Saved raw trace output to {trace_txt_path}")