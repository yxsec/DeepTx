import os
import sys
import json
from openai import OpenAI

# ---- Config ----
api_key = os.environ.get("OPENAI_API_KEY")
if not api_key:
    raise ValueError("OPENAI_API_KEY environment variable is required")

MODEL = os.environ.get("OPENAI_MODEL", "gpt-4o-mini-2024-08-06")
BASE_URL = os.environ.get("OPENAI_BASE_URL", "https://api.openai.com/v1")

client = OpenAI(api_key=api_key, base_url=BASE_URL)

# ---- JSON Schema for response_format ----
# We want a top-level JSON array of objects with strict fields.
UI_ELEMENTS_SCHEMA = {
    "name": "ui_elements_array",
    "strict": True,
    "schema": {
        "type": "array",
        "items": {
            "type": "object",
            "additionalProperties": False,
            "properties": {
                "selector": {
                    "type": "string",
                    "description": "CSS selector, id/class, or the variable name when element_type is 'variable'."
                },
                "element_type": {
                    "type": "string",
                    "enum": ["link", "button", "input", "script", "variable"],
                    "description": "Type of the extracted UI element or variable."
                },
                "code_snippet": {
                    "type": "string",
                    "description": "Deobfuscated, human-readable HTML/JS snippet of the element or variable definition."
                },
                "reason": {
                    "type": "string",
                    "description": "Why this item matters for phishing detection or user guidance in context of the trace."
                }
            },
            "required": ["selector", "element_type", "code_snippet", "reason"]
        }
    }
}

def ui_reconstruction(trace_text: str, html_code: str, js_code: str) -> list:
    """
    Extract UI elements and any JS variables referencing trace addresses.
    The model response is constrained by response_schema to a strict JSON array.
    """
    system_prompt = (
        "Role: You are a blockchain UI extractor.\n"
        "Task: Given a transaction call trace, and the corresponding HTML and/or JavaScript code "
        "for a transaction confirmation UI, identify UI elements relevant to phishing detection or user guidance.\n"
        "Additionally, if JavaScript code defines variables or constants that reference any of the addresses "
        "present in the trace, include them as separate entries in the report (use element_type = 'variable').\n"
        "If multiple elements or variables apply, include each as a separate object.\n"
        "When returning HTML or JavaScript in 'code_snippet', provide detailed, deobfuscated, human-readable code.\n"
        "Output MUST be a JSON array matching the provided response schema. No extra text."
    )

    parts = [f"Trace:\n{trace_text}"]
    if html_code.strip():
        parts.append(f"HTML:\n{html_code}")
    if js_code.strip():
        parts.append(f"JavaScript:\n{js_code}")
    user_prompt = "\n\n".join(parts)

    # Use response_format with a JSON schema to strictly enforce structure.
    resp = client.chat.completions.create(
        model=MODEL,
        messages=[
            {"role": "system", "content": system_prompt},
            {"role": "user",   "content": user_prompt}
        ],
        response_format={
            "type": "json_schema",
            "json_schema": UI_ELEMENTS_SCHEMA
        },
        temperature=0
    )

    content = resp.choices[0].message.content
    try:
        # When response_format enforces schema, content is valid JSON matching the schema.
        elements = json.loads(content)
        if isinstance(elements, list):
            return elements
        # Fallback: if model wraps it unexpectedly
        return []
    except json.JSONDecodeError:
        return []

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
    try:
        for fname in os.listdir(dir_path):
            path = os.path.join(dir_path, fname)
            if not os.path.isfile(path):
                continue
            low = fname.lower()
            if low.endswith(".html"):
                with open(path, "r", encoding="utf-8") as f:
                    html_parts.append(f.read())
            elif low.endswith(".js"):
                with open(path, "r", encoding="utf-8") as f:
                    js_parts.append(f.read())
    except Exception as e:
        print(f"Error reading directory: {e}", file=sys.stderr)
        sys.exit(1)

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
