# ModernizeIQ — Week 5 Daily Plan (Phase 1 begins: The Brain)

> Monday this week was Phase 0 remediation + the retrospective — Phase 0 is closed. The rest of the week starts Phase 1. Open this each morning, do the day's task, slide it if life gets in the way. Don't backfill onto the weekend.

---

## Context

### Where we are
Phase 0 shipped a frozen 50-app portfolio, a 20-scenario golden set, and a decoupled harness with a rules baseline scoring **75% decision / 5% keyword / 5% full-pass**. That split is the target: decisions are already mostly right from structure; the job of The Brain is to produce *reasoning that cites real evidence*, which is what moves the 5% keyword hit-rate.

### What Phase 1 builds (Weeks 5–8)
A pipeline of three agents — **Assess → 6R → Explain** — wired through an orchestrator and graded by the existing harness. This week is **stage one only: the Assessment Agent.** It reads one app's full context and emits a structured readiness assessment that the 6R and Explanation agents will consume in Weeks 6–7.

### Honest expectation for this week
**The eval number will not move yet, and that's correct.** The harness grades a 6R decision + keywords; the Assessment Agent produces a readiness score and risk factors, not a 6R decision, so it can't plug into the harness as a recommender. The needle moves in Week 7 once the full pipeline exists. This week's deliverable is a *working, schema-validated Assessment Agent* — the first real piece of AI in the project.

### Model choice (decided, so you don't have to)
Use **`claude-sonnet-4-6`** as the default. It's the recommended production default — strong reasoning at ~$3/$15 per million tokens — and you'll call it many times across the eval set, so cost matters. (Do **not** use `claude-sonnet-4-20250514`; Sonnet 4 was retired in April 2026.) Bump a specific call to `claude-opus-4-8` only if a hard reasoning case clearly needs it. Running the agent on 5 apps costs single-digit cents.

### This week's rhythm
- **Mon** — done (remediation + retro)
- **Tue** — build: API wrapper + application-context assembler
- **Wed** — learning/light: structured outputs + lock the `AssessmentResult` contract
- **Thu** — build: implement the Assessment Agent
- **Fri** — wrap: run on 5 apps, eyeball, commit
- **Sat/Sun** — buffer only

---

# Tuesday — Anthropic wrapper + context assembler (2 hrs)

## Goal
A thin, reusable `call_claude()` wrapper that makes a real API call, and a function that assembles one application's complete context from the database into a single object the agent can reason over.

## Prerequisites
- `docker ps` shows `pgvector_db` up; `make seed` has been run
- An Anthropic API key

## Subtasks

### 1. Wire the key + deps (15 min)
```cmd
uv add anthropic python-dotenv
echo ANTHROPIC_API_KEY=sk-ant-...>> .env
```
Confirm `.env` is gitignored (it should already be). Never commit the key.

### 2. The wrapper — `agents/llm.py` (30 min)
```python
import os
import anthropic
from dotenv import load_dotenv

load_dotenv()
_client = anthropic.Anthropic()          # reads ANTHROPIC_API_KEY from env

DEFAULT_MODEL = "claude-sonnet-4-6"

def call_claude(prompt: str, system: str = "", model: str = DEFAULT_MODEL,
                max_tokens: int = 1024) -> str:
    """One call, returns the concatenated text. Keep it dumb; agents own the prompting."""
    resp = _client.messages.create(
        model=model,
        max_tokens=max_tokens,
        system=system,
        messages=[{"role": "user", "content": prompt}],
    )
    return "".join(b.text for b in resp.content if b.type == "text")
```

### 3. Smoke test (10 min)
```cmd
uv run python -c "from agents.llm import call_claude; print(call_claude('What is 2+2? Reply with only the number.'))"
```
You want `4`. If you get an auth error, the key isn't loading — check `.env` is in the repo root and `load_dotenv()` ran.

### 4. The context assembler — extend `api/schemas.py` (50 min)
The agent needs one app's whole story in one object. Add an aggregate schema:
```python
class ApplicationContext(BaseModel):
    application: ApplicationSchema
    infrastructure: InfrastructureSchema
    metrics: Optional[OperationalMetricSchema] = None
    security_findings: List[SecurityFindingSchema] = Field(default_factory=list)
    dependencies_out: List[DependencySchema] = Field(default_factory=list)
    model_config = {"from_attributes": True}
```
Then a builder in `agents/context.py` that queries the DB and fills it:
```python
from db.session import SessionLocal
from db.models import Application, Infrastructure, OperationalMetric, SecurityFinding, Dependency
from api.schemas import ApplicationContext

def build_application_context(app_id: str) -> ApplicationContext:
    with SessionLocal() as s:
        app = s.get(Application, app_id)
        if not app:
            raise ValueError(f"No application {app_id}")
        infra = s.get(Infrastructure, app.infrastructure_id)
        om = s.query(OperationalMetric).filter_by(application_id=app_id).first()
        cves = s.query(SecurityFinding).filter_by(application_id=app_id).all()
        deps = s.query(Dependency).filter_by(source_app_id=app_id).all()
        return ApplicationContext.model_validate({
            "application": app, "infrastructure": infra,
            "metrics": om, "security_findings": cves, "dependencies_out": deps,
        })
```

