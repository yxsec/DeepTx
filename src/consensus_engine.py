import json
import time
from typing import List, Dict, Any, Tuple
from openai import OpenAI
import os
from .prompt_schema import build_security_schema

class ConsensusChecker:
    def __init__(self, has_context, has_malicious_db, primary_model: str = "gpt-4o-mini"):
        """
        Initialize the consensus checker.
        
        Args:
            primary_model: Model to use for summarization and self-reflection
        """
        self.primary_model = primary_model
        self.has_context = has_context
        self.has_malicious_db = has_malicious_db
        
        # Validate API key
        api_key = os.environ.get("OPENAI_API_KEY")
        if not api_key:
            raise ValueError("OPENAI_API_KEY environment variable is required")
        
        self.client = OpenAI(
            api_key=api_key,
            base_url=os.environ.get("OPENAI_BASE_URL", "https://api.openai.com/v1")
        )
        self.max_rounds = 3
        
    def extract_risk_and_confidence(self, output: Dict[str, Any]) -> Tuple[str, float]:
        """
        Extract risk level and confidence from model output.
        
        Args:
            output: Model output dictionary
            
        Returns:
            Tuple of (risk_level, confidence_score)
        """
        risk_level = output.get("risk_level", "unknown")
        confidence_score = output.get("confidence_score", 0) / 100.0  # Convert to [0,1]
        return risk_level, confidence_score
    
    def check_consensus(self, outputs: List[Dict[str, Any]]) -> bool:
        """
        Check if all models agree on risk level.
        
        Args:
            outputs: List of model outputs
            
        Returns:
            True if all models agree, False otherwise
        """
        if len(outputs) < 2:
            return True
            
        risks = []
        for output in outputs:
            risk, _ = self.extract_risk_and_confidence(output)
            risks.append(risk)
        
        return len(set(risks)) == 1
    
    def summarize_outputs(self, outputs: List[Dict[str, Any]]) -> Dict[str, Any]:
        """
        Use primary model to summarize and synthesize final report.
        
        Args:
            outputs: List of model outputs to summarize
            
        Returns:
            Synthesized final report
        """
        # Prepare summary prompt
        summary_prompt = self._create_summary_prompt(outputs)
        schema = build_security_schema(self.has_context, self.has_malicious_db)
        try:
            response = self.client.chat.completions.create(
                model=self.primary_model,
                messages=[
                    {"role": "system", "content": "You are a blockchain security expert. Synthesize a unified security assessment from multiple model outputs."},
                    {"role": "user", "content": summary_prompt}
                ],
                temperature=0.1,
                response_format={
                    "type": "json_schema",
                    "json_schema": {
                        "name": "summary_security_assessment",
                        "schema": schema,
                        "strict": True,  
                    }
                },
            )
            
            result = response.choices[0].message.content
        
            final_report = json.loads(result)
            
            # Add consensus metadata
            final_report["consensus_metadata"] = {
                "consensus_reached": True,
                "rounds_used": 0,
                "method": "unanimous_agreement",
                "primary_model": self.primary_model,
                "timestamp": time.strftime("%Y-%m-%d %H:%M:%S")
            }
            
            return final_report
            
        except Exception as e:
            print(f"    ⚠ Summarization failed: {e}")
            # Fallback to first output
            return outputs[0]
    
    def self_reflect(self, own_output: Dict[str, Any], counter_outputs: List[Dict[str, Any]]) -> Dict[str, Any]:
        """
        Perform self-reflection by comparing own output with counter examples.
        
        Args:
            own_output: Model's own output
            counter_outputs: Outputs from other models
            
        Returns:
            Reflected/revised output
        """
        reflection_prompt = self._create_reflection_prompt(own_output, counter_outputs)
        schema = build_security_schema(self.has_context, self.has_malicious_db)
        try:
            response = self.client.chat.completions.create(
                model=self.primary_model,
                messages=[
                    {"role": "system", "content": "You are a blockchain security expert. Reflect on your analysis by considering other perspectives."},
                    {"role": "user", "content": reflection_prompt}
                ],
                temperature=0.1,
                response_format={
                    "type": "json_schema",
                    "json_schema": {
                        "name": "self_reflected_security_analysis",
                        "schema": schema,
                        "strict": True,  
                    }
                },
            )
            
            result = response.choices[0].message.content
            
            # Parse JSON response
            if "```json" in result:
                result = result.split("```json")[1].split("```")[0].strip()
            elif "```" in result:
                result = result.split("```")[1].strip()
            
            reflected_output = json.loads(result)
            
            # Preserve original metadata if present
            if "analysis_metadata" in own_output:
                reflected_output["analysis_metadata"] = own_output["analysis_metadata"]
                reflected_output["analysis_metadata"]["self_reflected"] = True
            
            return reflected_output
            
        except Exception as e:
            print(f"    ⚠ Self-reflection failed for model: {e}")
            # Return original output if reflection fails
            return own_output
    
    def weighted_voting(self, outputs: List[Dict[str, Any]]) -> Dict[str, Any]:
        """
        Perform weighted voting based on confidence scores.
        
        Args:
            outputs: List of model outputs
            
        Returns:
            Selected output based on weighted voting
        """
        # Initialize score map
        score_map = {"safe": 0, "suspicious": 0, "malicious": 0}
        
        # Calculate scores
        for output in outputs:
            risk, confidence = self.extract_risk_and_confidence(output)
            if risk in score_map:
                score_map[risk] += confidence
        
        # Find risk level with highest score
        max_score = max(score_map.values())
        selected_risk = max(score_map, key=score_map.get)
        
        # Select output with highest confidence for the selected risk level
        best_output = None
        best_confidence = 0
        
        for output in outputs:
            risk, confidence = self.extract_risk_and_confidence(output)
            if risk == selected_risk and confidence > best_confidence:
                best_output = output
                best_confidence = confidence
        
        if best_output:
            # Add voting metadata
            best_output["consensus_metadata"] = {
                "consensus_reached": False,
                "rounds_used": self.max_rounds,
                "method": "weighted_voting",
                "voting_scores": score_map,
                "selected_risk": selected_risk,
                "timestamp": time.strftime("%Y-%m-%d %H:%M:%S")
            }
        
        return best_output or outputs[0]
    
    def run_consensus_check(self, outputs: List[Dict[str, Any]]) -> Dict[str, Any]:
        """
        Run the complete consensus checking algorithm.
        
        Args:
            outputs: List of model outputs
            
        Returns:
            Final consensus decision
        """
        print(f"Starting consensus check with {len(outputs)} models...")
        
        try:
            # Round counter
            round_count = 0
            
            while round_count < self.max_rounds:
                print(f"  Round {round_count + 1}/{self.max_rounds}")
                
                # Check for consensus
                if self.check_consensus(outputs):
                    print(f"    ✓ Consensus reached! All models agree on risk level.")
                    return self.summarize_outputs(outputs)
                
                print(f"    ⚠ No consensus. Performing self-reflection...")
                
                # Perform self-reflection for each model
                reflected_outputs = []
                for i, output in enumerate(outputs):
                    counter_outputs = [o for j, o in enumerate(outputs) if j != i]
                    reflected_output = self.self_reflect(output, counter_outputs)
                    reflected_outputs.append(reflected_output)
                
                # Update outputs
                outputs = reflected_outputs
                round_count += 1
            
            # Fallback to weighted voting
            print(f"    ⚠ No consensus after {self.max_rounds} rounds. Using weighted voting.")
            return self.weighted_voting(outputs)
            
        except Exception as e:
            print(f"    ⚠ Consensus check failed: {e}")
            print(f"    ⚠ Falling back to weighted voting...")
            return self.weighted_voting(outputs)
    
    def _create_summary_prompt(self, outputs: List[Dict[str, Any]]) -> str:
        """Create prompt for summarizing multiple outputs."""
        prompt = """Synthesize a unified security assessment from the following model outputs.

Model Outputs:
"""
        for i, output in enumerate(outputs, 1):
            prompt += f"\nModel {i}:\n"
            prompt += f"Risk Level: {output.get('risk_level', 'unknown')}\n"
            prompt += f"Confidence: {output.get('confidence_score', 0)}%\n"
            prompt += f"Explanation: {output.get('explanation', '')}\n"
            prompt += f"Scoring Criteria: {output.get('custom_scoring_criteria', '')}\n"
            prompt += f"Category Analysis: {json.dumps(output.get('category_analysis', {}), indent=2)}\n"
        
        prompt += """

Create a unified report that:
1. Maintains the same JSON structure as the inputs
2. Combines the best insights from all models
3. Provides a consensus risk level and confidence score
4. Merges explanations and recommendations
5. Averages category scores appropriately
"""
        
        return prompt
    
    def _create_reflection_prompt(self, own_output: Dict[str, Any], counter_outputs: List[Dict[str, Any]]) -> str:
        """Create prompt for self-reflection."""
        prompt = f"""Reflect on your security analysis by considering other perspectives.

Your Analysis:
Risk Level: {own_output.get('risk_level', 'unknown')}
Confidence: {own_output.get('confidence_score', 0)}%
Explanation: {own_output.get('explanation', '')}
Scoring Criteria: {own_output.get('custom_scoring_criteria', '')}

Other Models' Analyses:
"""
        for i, output in enumerate(counter_outputs, 1):
            prompt += f"\nModel {i}:\n"
            prompt += f"Risk Level: {output.get('risk_level', 'unknown')}\n"
            prompt += f"Confidence: {output.get('confidence_score', 0)}%\n"
            prompt += f"Explanation: {output.get('explanation', '')}\n"
        
        prompt += """

Consider the following:
1. Do the other models raise valid points you may have missed?
2. Are there aspects of the transaction you should reconsider?
3. Should you adjust your confidence level based on other perspectives?
4. Are there additional security considerations you should include?

Provide a revised analysis in the same JSON format, incorporating insights from other models while maintaining your core reasoning. Only change your assessment if you find compelling evidence from other perspectives.
Among response: 
  "custom_scoring_criteria": "Revised scoring criteria",
  "explanation": "Revised explanation",
  "recommendations": ["Revised recommendations"],
"""
        
        return prompt

def run_consensus_analysis(model_outputs: List[Dict[str, Any]], has_context: bool, has_malicious_db: bool, primary_model: str = "gpt-4o-mini") -> Dict[str, Any]:
    checker = ConsensusChecker(has_context, has_malicious_db, primary_model)
    return checker.run_consensus_check(model_outputs)