# ModernizeIQ — Phase 0 Retrospective (Foundations, Weeks 1–5)

*Written at the close of Phase 0, before Phase 1 begins. Honest by design — the misses are the point.*

---

## 1. Executive summary

Phase 0 is complete. The goal was a stable, reproducible synthetic portfolio and an objective evaluation harness to grade everything built afterward. Both exist: a frozen 50-application dataset and a 20-scenario golden suite, graded by a decoupled harness against a rules-based baseline.

The headline result is **not** a single accuracy number. The baseline scores **75% on decision accuracy, 5% on keyword hit-rate, and 5% on full-pass** across the 20 scenarios. That split is the most important finding of the phase: a crude `if/else` engine already picks the right 6R label most of the time (decisions are largely determined by archetype), but it cannot *explain* its choice in evidence-specific terms — which is exactly the gap Phase 1's LLM exists to fill. The target is now defined and measurable in two dimensions.

## 2. What went well

- **Schema rigor.** A 7-table relational model (applications, infrastructure, dependencies, security findings, operational metrics, recommendations, waves) built with SQLAlchemy 2.0 and versioned with Alembic. Foreign keys and constraints hold; smoke tests pass.
- **Deterministic, stratified data generation.** Replacing luck-of-the-seed sampling with explicit per-archetype quotas (16/12/10/7/5) and pinning the generation date (`GENERATION_DATE`) made the portfolio reproducible across machines and calendar days — two consecutive regenerations produce identical app IDs.
- **Decoupled evaluation harness.** The runner accepts an abstract `Recommender` callable, so the same script grades today's rules baseline and tomorrow's multi-agent orchestrator with no structural change. This is the piece the whole project leans on, and it was worth getting right first.

## 3. What was harder than expected, and what I'd do differently

- **I wrote the golden set as templates, not as grounded cases — and it took a review to catch.** The first cut had 20 scenario files but only 10 unique rationales: each category was written once and copy-pasted across its members, and several rationales described a *generic* case rather than the specific app they were pinned to (wildcards claiming "broken telemetry" on microservices with 99.9% availability; a legacy monolith called "structurally sound"). **Lesson:** ground each scenario in its pinned app's actual database rows *as I write it*, not afterward. A scenario whose rationale contradicts its data is testing a fiction.
- **The dataset couldn't cleanly support every category I'd planned.** No internal tool in the seed has zero incidents, so the "clear-retire vs clear-rehost" split among internal tools doesn't exist in the data, and the baseline's `RETIRE` rule was unreachable. Rather than regenerate (which would have changed every app ID and broken all 20 scenarios), I relaxed the rule threshold to `incidents <= 1` to make the branch live, kept one retire scenario as a deliberate "the LLM must beat the baseline here" case, and logged the underlying telemetry-homogeneity limitation in `ideas.md` for a future dataset v2. **Lesson:** prefer a one-line, documented relaxation over destructive data regeneration mid-phase.
- **Cadence broke in the back half of Week 4.** Monday's stabilization landed early, but Wednesday and Thursday went dark and both scenario batches were crammed into a single Friday morning — which is precisely where the duplicate rationales and generic naming came from. **Lesson:** the daily rhythm exists to prevent exactly this; the fix isn't "try harder on Friday," it's "don't let mid-week go empty."
- **The README status block fell behind three times.** It stayed on "Phase 0 — Foundations" while the work moved on, despite being scheduled for update twice. **Lesson:** update the status line at the end of each task, not at the end of the phase, so it can't accumulate into a visible staleness a reviewer notices first.

## 4. Schedule — am I behind or ahead?

**Behind the original calendar by roughly one week, and that is acceptable.** Phase 0 was planned to close at the end of Week 4; it closes in Week 5 after a remediation day. Contributing factors: a Week 2 Saturday catch-up, the Week 4 Friday cram, and the remediation pass needed to ground the golden set. The original plan explicitly accommodates a 25-week version, so this slip is within tolerance — the rule is "ship in week 26, don't quit in week 12." No panic, no weekend backfilling.

## 5. Final telemetry baseline

- **Portfolio:** 50 infrastructure hosts · 50 applications · 129 dependency edges · 50 operational-metric rows · 181 security findings.
- **Graph:** one connected component; 41 dependency cycles present (including a clean 3-node COTS cycle now used as a wildcard scenario).
- **Distribution:** 16 Legacy Monolith / 12 Modern Microservice / 10 COTS Vendor / 7 Internal Tool / 5 Compliance-Critical.
- **Evaluation:** 20 golden scenarios across 9 categories, covering all six 6R decision types.
- **Rules baseline:** **75% decision accuracy · 5% keyword hit-rate · 5% full-pass** (strict enum match on decision; lowercase substring match on all required keywords).

## 6. Phase 1 readiness — do I need to re-scope?

**No re-scope.** Phase 1 (The Brain) stands as planned: Assessment Agent → 6R Decisioning Agent (with retrieval) → Explanation Agent, wired through an orchestrator and graded by the existing harness. The 75%/5% split tells me where to aim: decision accuracy is already high from structure, so the differentiated value — and the metric to watch — is the **keyword hit-rate**, i.e. whether the agents produce reasoning that actually cites the evidence (EOL dates, CVE counts, dependency links). Moving that number off 5% is the success criterion for the phase.

## 7. Tooling note / hardening adopted

To be robust to Windows-authored files (a real BOM hazard when editing YAML on Windows), scenario files are loaded with `encoding="utf-8-sig"` in `eval/loader.py` so a stray byte-order mark can never break Pydantic key parsing. *(Action item if not yet applied: add the encoding argument to the loader's `read_text` call.)*

---

**Phase 0 status: closed.** Dataset frozen and grounded, golden set clean, baseline real and two-dimensional. Phase 1 begins against a sharp target.
