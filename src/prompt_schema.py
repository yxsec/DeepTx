import copy
def build_security_schema(has_context: bool, has_malicious_db: bool):
    weight_reasoning_obj = {
        "type": "object",
        "properties": {
            "weight": {"type": "number", "minimum": 0.0, "maximum": 1.0},
            "reasoning": {"type": "string", "minLength": 1}
        },
        "required": ["weight", "reasoning"],
        "additionalProperties": False
    }
    schema = {
        "type": "object",
        "properties": {
            "risk_level": {"type": "string", "enum": ["safe", "suspicious", "malicious"]},
            "confidence_score": {"type": "integer", "minimum": 0, "maximum": 100},
            "custom_scoring_criteria": {
                "type": "object",
                "description": "Detailed scoring criteria with custom weights that sum to 1.0. Include weight for each category and reasoning for weight distribution.",
                "properties": {
                    "behavior_patterns": copy.deepcopy(weight_reasoning_obj),
                    "ui_javascript_security_indicators": copy.deepcopy(weight_reasoning_obj),
                },
                "required": [
                    "behavior_patterns",
                    "ui_javascript_security_indicators"
                ],
                "additionalProperties": False
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
        schema["properties"]["custom_scoring_criteria"]["properties"]["gas_efficiency_and_usage_patterns"] = (
            copy.deepcopy(weight_reasoning_obj)
        )
        schema["properties"]["custom_scoring_criteria"]["required"].append("gas_efficiency_and_usage_patterns")

        schema["properties"]["category_analysis"]["properties"]["context_score"] = {
            "type": "integer", "minimum": 0, "maximum": 100
        }
        schema["properties"]["category_analysis"]["required"].append("context_score")

    # malicious_db_score dynamic inclusion
    if has_malicious_db:
        schema["properties"]["custom_scoring_criteria"]["properties"]["database_threat_intelligence"] = (
            copy.deepcopy(weight_reasoning_obj)
        )
        schema["properties"]["custom_scoring_criteria"]["required"].append("database_threat_intelligence")

        schema["properties"]["category_analysis"]["properties"]["malicious_db_score"] = {
            "type": "integer", "minimum": 0, "maximum": 100
        }
        schema["properties"]["category_analysis"]["required"].append("malicious_db_score")

    return schema


