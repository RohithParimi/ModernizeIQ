## Week 3 — Wednesday Graph QA Log

### Insights & Observations

- Successfully loaded the synthetic portfolio from PostgreSQL into a NetworkX DiGraph framework and rendered the topology via Matplotlib.
- The graph shows a clear central density hub around the core backend monoliths and COTS platforms, representing realistic enterprise "blast radius" profiles.
- Microservices successfully clustered together with higher out-degree values, while internal tools settled safely out on the periphery of the network map.

### Engineering Question for Later

- When analyzing large-scale enterprise graphs with thousands of applications instead of 50, how do architects handle visual clutter or partition the graph into distinct business domains without breaking the cross-domain dependency visibility?

## Evaluation Engineering & Golden Dataset Theory (Deep Dive)

### Question 1: What is a "Frozen Golden Set" and why is it mandatory for LLM Systems Engineering?
**Answer:** An LLM Golden Set is a static, curated collection of evaluation scenarios containing raw input context paired with predefined expected outcomes. Because Large Language Models are non-deterministic, small iterations made to a prompt or workflow to correct a single edge case can subtly trigger widespread regressions across unrelated scenarios. A frozen golden set transforms evaluation from arbitrary "vibes-based checking" into an empirical regression testing pipeline. It ensures that as our system evolves, the mathematical delta between actual outcomes and target expectations consistently narrows toward zero.

### Question 2: How do `acceptable_alternatives` protect our automated evaluation from becoming a "bad test"?
**Answer:** In enterprise system architecture and legacy software modernization, engineering decisions are rarely purely binary or single-faceted. Highly complex applications can legitimately justify multiple migration strategies (e.g., a strategic legacy monolith could be completely re-architected via REFACTORING, or entirely swapped out for a SaaS alternative via REPLACING). If an automation test harness enforces a single, hardcoded correct answer, it introduces brittle exact-match failures. By implementing an `acceptable_alternatives` safety-valve, the test suite embraces valid architectural ambiguity, evaluating the model's structural soundness rather than forcing it to guess a single hardcoded keyword string.

### Question 3: Where should evaluation run metrics be tracked over time, and what is the strategic value of this telemetry?
**Answer:** Evaluation run history reports must be systematically saved with an execution timestamp. In the immediate initialization phase, logging run summaries as timestamped payloads to a historical tracking file (`/eval/reports/history.json`) prevents environment setup bloat. Long-term, moving this time-series performance metadata into structured database tables allows engineers to map systemic optimization charts. This tracking provides a tangible mental model of system behavioral trends, demonstrating to engineering leaders that the platform's decision-making accuracy is continuously increasing.