### 5. Eyeball one context (15 min)
```cmd
uv run python -c "from agents.context import build_application_context; print(build_application_context('app-f91e1d4c').model_dump_json(indent=2))"
```
(`app-f91e1d4c` is the worst-security monolith — a rich context to look at.) Confirm infra, CVEs, metrics, and outgoing deps are all present.

## Done when
- `call_claude('…')` returns real text
- `build_application_context(app_id)` returns a fully-populated object for any frozen app
- `agents/llm.py` and `agents/context.py` committed (key is **not**)

## If stuck >2 hrs
- **Auth/keys:** print `bool(os.getenv("ANTHROPIC_API_KEY"))` — if False, `.env` isn't being read.
- **`from_attributes` errors:** that flag must be on every nested schema (it already is in `api/schemas.py`); `model_validate` on the ORM objects needs it.

---

# Wednesday — Learning + lock the contract (1.5 hrs)

## Goal
Understand how to get *reliable* structured output from an LLM before you build the agent, then nail down the agent's output schema.

## Subtasks

### 1. Read (40 min)
- Anthropic docs on structured outputs / tool use for JSON, and prompt patterns for "return only JSON."
- The one principle to internalize: **never trust the model to return clean JSON — always validate against a schema and retry on failure.** Markdown fences (` ```json `) are the most common contaminant.
- Notes in `docs/learning-log.md`: what JSON mode buys you, why Pydantic validation is the real guardrail, and when tool-based structured output is worth it (answer: Phase 4 hardening, not now).

### 2. Define `AssessmentResult` — `api/schemas.py` (35 min)
This is the agent's contract. Keep it tight and gradeable:
```python
class AssessmentFactor(BaseModel):
    name: str                 # e.g. "Operating system lifecycle"
    evidence: str             # the actual data point, e.g. "RHEL 7, EOL 2024-06-30"
    impact: str               # "high" | "medium" | "low"

class AssessmentResult(BaseModel):
    readiness_score: int = Field(ge=0, le=100, description="0 = urgent/complex, 100 = clean/ready")
    risk_areas: List[str] = Field(description="short risk labels")
    factors: List[AssessmentFactor] = Field(description="evidence-cited drivers of the score")
    summary: str = Field(description="2-3 sentence plain-language read")
```
The `evidence` field is deliberate: it forces the model to cite a real data point per factor, which is the habit the Explanation Agent will build on to lift that keyword hit-rate.

### 3. Write down one decision (15 min)
In `ideas.md` or a short `docs/agents.md`: note that v1 uses prompt-and-validate-with-retry, and tool-based structured output is deferred to Phase 4. Documenting the deliberate "good enough for now" keeps it from looking like an oversight later.

## Done when
- Learning-log entry written in your own words
- `AssessmentResult` + `AssessmentFactor` committed
- You can state why every factor must carry `evidence`

---

# Thursday — Implement the Assessment Agent (2 hrs)

## Goal
`AssessmentAgent.run(context) -> AssessmentResult` that calls Claude, validates the output against the schema, and retries once on failure.

## Subtasks

### 1. The agent — `agents/assessment.py` (75 min)
```python
import re
from pydantic import ValidationError
from agents.llm import call_claude
from api.schemas import ApplicationContext, AssessmentResult

SYSTEM = (
    "You are a meticulous enterprise application-modernization assessor. "
    "You score modernization readiness from evidence only, never speculation. "
    "Every factor you list must cite a concrete data point from the provided context."
)

PROMPT = """Assess this application's modernization readiness.

Return ONLY a JSON object matching this exact schema — no markdown, no prose, no code fences:
{schema}

Scoring guidance: a low readiness_score means urgent and/or complex to modernize
(EOL OS, many CVEs, high incidents); a high score means clean and low-risk.

Application context:
{context}
"""

def _strip_fences(text: str) -> str:
    return re.sub(r"^```(json)?|```$", "", text.strip(), flags=re.MULTILINE).strip()

class AssessmentAgent:
    def run(self, ctx: ApplicationContext) -> AssessmentResult:
        prompt = PROMPT.format(
            schema=AssessmentResult.model_json_schema(),
            context=ctx.model_dump_json(indent=2),
        )
        raw = call_claude(prompt, system=SYSTEM)
        try:
            return AssessmentResult.model_validate_json(_strip_fences(raw))
        except ValidationError as e:
            retry = call_claude(
                prompt + f"\n\nYour previous reply failed validation:\n{e}\n"
                         f"Return corrected JSON only.",
                system=SYSTEM,
            )
            return AssessmentResult.model_validate_json(_strip_fences(retry))
```

### 2. Run it once, end to end (30 min)
```cmd
uv run python -c "from agents.context import build_application_context as C; from agents.assessment import AssessmentAgent; print(AssessmentAgent().run(C('app-f91e1d4c')).model_dump_json(indent=2))"
```
Read the output. For the worst-security monolith you'd expect a **low** readiness score, risk areas naming EOL + CVEs, and factors that cite the actual EOL date and CVE count. If the score is high, your prompt isn't conveying the scoring direction — tighten it.

### 3. Guard the obvious failure (15 min)
Confirm the retry path works by temporarily pointing `model` at something cheap or by eyeballing that a fenced reply still parses (the `_strip_fences` handles the common case). Don't over-engineer; one retry is the contract.

## Done when
- `AssessmentAgent().run(ctx)` returns a valid `AssessmentResult` for any app
- Output validates against the schema (no manual JSON fixing)
- Committed

## If stuck >2 hrs
- **Validation keeps failing:** print the `raw` text — it's almost always wrapped in ```json fences or has a trailing comment. Strengthen `_strip_fences` or make the "ONLY JSON" instruction louder.
- **Score feels arbitrary:** add 2–3 worked anchors to the prompt ("EOL OS + 5+ CVEs → score under 30"). Don't tune for ambiguous cases yet — Week 5 is about plumbing, not accuracy.

---

# Friday — Run on 5 apps, eyeball, close the week (1.5 hrs)

## Goal
Evidence the AI layer works across archetypes, sample outputs saved, week committed.

## Subtasks

### 1. CLI + 5-app run (40 min)
Write `scripts/run_assessment.py` taking `--app-id` and pretty-printing the result. Then run it on five apps spanning archetypes — e.g.:
- `app-f91e1d4c` (mission-critical legacy monolith — expect low score)
- `app-7d154385` (clean microservice — expect high score)
- `app-b02b61c4` (COTS vendor — Informatica)
- `app-c4c2e2e3` (internal tool)
- `app-b45ed1f0` (compliance-critical)

Save each output to `eval/sample_runs/assessment-<app_id>.json` for posterity.

### 2. Eyeball + one prompt fix (25 min)
For each: is the score defensible? Do the factors cite *this app's* real data, or generic statements? Note any weirdness in `docs/learning-log.md`. Fix the prompt only for clearly-wrong cases — leave ambiguous ones alone.

### 3. A tiny test (15 min)
Add `tests/test_assessment.py`: build a context for one known app, run the agent, assert the result is a valid `AssessmentResult` with `0 <= readiness_score <= 100` and a non-empty `factors` list. (This is a live API call — keep it as one test, mark it so it can be skipped in fast runs.)

### 4. Close the week (10 min)
```cmd
git add agents/ api/schemas.py scripts/run_assessment.py tests/ eval/sample_runs/ docs/
git commit -m "feat(agents): Assessment Agent v1 — context assembler, schema-validated readiness scoring"
git push
```
Update README status: `Week 5: ✅ Assessment Agent v1 (first AI stage; eval unchanged by design)`.

## Done when
- 5 assessments produced and saved, each citing real evidence
- One agent test passes
- README updated, pushed

## If stuck >2 hrs
- **Outputs are generic ("aging system, some risk"):** the `evidence` field isn't being enforced — restate in the prompt that each factor must quote a number or date from the context.
- **Ran low on time:** ship 3 apps, not 5, and note the gap. Three real assessments prove the stage works.

---

## Checkpoint: Week 5

- [ ] `call_claude()` wrapper works; key in `.env`, not committed
- [ ] `build_application_context(app_id)` returns full context for any app
- [ ] `AssessmentResult` contract locked, with evidence-per-factor
- [ ] `AssessmentAgent.run()` returns schema-valid output with one-retry guard
- [ ] 5 apps assessed and saved; one test green
- [ ] Learning-log entry on structured outputs
- [ ] Pushed; README current

---

## What Week 6 looks like (don't plan it yet)

Week 6 builds the **6R Decisioning Agent** with retrieval (RAG over a small curated knowledge base of 6R patterns), taking `(ApplicationContext, AssessmentResult)` and emitting a 6R decision + confidence + reasoning. That's the first agent whose output the harness can grade — so the eval number starts moving in Week 6–7. The detailed Week 6 breakdown gets written at the end of Week 5, once you've seen how the Assessment Agent actually behaves.

---

*Plan version 1.0. Living document — update freely, version every change.*
