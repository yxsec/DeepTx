# ui_reconstruction_directory.py

import os
import sys
import json
from openai import OpenAI

# Initialize the Bianxie-compatible client
client = OpenAI(
    api_key="",
    base_url="https://api.bianxie.ai/v1"   
)

def ui_reconstruction(trace_text: str, html_code: str, js_code: str) -> list:
    """
    Extract UI elements and any JS variables referencing trace addresses.
    """
    system_prompt = (
        "Role: You are a blockchain UI extractor.\n"
        "Task: Given a transaction call trace, and the corresponding HTML and/or JavaScript code "
        "for a transaction confirmation UI, identify UI elements relevant to phishing detection or user guidance.  \n"
        "Additionally, if JavaScript code defines variables or constants that reference any of the addresses "
        "present in the trace, include them as separate entries in the report.\n"
        "If multiple elements or variables apply, include each as a separate object.\n"
        "When returning HTML or JavaScript in 'code_snippet', provide detailed, deobfuscated, human-readable code.\n"
        "Expected Output: A JSON array of objects, each with these fields:\n"
        "  - selector: CSS selector or element id/class, or variable name when element_type is 'variable'\n"
        "  - element_type: one of [\"link\", \"button\", \"input\", \"script\", \"variable\"]\n"
        "  - code_snippet: detailed HTML or deobfuscated JS snippet\n"
        "  - reason: why this element or variable is relevant in context of the trace\n"
        "Do not include any extra text outside the JSON."
    )

    parts = [f"Trace:\n{trace_text}"]
    if html_code.strip():
        parts.append(f"HTML:\n{html_code}")
    if js_code.strip():
        parts.append(f"JavaScript:\n{js_code}")
    user_prompt = "\n\n".join(parts)

    resp = client.chat.completions.create(
        model="gpt-3.5-turbo",
        messages=[
            {"role": "system", "content": system_prompt},
            {"role": "user",   "content": user_prompt}
        ]
    )

    try:
        elements = json.loads(resp.choices[0].message.content.strip())
    except json.JSONDecodeError:
        elements = []
    return elements

def analyze_ui_directory(dir_path: str) -> list:
    """
    Read trace.txt, all .html and .js files in dir_path,
    run ui_reconstruction, and return aggregated UI element list.
    """
    trace_path = os.path.join(dir_path, "trace.txt")
    if not os.path.isfile(trace_path):
        print("Error: trace.txt not found", file=sys.stderr)
        sys.exit(1)
    with open(trace_path, "r", encoding="utf-8") as f:
        trace_text = f.read()

    html_parts = []
    js_parts = []
    for fname in os.listdir(dir_path):
        path = os.path.join(dir_path, fname)
        if fname.lower().endswith(".html"):
            with open(path, "r", encoding="utf-8") as f:
                html_parts.append(f.read())
        elif fname.lower().endswith(".js"):
            with open(path, "r", encoding="utf-8") as f:
                js_parts.append(f.read())

    if not html_parts:
        print("Info: no .html files found, will proceed with JS only", file=sys.stderr)
    if not js_parts:
        print("Info: no .js files found, will proceed with HTML only", file=sys.stderr)

    html_code = "\n".join(html_parts)
    js_code = "\n".join(js_parts)

    return ui_reconstruction(trace_text, html_code, js_code)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python ui_reconstruction_directory.py <directory_path>", file=sys.stderr)
        sys.exit(1)

    directory = sys.argv[1]
    report = analyze_ui_directory(directory)

    output_file = os.path.join(directory, "ui_snip_report.json")
    with open(output_file, "w", encoding="utf-8") as f:
        json.dump(report, f, indent=2, ensure_ascii=False)

    print(f"Generated UI snippet report at: {output_file}")
