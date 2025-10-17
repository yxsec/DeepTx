def build_security_schema(has_context: bool, has_malicious_db: bool):
    schema = {
        "type": "object",
        "properties": {
            "risk_level": {"type": "string", "enum": ["safe", "suspicious", "malicious"]},
            "confidence_score": {"type": "integer", "minimum": 0, "maximum": 100},
            "custom_scoring_criteria": {
                "type": "string",
                "description": "Detail the scoring criteria; weights sum to 1.0 and reasoning."
            },
            "explanation": {"type": "string"},
            "recommendations": {
                "type": "array",
                "items": {"type": "string"},
                "minItems": 1
            },
            "category_analysis": {
                "type": "object",
                "properties": {
                    "behavior_score": {"type": "integer", "minimum": 0, "maximum": 100},
                    "ui_score": {"type": "integer", "minimum": 0, "maximum": 100},
                },
                "required": ["behavior_score", "ui_score"],
                "additionalProperties": False
            }
        },
        "required": [
            "risk_level",
            "confidence_score",
            "custom_scoring_criteria",
            "explanation",
            "recommendations",
            "category_analysis",
        ],
        "additionalProperties": False
    }

    # context_score dynamic inclusion
    if has_context:
        schema["properties"]["category_analysis"]["properties"]["context_score"] = {
            "type": "integer", "minimum": 0, "maximum": 100
        }
        schema["properties"]["category_analysis"]["required"].append("context_score")

    # malicious_db_score dynamic inclusion
    if has_malicious_db:
        schema["properties"]["category_analysis"]["properties"]["malicious_db_score"] = {
            "type": "integer", "minimum": 0, "maximum": 100
        }
        schema["properties"]["category_analysis"]["required"].append("malicious_db_score")

    return schema


