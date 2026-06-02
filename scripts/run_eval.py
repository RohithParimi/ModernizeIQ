# scripts/run_eval.py
import os
import sys

project_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
if project_root not in sys.path:
    sys.path.append(project_root)

from eval.harness import run_harness
from eval.baseline import baseline_recommender

if __name__ == "__main__":
    print("🚀 Invoking ModernizeIQ Test Automation Harness...")
    run_harness(baseline_recommender)