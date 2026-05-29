# ModernizeIQ — Week 4 Daily Plan

> Source of truth for Week 4. Open this every morning before work, look at today's task, follow it step by step. If a step is unclear, that's a bug in this doc — fix it, don't power through.

---

## Context

### Where we are at the end of Week 3

- ✅ 50-app synthetic portfolio: 50 infra + 50 apps + 125 dependency edges + 50 metric rows + 202 security findings, committed as `data/seed.sql`
- ✅ Archetype-driven generator (`scripts/generate.py`) — legacy=worst, microservices=cleanest, the "story" holds
- ✅ NetworkX graph inspector — graph is one connected component, max in-degree 6 (no monster hubs)
- ✅ `make seed` / `make wipe-seed` / `make test`, integration smoke test green
- ✅ `data_design.md`, `dataset_qa.md`, `learning-log.md`, and this week's predecessor `week-3_plan.md`

### Three known defects carried in from Week 3 (fixed Monday)

1. **Archetype draw is skewed.** The `seed=42` draw gave Microservice **7** (target 12–13) and Compliance-Critical **10** (target 5). Your cleanest archetype is your rarest, and your deliberately-rare one is doubled. This bites _this week_ because eval scenarios are built by hand-picking apps per archetype.
2. **Reproducibility leak.** `discovered_date=fake.date_between(end_date="today")` resolves "today" at runtime — re-generate next week and the dates drift. The dataset claims reproducibility; this is the one place it isn't true.
3. **Environment isn't committed.** `.gitignore` excludes `pyproject.toml` and `uv.lock`, but the whole toolchain is `uv run`. A fresh clone can't reproduce the env — contradicts Week 1's "clone works on a fresh machine."

### Why Week 4 matters

The eval harness is the **definition of correct behavior** for everything you build in Phase 1. Without it, you'll tune prompts by vibes and have no way to know whether a change made the agent better or worse. The 20 scenarios you write this week are the test the AI has to pass — and the single strongest signal to a hiring manager that this is engineering, not a demo.

### What changed from the original PROJECT_PLAN.md

The original Week 4 was: Mon harness skeleton → Tue 7 scenarios → Wed learning → Thu 7 scenarios → Fri 6 scenarios + Phase 0 retro. That packing assumed Monday was free. It isn't — the dataset has to be stabilized _before_ any scenario pins an app ID, or every scenario breaks the moment you regenerate. So:

