from dataclasses import dataclass
from typing import Callable
from eval.loader import load_scenarios
from api.schemas import SixRDecision

@dataclass
class RecResult:
    decision: SixRDecision
    reasoning: str

Recommender=Callable[[str],RecResult]

def run_harness(recommender: Recommender, scenarios=None) -> dict:
    """Evaluates a recommender system against our golden test scenarios."""
    scenarios = scenarios or load_scenarios()
    rows, passed = [], 0
    
    for s in scenarios:
        rec = recommender(s.app_id)
        
        # Verify decision match (either the ideal path or an acceptable alternative)
        ok_dec = rec.decision == s.expected_6r or rec.decision in s.acceptable_alternatives
        
        # Verify text reasoning contains mandatory technical keywords
        text = rec.reasoning.lower()
        ok_kw = all(k.lower() in text for k in s.must_mention_keywords)
        
        ok = ok_dec and ok_kw
        if ok:
            passed += 1
            
        rows.append((s.scenario_id, s.expected_6r, rec.decision, ok_dec, ok_kw, ok))
        
    acc = passed / len(scenarios) if scenarios else 0
    
    print(f"\n{'SCENARIO':28} {'EXPECTED':12} {'GOT':12} DEC KW PASS")
    print("-" * 65)
    for sid, exp, got, d, k, p in rows:
        print(f"{sid:28} {exp.value:12} {got.value:12} "
              f"{'✓' if d else '✗'}   {'✓' if k else '✗'}  {'PASS' if p else 'FAIL'}")
              
    print("-" * 65)
    print(f"Accuracy Target: {passed}/{len(scenarios)} = {acc:.0%}\n")
    return {"accuracy": acc, "passed": passed, "total": len(scenarios)}