- **Monday is now dataset stabilization** (stratified archetypes + reproducibility + commit the env). This regenerates the portfolio — **all app IDs change**, which is exactly why it must happen before scenarios.
- **The original Monday harness task slides to Tuesday**, and scenario-writing moves to **Thu + Fri (10 each)**.
- **Consequence, stated honestly:** the **Phase 0 retrospective slides to the start of Week 5**, and Phase 1's first task (Anthropic API wrapper) moves back ~2 days. Net: Phase 0 closes about two days later than the original calendar. That is the roll-forward rule working as intended. **Do not absorb this on a weekend.** (You did Week 2 catch-up on a Saturday. Don't make it a habit — that's the exact mechanism the risk register says kills the project.)
- **Two small scope additions, both cheap and high-value** (rationale logged so it isn't silent scope creep): a **rules-based baseline recommender** so the harness produces a real number _today_ and gives Phase 1 a baseline to beat; and an **`acceptable_alternatives`** field on scenarios so genuinely ambiguous cases (Refactor-vs-Replace) aren't unfairly failed by exact-match.

---

## Operating reminders (read once Monday morning, then forget)

- **Task sizing:** every day is 1.5–2 hrs. Hit 2.5 hrs → stop and ask: missing a prerequisite? Need to split? Someone (or Claude) to unblock you?
- **Stuck protocol:** blocked >30 min on one error → document in `docs/blockers.md`, sleep on it, resume fresh.
- **60% rule:** 60% of weekday tasks = on track, 80% = ahead, <50% two weeks running = re-scope, no guilt.
- **Saturdays/Sundays:** buffer only. The plan stretching by two days is fine; weekend work is not.
- **This week's special rule:** Monday's regeneration is **destructive** — your old app IDs die. **Write zero scenarios before Monday is committed and pushed.**

---

# Monday — Dataset stabilization (2 hrs)

## Goal

The portfolio is frozen, well-distributed, and provably reproducible. After today, `app-xxxxxxxx` IDs never change again unless you deliberately re-roll — which means scenarios can safely pin them.

## Prerequisites

- Week 3 committed and pushed
- `docker ps` shows `pgvector_db` running

## Subtasks

### 1. Stratified archetype sampling (35 min)

Replace luck-based per-draw sampling with guaranteed quotas. In `scripts/generate.py`, add this and delete `pick_archetype()`:

```python
def build_archetype_plan(n: int, rng: random.Random) -> List[ArchetypeType]:
    """Guarantee each archetype its target share, then shuffle.
    Coverage no longer depends on the luck of the seed."""
    counts = {a: int(w * n) for a, w in ARCHETYPE_WEIGHTS}
    # hand the rounding remainder to the largest-weight archetypes
    remainder = n - sum(counts.values())
    for a, _ in sorted(ARCHETYPE_WEIGHTS, key=lambda x: x[1], reverse=True)[:remainder]:
        counts[a] += 1
    plan = [a for a, c in counts.items() for _ in range(c)]
    rng.shuffle(plan)
    return plan
```

Then in `generate_portfolio()`, swap the loop head:

```python
plan = build_archetype_plan(n, rng)          # was: for _ in range(n): archetype = pick_archetype(rng)
for archetype in plan:
    infra_row = make_infra(archetype, rng, fake)
    app_row   = make_app(archetype, infra_row, rng, fake)
    ...
```

For `n=50` this yields **16 / 12 / 10 / 7 / 5** — Microservices back up to 12, Compliance down to 5. Exactly the spec.

### 2. Pin the generation date (5 min)

Near the top of `generate.py`:

```python
GENERATION_DATE = date(2026, 5, 1)   # frozen so the dataset is reproducible across calendar days
```

In `generate_security_findings()`:

```python
discovered_date=fake.date_between(start_date="-2y", end_date=GENERATION_DATE),   # was end_date="today"
```

### 3. Commit the environment (10 min)

In `.gitignore`, delete the two lines that exclude `pyproject.toml` and `uv.lock`. Then:

```cmd
git add pyproject.toml uv.lock
```

A fresh clone + `uv sync` must now reproduce your exact environment.

### 4. Regenerate, re-inspect, re-dump (30 min)

```cmd
make wipe-seed
uv run python scripts\inspect_graph.py
docker exec pgvector_db pg_dump -U postgres -d mydb --data-only > data\seed.sql
```

Confirm in psql the distribution is now 16/12/10/7/5, and `inspect_graph.py` still shows one connected component with sane degrees.

### 5. Verify reproducibility for real (15 min)

```cmd
make wipe-seed
make psql
-- note 3 app IDs
make wipe-seed
make psql
-- the same 3 app IDs must appear
```

If they differ, the shuffle or Faker isn't seeded — check `fake.seed_instance(seed)` and that you used `rng`, never the global `random`.

### 6. Update README + commit (15 min)

Replace the README "Project Status" block with:

```markdown
**Current phase:** Phase 0 — Foundations

- Week 1: ✅ Complete
- Week 2: ✅ Complete — SQLAlchemy + Alembic, smoke tests
- Week 3: ✅ Complete — 50-app synthetic portfolio (deps, CVEs, metrics)
- Week 4: in progress — eval harness + 20 scenarios
```

```cmd
git add scripts/generate.py .gitignore pyproject.toml uv.lock data/seed.sql readme.md
git commit -m "fix(data): stratified archetypes + pinned generation date + commit env"
git push
```

## Verification: Done when…

- Distribution is 16/12/10/7/5
- Two consecutive `make wipe-seed` runs produce IDENTICAL app IDs
- `pyproject.toml` + `uv.lock` are tracked by git
- README status shows W1–W3 complete, W4 in progress
- Pushed

## If stuck >2 hrs

- **Remainder math off (sum ≠ n)** — print `counts` and the sum; the `int(w*n)` floors plus remainder loop must total `n`.
- **IDs still differ between runs** — the leak is almost always the global `random` module or an unseeded `Faker()`. Grep for bare `random.` and `Faker()` without `seed_instance`.

---

# Tuesday — Eval harness skeleton + runner + baseline (2 hrs)

## Goal

A harness that loads scenarios, runs any "recommender" against them, and prints a pass/fail report — and a trivial rules-based recommender so the harness produces a **real number today**, before any AI exists.

## Prerequisites

- Monday committed (frozen portfolio)
- `uv add pyyaml` (scenarios will be readable YAML, not buried in Python)

## Subtasks

### 1. Scenario schema (25 min)

`/eval/schema.py`:

```python
from pydantic import BaseModel, Field
from api.schemas import SixRDecision

class Scenario(BaseModel):
    scenario_id: str
    category: str                              # clear_rehost | clear_retire | clear_replace |
                                               # ambiguous_refactor_replace | retain |
                                               # dependency_blocked | replatform |
                                               # compliance_deferred | wildcard
    app_id: str                                # frozen ID from data/seed.sql
    expected_6r: SixRDecision
    acceptable_alternatives: list[SixRDecision] = Field(default_factory=list)
    must_mention_keywords: list[str] = Field(default_factory=list)
    rationale: str                             # WHY — for the human reader, not graded
```

### 2. Scenario loader (15 min)

`/eval/loader.py` — read every `*.yaml` in `/eval/scenarios/`, validate against `Scenario`:

```python
import yaml, pathlib
from eval.schema import Scenario

def load_scenarios(folder="eval/scenarios") -> list[Scenario]:
    out = []
    for f in sorted(pathlib.Path(folder).glob("*.yaml")):
        out.append(Scenario(**yaml.safe_load(f.read_text())))
    return out
```

### 3. The runner — decoupled from the (non-existent) orchestrator (35 min)

`/eval/harness.py`. The key design move: the runner takes a **recommender callable**, so it works with today's stub and tomorrow's real agent with zero changes.

```python
from dataclasses import dataclass
from typing import Callable
from eval.loader import load_scenarios
from api.schemas import SixRDecision

@dataclass
class RecResult:
    decision: SixRDecision
    reasoning: str

Recommender = Callable[[str], RecResult]      # app_id -> result

def run_harness(recommender: Recommender, scenarios=None) -> dict:
    scenarios = scenarios or load_scenarios()
    rows, passed = [], 0
    for s in scenarios:
        rec = recommender(s.app_id)
        ok_dec = rec.decision == s.expected_6r or rec.decision in s.acceptable_alternatives
        text = rec.reasoning.lower()
        ok_kw = all(k.lower() in text for k in s.must_mention_keywords)
        ok = ok_dec and ok_kw
        passed += ok
        rows.append((s.scenario_id, s.expected_6r, rec.decision, ok_dec, ok_kw, ok))
    acc = passed / len(scenarios) if scenarios else 0
    print(f"\n{'scenario':28} {'expected':12} {'got':12} dec kw pass")
    for sid, exp, got, d, k, p in rows:
        print(f"{sid:28} {exp.value:12} {got.value:12} "
              f"{'✓' if d else '✗'}   {'✓' if k else '✗'}  {'PASS' if p else 'FAIL'}")
    print(f"\nAccuracy: {passed}/{len(scenarios)} = {acc:.0%}")
    return {"accuracy": acc, "passed": passed, "total": len(scenarios)}
```

### 4. A rules-based baseline recommender (20 min)

`/eval/baseline.py` — crude, honest heuristics. This is the bar your LLM has to clear in Phase 1.

```python
from eval.harness import RecResult
from api.schemas import SixRDecision, ArchetypeType
from db.session import SessionLocal
from db.models import Application, Infrastructure, OperationalMetric, SecurityFinding
from datetime import date

def baseline_recommender(app_id: str) -> RecResult:
    with SessionLocal() as s:
        app = s.get(Application, app_id)
        infra = s.get(Infrastructure, app.infrastructure_id)
        om = s.query(OperationalMetric).filter_by(application_id=app_id).first()
        cves = s.query(SecurityFinding).filter_by(application_id=app_id).count()

    eol = infra.os_eol_date < date(2026, 5, 1)
    if app.archetype == ArchetypeType.INTERNAL_TOOL and om and om.incidents_last_quarter == 0:
        return RecResult(SixRDecision.RETIRE, "low usage, redundant, cost exceeds value")
    if app.archetype == ArchetypeType.MODERN_MICROSERVICE and cves <= 1:
        return RecResult(SixRDecision.RETAIN, "modern, clean, recently modernized")
    if app.archetype == ArchetypeType.COTS_VENDOR:
        return RecResult(SixRDecision.REPLACE, "vendor product, SaaS alternative exists")
    if eol and cves >= 3:
        return RecResult(SixRDecision.REFACTOR, "EOL OS, high CVE, complexity, security risk")
    return RecResult(SixRDecision.REHOST, "low complexity lift and shift")
```

Wire a CLI: `/scripts/run_eval.py` → `run_harness(baseline_recommender)`. Add `make eval`.

### 5. Run it (5 min)

It'll print 0/0 until you write scenarios Thursday — that's fine. The point is the plumbing runs clean.

## Verification: Done when…

- `make eval` runs without error (even with zero scenarios)
- The baseline recommender returns a `RecResult` for any app_id
- Schema + loader + runner are committed

## If stuck >2 hrs

- **Circular import (`eval` ↔ `db`)** — keep `RecResult` in `harness.py`, import it from `baseline.py`, not the reverse.
- **YAML enum parsing** — store decisions as plain strings (`RETIRE`) in YAML; Pydantic coerces to the enum on load.

---

# Wednesday — Learning: how to evaluate LLM systems (1.5 hrs)

## Goal

Understand what a _good_ eval looks like before you write 20 of them, so the scenarios are sharp instead of arbitrary.

## Subtasks

### 1. Read (45 min)

- Anthropic's docs on evaluating Claude / building evals, **or** Eugene Yan's "Patterns for Building LLM Applications."
- Focus on: golden-set evaluation, regression testing, why exact-match accuracy is necessary but not sufficient, and **calibration** (high-confidence answers should be right more often than low-confidence ones).

### 2. Notes in `learning-log.md` (30 min)

Answer in your own words:

- Why is a frozen golden set better than eyeballing outputs?
- Why does a single "expected" answer fail for genuinely ambiguous cases — and how does `acceptable_alternatives` help?
- What will you track _over time_ (accuracy, keyword hit-rate, calibration), and where will you store each run's report?

### 3. One design decision to write down (15 min)

Decide where eval reports live (`/eval/reports/<date>.json` is fine) so you can chart accuracy across Phase 1. Note it; build it later.

## Verification: Done when…

- Learning-log entry written
- You can explain why your baseline number from Tuesday is a _feature_, not an embarrassment

---

# Thursday — First 10 scenarios (2 hrs)

## Goal

10 scenarios written as YAML in `/eval/scenarios/`, each pinned to a real app from your frozen portfolio. Front-load the fast clear-cut ones.

## How to pick apps (this is the actual work)

Open `make psql` and query for candidates, then freeze the chosen `id` into the YAML.

```sql
-- clear-RETIRE: internal tools nobody uses
SELECT a.id, a.name, om.incidents_last_quarter, om.availability_pct
FROM applications a JOIN operational_metrics om ON om.application_id=a.id
WHERE a.archetype='INTERNAL_TOOL' ORDER BY om.incidents_last_quarter, om.availability_pct;

-- clear-REPLACE: COTS vendor products
SELECT id, name, runtime_version FROM applications WHERE archetype='COTS_VENDOR';

-- clear-REHOST: internal tool WITH usage, or a microservice needing a cloud move
SELECT a.id, a.name FROM applications a JOIN operational_metrics om ON om.application_id=a.id
WHERE a.archetype='INTERNAL_TOOL' AND om.incidents_last_quarter > 0;
```

## The 10 to write today

- **3 clear-Rehost** — internal tools with real usage / a microservice that just needs a region move. `expected_6r: REHOST`, keywords like `low complexity`, `lift and shift`.
- **2 clear-Retire** — internal tools, 0 incidents, redundant. `RETIRE`, keywords `low usage`, `cost`, `redundant`.
- **2 clear-Replace** — COTS vendor apps where SaaS has overtaken them. `REPLACE`, keywords `vendor`, `SaaS`, `off-the-shelf`.
- **3 ambiguous Refactor-vs-Replace** — legacy monoliths. Strategic (mission-critical) → `expected_6r: REFACTOR, acceptable_alternatives: [REPLACE]`; commodity → the reverse. Keywords `monolith`, `strategic` / `commercial alternative`.

YAML template (one file per scenario, e.g. `eval/scenarios/clear-retire-01.yaml`):

```yaml
scenario_id: clear-retire-01
category: clear_retire
app_id: app-xxxxxxxx # Internal-AssetTracker — 0 incidents, low availability tolerated
expected_6r: RETIRE
acceptable_alternatives: []
must_mention_keywords: [low usage, redundant, cost]
rationale: >
  Internal tool, zero incidents last quarter, no external users, capability
  duplicated elsewhere. Cost of keeping it alive exceeds its value. Textbook retire.
```

## Verification: Done when…

- 10 YAML files validate (run `make eval` — it now grades the baseline against them)
- Each `app_id` exists in `data/seed.sql`
- You noted the baseline's accuracy (this is your floor)

## If stuck >2 hrs

- **Can't find a clean candidate for an archetype** — that's Monday's stratification paying off; if an archetype is still thin, widen the query, don't invent an app.
- **Tempted to write the answer Claude would give** — don't. Write the answer the _data and business logic_ demand. The eval defines correct independently of any model.

---

# Friday — Final 10 scenarios + close the week (2 hrs)

## Goal

Reach 20 (floor: 16 — better 16 sharp ones than 20 rushed). Cover the remaining categories, the hard ones especially.

## The 10 to write today

- **2 Retain** — compliance-critical with data-residency lock, or recently-modernized. `RETAIN`, keywords `data residency` / `recently modernized`.
- **2 dependency-blocked** — an app that's individually ready but its upstream isn't. Use the graph:
  ```sql
  SELECT d.source_app_id, s.name AS source, d.target_app_id, t.name AS target, t.archetype
  FROM dependencies d
  JOIN applications s ON s.id=d.source_app_id
  JOIN applications t ON t.id=d.target_app_id
  WHERE t.archetype='LEGACY_MONOLITH';   -- healthy source pointing at a sick target
  ```
  `expected_6r: REHOST` (or RETAIN) **but** `must_mention_keywords: [dependency, upstream, blocked]` — the decision is gated on the blocker.
- **2 Replatform** — app on RHEL 7 (EOL 2024) that's otherwise fine, or self-hosted DB → managed. `REPLATFORM`, keywords `managed`, `minor changes`.
- **2 compliance-deferred** — compliance-critical apps where a regulatory/freeze window blocks this wave. `RETAIN` + keywords `compliance`, `freeze window`, `deferred`.
- **2 wildcards** — invent the edge cases that worry you: an app with conflicting signals (modern stack, terrible telemetry), or a node in a dependency cycle if your graph has one (`inspect_graph.py` told you).

## Then close the week (last 20 min)

```cmd
make eval                 # record final baseline accuracy
git add eval/ makefile pyproject.toml uv.lock
git commit -m "feat(eval): harness + baseline recommender + 20 golden scenarios"
git push
```

Update README: `Week 4: ✅ Complete — eval harness + N scenarios, baseline X%`.

**The Phase 0 retrospective does NOT happen today** — it's a 1-hour task at the start of Week 5 (see below). Don't cram it into a Friday that's already full.

## Verification: Done when…

- 16–20 scenarios across all categories validate and run
- `make eval` prints a final baseline accuracy number
- Every scenario has a `rationale` a stranger could read and agree with
- Pushed, README updated

## If stuck >2 hrs

- **Can't hit 20** — ship 16 and note the gap in the retro. The harness is useful at 16.
- **A scenario flaps** (passes/fails depending on tiny wording) — that's why `acceptable_alternatives` exists; loosen exact-match where the case is genuinely defensible two ways.

---

## Checkpoint: Week 4 Done

- [ ] Portfolio regenerated with stratified archetypes (16/12/10/7/5); reproducibility verified (2 runs → identical IDs)
- [ ] `GENERATION_DATE` pinned; `pyproject.toml` + `uv.lock` committed; README status updated
- [ ] `/eval/` has schema + loader + runner that takes a recommender callable
- [ ] Rules-based baseline recommender; `make eval` prints a real baseline number
- [ ] 16–20 scenarios across all 6 decisions + dependency-blocked + compliance-deferred + wildcards, each pinned to a frozen `app_id`
- [ ] Scenarios stored as readable YAML in `/eval/scenarios/`
- [ ] Phase 0 retrospective **scheduled** for W5 Monday (not crammed into Friday)
- [ ] All committed and pushed

---

## Common pitfalls (read once, recognize when you see them)

- **Writing scenarios against pre-Monday app IDs** — they all die on regeneration. Freeze Monday first. (This is why Monday is Monday.)
- **Over-fitting to the imagined model** — the expected answer comes from the data, not from guessing Claude. The eval is the spec; the model is the thing being tested against it.
- **Making everything clear-cut** — if no scenario is ambiguous, the harness can't tell a good system from a lucky one. Keep the hard cases hard; that's where `acceptable_alternatives` earns its place.
- **Brittle keyword matching** — lowercase substring match, and keep keywords to genuine must-haves (`cost`, not `the cost-benefit tradeoff`).
- **Treating the baseline number as failure** — a low baseline is the _point_. It's the floor your Phase 1 LLM has to beat, and the proof your harness discriminates.
- **Absorbing the 2-day slip on the weekend** — roll it forward into Week 5 instead.

---

## What Week 5 looks like (no need to plan it now)

Week 5 opens with the **Phase 0 retrospective** (~1 hr, slid from Week 4): what went well, what was harder than expected, are you ahead/behind, does Phase 1 need re-scoping. Then **Phase 1 — The Brain** begins: the Anthropic API wrapper and the Assessment Agent. Everything you built this week is the target the agent aims at — and the baseline recommender is the score it has to beat. The detailed Week 5 daily breakdown gets written at the end of Week 4, once you know your real scenario count and baseline accuracy.

---

_Document version: 1.0. Update freely — this is a living plan. Version every change._
