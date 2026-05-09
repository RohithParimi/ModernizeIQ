# ModernizeIQ — Six-Month Build Plan

> Your daily operating document. Open this every morning before work, look at today's task, decide if you can do it tonight. If yes, calendar it. If no, slide it.

---

## Operating Manual

### The weekly rhythm

| Day | Type | Why |
|-----|------|-----|
| Monday | Build (focused) | Fresh week, hardest task here |
| Tuesday | Build (focused) | Momentum from Monday |
| **Wednesday** | **Learning / lighter task** | Mid-week energy dip; read instead of fight |
| Thursday | Build (focused) | Push to finish the week's deliverable |
| Friday | Wrap-up / refactor / write | Soft day; document, clean, demo to self |
| Sat/Sun | **Buffer (do not plan tasks)** | Catch up on missed weekday tasks only |

Saturdays and Sundays are deliberately empty. **The moment you start scheduling weekend tasks, the project becomes a job, you burn out, and it dies.** Hold the line.

### Task sizing rule

Every task in this plan is sized for **1.5–2 hours of focused work**. If a task is taking longer than 2.5 hours, stop and ask: am I missing a prerequisite? Do I need to break this into two tasks? Should I escalate (i.e., come back here and ask)?

### The 60% rule

If you complete 60% of weekday tasks in a given week, the project is on track. 80% means you're ahead. 100% means you're not learning enough — push harder on the learning days. Below 50% two weeks in a row means we re-scope.

### How to use this for your calendar

For each task: copy the **bold task title** as the calendar event name, the time estimate as the duration, and the description into the calendar notes. Add tasks to your calendar one week at a time on Sunday evening. Don't pre-load months — too discouraging when life slides them.

### When you fall behind (you will)

Don't try to "make up" missed tasks by adding more to next week. Roll the missed task forward, push everything else back one slot, and accept the project ends a few days later. The plan is a guide, not a contract. Shipping in week 26 is fine. Quitting in week 12 is not.

---

## At-a-Glance Roadmap

| Phase | Weeks | Focus | Headline Deliverable |
|-------|-------|-------|----------------------|
| 0. Foundations | 1–4 | Repo, synthetic data, eval harness | 50-app dataset + 20 eval scenarios |
| 1. The Brain | 5–8 | First three AI agents end-to-end | CLI: `analyze app_id` → recommendation |
| 2. The Graph | 9–12 | Dependency analysis + wave planning | Multi-app analysis with sequencing |
| 3. The Face | 13–16 | Dashboard frontend | Working portfolio dashboard |
| 4. The Polish | 17–20 | Write-ups, demo, system design doc | Blog post, deep-dive, demo video |
| 5. Real Feedback | 21–24 | Ship to 5–10 reviewers, iterate | Final v1.0 release |

---

# Phase 0 — Foundations (Weeks 1–4)

**Goal:** A solid foundation. By the end of week 4, you should have a versioned synthetic dataset, a clean repo, and the eval harness skeleton ready to grade your work.

**Why this phase matters most:** No glamorous AI work yet. This is the unsexy plumbing that lets everything else exist. Most side projects skip it and die in month 3. You won't.

---

## Week 1 — Repo, Local Dev, First Schema

**Week deliverable:** Cloneable repo with running local Postgres and one application record in the DB.

### Mon — **Repo skeleton + dev env (1.5 hrs)**
- Create private GitHub repo `modernizeiq`. Add README.md (the one you have), `.gitignore` (Python + Node), MIT or Apache-2.0 LICENSE.
- Create folder structure: `/api`, `/agents`, `/data`, `/eval`, `/scripts`, `/web`, `/docs`.
- Create `requirements.txt` with: `fastapi`, `uvicorn`, `sqlalchemy`, `psycopg2-binary`, `pgvector`, `anthropic`, `pydantic`, `pytest`.
- **Output:** `git clone` works on a fresh machine.

### Tue — **Docker Compose for Postgres + pgvector (1.5 hrs)**
- Write `docker-compose.yml` with a single `db` service: `pgvector/pgvector:pg16` image, volume for persistence, port 5432 exposed.
- Add `Makefile` with `make up`, `make down`, `make psql` targets.
- Verify: `make up` then `make psql` opens an interactive Postgres prompt.
- **Output:** One command brings up the database.

### Wed — **Learning: data modeling fundamentals (1.5 hrs)**
- Read: *Designing Data-Intensive Applications* Chapter 1 (Reliability, Scalability, Maintainability). Take notes in `/docs/learning-log.md`.
- Skim: PostgreSQL data types reference. Pay attention to JSONB, arrays, and `uuid`.
- **Output:** A page of notes on what makes a data system "good." This is your first writing artifact.

### Thu — **Application table + first migration (2 hrs)**
- Decide on migration tool: **use Alembic** (standard for SQLAlchemy projects). Initialize it.
- Write the first migration: `applications` table with the fields from the README ER diagram.
- Run the migration. Verify in `psql` that the table exists with correct columns.
- **Output:** `alembic upgrade head` creates the schema cleanly.

### Fri — **Seed one app record + commit ceremony (1.5 hrs)**
- Write `scripts/seed.py` that inserts one hardcoded application record (e.g., "Legacy Payroll System").
- Run it, verify with a `SELECT * FROM applications` in psql.
- Commit week 1 work with a clean commit history. Push to GitHub.
- Update README's "Project Status" section to "Week 1 complete."
- **Output:** Visible weekly progress on GitHub. First win.

### Checkpoint: Week 1
- [ ] Repo exists, public commit history
- [ ] `make up` brings up Postgres locally
- [ ] One application record in the DB
- [ ] Learning log has its first entry

---

## Week 2 — Full Schema, Seven Tables

**Week deliverable:** All seven entities from the ER diagram exist as tables, with foreign keys and constraints.

### Mon — **Infrastructure + Dependency tables (2 hrs)**
- Write migration adding `infrastructure` and `dependencies` tables.
- Add foreign keys: `application.infrastructure_id`, `dependency.source_app_id`, `dependency.target_app_id`.
- **Output:** Two more tables, FK constraints work.

### Tue — **SecurityFinding + OperationalMetric tables (1.5 hrs)**
- Migration for both. Both have FK to `application`.
- **Output:** Two more tables. Five total.

### Wed — **Learning: synthetic data design (1.5 hrs)**
- Read: any 2 articles on synthetic data generation for ML/AI systems (search "synthetic data generation best practices").
- Sketch in notebook: what makes a 50-app portfolio "feel realistic"? Diversity of: language, OS age, criticality, dependency density, security posture. Write 5 archetypes (Legacy Monolith, Modern Microservice, COTS Vendor App, Internal Tool, Compliance-Critical).
- **Output:** Archetype list in `/docs/data-design.md`.

### Thu — **Recommendation + Wave tables + ER diagram refresh (1.5 hrs)**
- Last two tables.
- Re-draw the ER diagram (whatever's actually in your code), confirm it matches the README. If not, update README.
- **Output:** Schema fully migrated. ER diagram in code matches the README.

### Fri — **Add SQLAlchemy models, sanity-check (2 hrs)**
- Write SQLAlchemy ORM models matching all seven tables in `/api/models.py`.
- Write a tiny smoke test in `/scripts/check_schema.py` that creates one of each entity and queries them back.
- **Output:** ORM works. Tests pass.

### Checkpoint: Week 2
- [ ] All 7 tables migrated
- [ ] SQLAlchemy models for each
- [ ] Smoke test passes
- [ ] `data-design.md` written

---

## Week 3 — Generate the Synthetic Dataset

**Week deliverable:** 50 realistic applications populated end-to-end.

### Mon — **Application generator (2 hrs)**
- Write `scripts/generate.py` with a function `generate_applications(n=50)`.
- Use weighted random sampling across the 5 archetypes. Use libraries like `faker` for names.
- For each app: language, framework, runtime version (some EOL, some current), owner team, criticality.
- **Output:** 50 applications generated.

### Tue — **Infrastructure + dependency generators (2 hrs)**
- Each app gets one infrastructure record (mix of on-prem VM, Azure/AWS VM, K8s).
- Each app gets 2–5 dependency edges to *other* apps. Avoid cycles for now.
- **Output:** Realistic-feeling dependency graph.

### Wed — **Learning: graph structures + visualization (1.5 hrs)**
- Read: brief intro to NetworkX (Python graph library). You'll use it in Phase 2.
- Play: load your generated dependencies into NetworkX, print a few graph stats (in-degree, out-degree distribution).
- **Output:** Confidence the graph is realistic (no app with 50 dependencies, no isolated islands).

### Thu — **Security findings + telemetry generators (1.5 hrs)**
- Each app gets 0–10 synthetic CVEs, weighted by criticality and OS age (older OS → more CVEs).
- Each app gets last-quarter operational metrics: incidents, MTTR, availability percentage.
- **Output:** Full context per application.

### Fri — **QA the dataset by hand (2 hrs)**
- Open the DB in psql or DBeaver. Spot-check 10 apps. Do they feel realistic?
- Write `/docs/dataset-qa.md` documenting any oddities you fixed.
- Commit the seed data as a SQL dump in `/data/seed.sql` so anyone can reproduce.
- **Output:** Trustworthy dataset, version-controlled.

### Checkpoint: Week 3
- [ ] 50 applications fully populated
- [ ] Dependency graph is connected and realistic
- [ ] Dataset reproducible via `make seed`
- [ ] QA doc written

---

## Week 4 — Eval Harness Skeleton + Phase 0 Retro

**Week deliverable:** 20 hand-crafted eval scenarios; Phase 0 retrospective written.

### Mon — **Eval harness design (1.5 hrs)**
- Decide structure: pytest-based, each scenario is a fixture with `(input_app_id, expected_6r, must_mention_keywords)`.
- Write `/eval/harness.py` skeleton — runs scenarios, collects pass/fail, outputs report.
- **Output:** Empty harness that runs (but has no scenarios yet).

### Tue — **Write 7 "clear-cut" scenarios (2 hrs)**
- 3 clear-Rehost (modern app, no tech debt, just needs cloud move).
- 2 clear-Retire (low usage, redundant capability, high cost).
- 2 clear-Replace (vendor product approaching EOS, modern SaaS exists).
- For each: pick an app from your dataset, write expected decision + must-mention keywords.
- **Output:** 7 scenarios in `/eval/scenarios/`.

### Wed — **Learning: how to evaluate LLM systems (1.5 hrs)**
- Read: Anthropic's docs on evaluation, OR Eugene Yan's "Patterns for Building LLM Apps."
- Notes on: golden-set eval, regression testing, cost-of-eval, what to track over time.
- **Output:** Notes in learning log.

### Thu — **Write 7 "ambiguous" scenarios (2 hrs)**
- 3 Refactor-vs-Replace dilemmas.
- 2 Retain (recently modernized, business window blocking).
- 2 dependency-blocked (the app is fine, but its upstream isn't ready).
- These are the hard cases that separate good systems from toy ones.
- **Output:** 14 total scenarios.

### Fri — **Final 6 scenarios + Phase 0 retrospective (2 hrs)**
- 2 Replatform (databases that need managed-service uplift).
- 2 compliance-deferred (regulatory window prevents this wave).
- 2 wildcards — invent edge cases that worry you.
- Write **Phase 0 Retrospective** in `/docs/retrospectives/phase-0.md`: what went well, what was harder than expected, what I'd do differently, am I behind/ahead, do I need to re-scope Phase 1?
- **Output:** 20 scenarios. First retrospective. Phase 0 done.

### Checkpoint: Phase 0 (end of Week 4)
- [ ] Repo, schema, dataset, eval harness all in place
- [ ] 20 scenarios cover the major decision archetypes
- [ ] First retrospective written — be honest with yourself
- [ ] **Reward yourself.** Take a weekend completely off the project.

---

# Phase 1 — The Brain (Weeks 5–8)

**Goal:** Working CLI that takes one application ID, runs it through three AI agents (Assess → 6R → Explain), and emits a complete recommendation. By end of week 8, the eval harness should run and give you a baseline accuracy number.

**Why this phase is the heart:** Everything else (graph, dashboard, polish) is around this. If the brain is dumb, nothing saves the product.

---

## Week 5 — Assessment Agent

**Week deliverable:** Assessment Agent reads an app's full context and emits a readiness score with structured factors.

### Mon — **Anthropic API integration (1.5 hrs)**
- Add `ANTHROPIC_API_KEY` to `.env`. Add `anthropic` to requirements.
- Write a tiny `/agents/llm.py` with a `call_claude(prompt, system, model)` wrapper.
- Smoke-test: ask Claude "what is 2+2" and print the response.
- **Output:** First successful API call from the project.

### Tue — **Assessment Agent contract (2 hrs)**
- Define Pydantic input model: `ApplicationContext` (everything about one app).
- Define Pydantic output model: `AssessmentResult` (readiness_score 0–100, factors, risk_areas).
- Write the prompt template — focused, structured, demanding JSON output matching the schema.
- **Output:** Schemas locked. Agent has a contract.

### Wed — **Learning: structured outputs from LLMs (1.5 hrs)**
- Read: Anthropic docs on JSON mode / structured outputs.
- Skim: Instructor / Pydantic-AI libraries (you may not use them but know they exist).
- Pattern to internalize: never trust the LLM to return clean JSON without validation.
- **Output:** Notes on structured output patterns.

### Thu — **Implement Assessment Agent v1 (2 hrs)**
- Write `/agents/assessment.py` with class `AssessmentAgent` exposing `run(context: ApplicationContext) -> AssessmentResult`.
- Build the context object by querying the DB for one app + its related entities.
- Call Claude, validate output against Pydantic schema, retry once on validation failure.
- **Output:** First working agent.

### Fri — **Run on 5 apps, eyeball outputs (1.5 hrs)**
- Pick 5 apps spanning archetypes. Run the Assessment Agent on each. Print results.
- Are the readiness scores defensible? Are the factors sensible? Note any weirdness.
- Update prompt if outputs are clearly wrong (don't tune for ambiguous cases yet).
- **Output:** First evidence the AI layer works.

### Checkpoint: Week 5
- [ ] Assessment Agent runs end-to-end
- [ ] Outputs validate against Pydantic schema
- [ ] 5 apps assessed; outputs feel reasonable

---

## Week 6 — 6R Decisioning Agent + RAG

**Week deliverable:** 6R Agent that uses retrieval over a curated knowledge base to recommend a decision.

### Mon — **Curate knowledge base v1 (2 hrs)**
- Collect 15–20 authoritative docs on 6R patterns: AWS migration whitepapers, Microsoft Cloud Adoption Framework, public case studies, vendor migration guides.
- Save as plain text in `/data/kb/raw/`. Add metadata in a manifest file: source, date, topic.
- **Output:** Raw KB ready to chunk.

### Tue — **Embeddings pipeline + pgvector load (2 hrs)**
- Write `/scripts/build_kb.py`: chunk each doc (~500 token chunks), embed using Anthropic embeddings or `voyage-2`, write to a `kb_chunks` table with the vector column.
- Run it. Verify with a sample similarity query.
- **Output:** KB queryable by vector similarity.

### Wed — **Learning: retrieval strategies (1.5 hrs)**
- Read: a primer on hybrid search (BM25 + vector). Optional: a paper on reranking.
- Decide for v1: pure vector search is fine. Add BM25 in Phase 4 if needed.
- **Output:** Notes on when to add complexity.

### Thu — **Implement 6R Agent v1 (2 hrs)**
- Define schemas: input is `(ApplicationContext, AssessmentResult)`, output is `SixRDecision` (decision enum, confidence 0–1, reasoning, retrieved_chunks).
- For each request: embed the query, retrieve top 5 chunks, include them in the prompt, ask for decision.
- **Output:** Second agent works.

### Fri — **Run on 5 apps, compare to expected decisions (1.5 hrs)**
- Run on the 5 apps from week 5.
- For each, compare to your gut decision. Note where agent disagrees and why.
- **Output:** First sense of agent's intuition vs yours.

### Checkpoint: Week 6
- [ ] KB chunks indexed in pgvector
- [ ] 6R Agent runs with retrieval
- [ ] You've seen at least one good answer and one suspicious answer

---

## Week 7 — Explanation Agent + Orchestrator + First Eval Run

**Week deliverable:** End-to-end pipeline runs against the eval harness for the first time. Baseline accuracy recorded.

### Mon — **Explanation Agent (1.5 hrs)**
- Input: `(ApplicationContext, AssessmentResult, SixRDecision)`. Output: a 200-word business-ready explanation citing specific evidence.
- The prompt should explicitly require citations to data points in the context.
- **Output:** Third agent works.

### Tue — **Orchestrator (2 hrs)**
- Write `/agents/orchestrator.py` with `analyze_application(app_id) -> FullRecommendation`.
- Sequence: Assess → 6R → Explain. Pass outputs forward as inputs. Persist final `FullRecommendation` to the `recommendations` table.
- **Output:** Full pipeline in code.

### Wed — **CLI wrapper + dry run (1.5 hrs)**
- Write `/scripts/analyze.py` that takes `--app-id` and prints a nicely formatted recommendation.
- Run on 3 apps. Save outputs in `/eval/sample_runs/` for posterity.
- **Output:** A demo-able CLI.

### Thu — **Wire eval harness to orchestrator + first full run (2 hrs)**
- Update `/eval/harness.py` to call the orchestrator for each scenario.
- Run all 20 scenarios. Record: accuracy on 6R decision (exact match), accuracy on must-mention keywords.
- **Output:** Baseline number. Probably 50–70% accuracy on first run.

### Fri — **Failure analysis (1.5 hrs)**
- For each failing scenario, write 2 sentences on **why** it failed: bad prompt? Bad retrieval? Schema confusion? Genuinely ambiguous case?
- File 3 GitHub issues for the worst failures, tagged `bug` or `improvement`.
- Update README: "Phase 1 complete, baseline accuracy: X%."
- **Output:** Honest baseline + a focused list of what to fix in Phase 2.

### Checkpoint: Week 7
- [ ] All three agents work
- [ ] Orchestrator runs end-to-end
- [ ] Eval harness produces a baseline number
- [ ] Issues filed for top 3 failures

---

## Week 8 — Polish, Fix, Demo to Self

**Week deliverable:** Phase 1 in a state you'd be willing to show a senior engineer.

### Mon — **Fix issue #1 from week 7 (2 hrs)**
- Whatever was the worst failure mode. Iterate on the prompt or retrieval. Re-run eval harness, verify the fix.
- **Output:** First measurable improvement.

### Tue — **Fix issues #2 and #3 (2 hrs)**
- Same process.
- **Output:** Improved baseline accuracy.

### Wed — **Learning: prompt engineering deep dive (1.5 hrs)**
- Read: Anthropic's prompt engineering guide, end to end.
- Skim: papers on chain-of-thought and ReAct.
- Apply one technique to one of your prompts.
- **Output:** Notes + one prompt improved.

### Thu — **CLI polish + structured logging (1.5 hrs)**
- Pretty-print recommendations with `rich` library.
- Add structured logging: agent name, latency, tokens used, errors.
- **Output:** CLI you'd happily demo.

### Fri — **Phase 1 retrospective + demo to self (2 hrs)**
- Record yourself (Loom/QuickTime) walking through the CLI for 5 minutes. Watch it back. Cringe productively.
- Write `/docs/retrospectives/phase-1.md`: tech debt, prompt patterns that worked, agents that need rework, time spent vs estimated.
- Update README "Project Status" to "Phase 1 complete."
- **Output:** Phase 1 closed. First video artifact.

### Checkpoint: Phase 1 (end of Week 8)
- [ ] Three agents + orchestrator working
- [ ] Baseline eval accuracy documented
- [ ] First demo video recorded
- [ ] Retrospective written
- [ ] **Take Saturday completely off. You earned it.**

---

# Phase 2 — The Graph (Weeks 9–12)

**Goal:** Multi-app analysis with dependency awareness and wave planning.

> **Note:** Daily tasks for Phase 2 will be detailed when Phase 1 closes. Real plans don't go this deep this far out. The weekly milestones below are the commitment; the daily breakdown gets written in Week 8 once you know where you actually landed.

### Week 9 — Dependency Agent
- Read app's dependencies, compute blast radius (downstream impact).
- Detect cycles, flag them as warnings.
- Add to orchestrator pipeline.
- **Deliverable:** Recommendation now includes blast radius and dependency warnings.

### Week 10 — Wave Planning Agent
- Take a *set* of recommendations, sort into waves (1, 2, 3...) respecting dependencies.
- Wave 0 = foundations (platform uplift, common services). Wave 1+ = ordered apps.
- **Deliverable:** Run analyzer on full 50-app portfolio, get a wave plan.

### Week 11 — Portfolio-level analysis
- Aggregate views: portfolio risk score, total estimated cost savings, technical debt index.
- Build the data structures the dashboard will consume.
- **Deliverable:** API endpoint `/portfolio/summary` returns rich aggregate data.

### Week 12 — Eval expansion + Phase 2 retro
- Add 10 portfolio-level eval scenarios (does the wave plan respect this dependency? does it group these apps correctly?).
- Phase 2 retrospective.
- **Deliverable:** 30 total eval scenarios, Phase 2 closed.

---

# Phase 3 — The Face (Weeks 13–16)

**Goal:** A working dashboard that makes the AI's output legible to a non-technical decision-maker.

### Week 13 — Frontend foundation
- Next.js project, shadcn/ui setup, Tailwind, app router.
- Single page: portfolio table with all 50 apps.
- **Learning emphasis:** This phase has the most learning since frontend is your weakest area. Plan extra Wednesday + weekend learning blocks.
- **Deliverable:** A page that lists apps with their recommendations.

### Week 14 — App detail view
- Click an app → see its full assessment, 6R decision, reasoning, dependency graph.
- Render the dependency graph with `react-flow` or `recharts`.
- **Deliverable:** Drill-down from list to detail.

### Week 15 — Executive scorecard + KPIs
- Top-of-portfolio dashboard: total apps, % at risk, projected savings, wave-by-wave breakdown.
- Recharts for charts.
- **Deliverable:** A "CIO view" that summarizes everything in one screen.

### Week 16 — Polish + Phase 3 retro
- Loading states, error states, empty states. Mobile responsive.
- Phase 3 retrospective.
- **Deliverable:** Dashboard that doesn't embarrass you. Demo video v2.

---

# Phase 4 — The Polish (Weeks 17–20)

**Goal:** Three published artifacts and a system design document.

### Week 17 — Architecture deep-dive doc
- A 3000-word `/docs/ARCHITECTURE.md` covering: design decisions, tradeoffs, what you'd do differently at 100x scale, how each agent works, what the eval harness measures.
- **Deliverable:** The document a hiring manager reads after the README.

### Week 18 — Technical blog post
- Pick the most novel thing you built (likely the eval harness or the multi-agent reasoning). Write a 2500-word blog post about it.
- Publish on your own blog or Medium. Submit to Hacker News.
- **Deliverable:** First public technical writing.

### Week 19 — Demo video v3 (the real one)
- 5–7 minute walkthrough: the problem, the architecture, the dashboard demo, the eval harness in action, what's next.
- Script it first. Record clean takes. Edit lightly. Upload to YouTube unlisted.
- **Deliverable:** Shareable video.

### Week 20 — Polish pass + Phase 4 retro
- Fix everything that's been bugging you. Resist the urge to add features — only fix.
- Phase 4 retrospective.
- **Deliverable:** Project ready for outside eyes.

---

# Phase 5 — Real Feedback (Weeks 21–24)

**Goal:** Ship to 5–10 reviewers, gather real feedback, iterate, release v1.0.

### Week 21 — Identify and reach out to reviewers
- Make a list of 10 people: ex-TCS colleagues, LinkedIn platform engineers, modernization leads, anyone who'd give you 30 minutes of honest feedback.
- Send personalized notes asking for 30 minutes of their time. Promise a copy of the system design doc as a thank-you.
- **Deliverable:** 5+ scheduled feedback sessions.

### Week 22 — First half of feedback sessions + intake
- Conduct 3 sessions. Take notes obsessively. Don't argue, just listen.
- Triage feedback into: must-fix, should-fix, won't-fix, future.
- **Deliverable:** Triaged feedback log.

### Week 23 — Second half of feedback + must-fix iteration
- 2–3 more sessions. Implement the must-fix items.
- **Deliverable:** v1.0 candidate.

### Week 24 — Release + launch announcement
- Tag v1.0 on GitHub. Update README with status. Write a launch post on LinkedIn linking to repo, blog, and demo video.
- Final retrospective: what would you do differently if you started over?
- **Deliverable:** Public v1.0. Project alive in the world. You're now an engineer who shipped.

---

## Skill Development Tracker

Update this monthly. Self-rate 1–5 the same skills as your Week 0 baseline. Targets are aspirational but realistic if you do the learning days.

| Skill | Week 0 | M1 Target | M3 Target | M6 Target |
|-------|--------|-----------|-----------|-----------|
| Python / backend | 3 | 3.5 | 4 | 4.5 |
| System design | 0 | 1 | 2.5 | 3.5 |
| Data engineering | 0 | 1.5 | 2.5 | 3 |
| LLM / RAG / agents | 2 | 3 | 4 | 4.5 |
| Frontend (React/Next) | 0.5 | 0.5 | 1 | 2.5 |
| Technical writing | 0.5 | 1 | 2 | 3 |
| AWS / Cloud | 2.5 | 2.5 | 3 | 3.5 |

**The story you'll tell in interviews in month 7:** "I went from L3 support engineer to having shipped a multi-agent AI system end-to-end, with a published architecture doc, blog post, and feedback from 5+ industry reviewers." That's the artifact. Don't lose sight of it.

---

## Risk Register

These are the realistic ways this project can die. Pre-mortem them now so you spot them early.

| Risk | Symptom | Mitigation |
|------|---------|------------|
| Scope creep | Adding features the README doesn't list | Refuse. Write idea in IDEAS.md. Move on. |
| Burnout | 3+ consecutive weeks below 50% completion | Take a full week off, no guilt. Then re-scope. |
| Perfectionism | Stuck on one task for >3 days | Ship the ugly version. Mark TODO. Move on. |
| AI rabbit holes | "What if we used X new framework" | Defer until Phase 4 polish. v1 uses what you know. |
| Frontend dread | Phase 3 keeps slipping | Start frontend learning earlier — interleave from Phase 1. |
| Job conflict | Day job intensifies, side project starves | Stretch timeline by 1 month. Don't quit. The plan accommodates a 25-week version. |
| Hardware/dev env failures | Local Postgres dies, lose work | Push to GitHub daily. Use cloud Postgres if local breaks. |
| Loneliness | No one to talk to about the work | Find one accountability buddy. Weekly 30-min check-in. Even better, post weekly progress on LinkedIn. |

---

## Calendar Entry Guide

For each weekday task, create a calendar event with this structure:

**Title:** `[ModernizeIQ W3] Application generator`
**Time:** 8:30 PM – 10:30 PM (or whenever your post-work focus block is)
**Location:** (leave blank or "Home desk")
**Description:**
> Goal: Function `generate_applications(n=50)` produces realistic synthetic apps across 5 archetypes.
> Prereq: Schema migrated (W2 done).
> Output: 50 applications in `applications` table.
> If stuck >2 hrs: stop, document blocker in `/docs/blockers.md`, sleep on it.

That last line — "if stuck, stop and document" — is the most senior thing you'll do. Don't grind. Surrender to the blocker, sleep, fresh brain tomorrow. Most tough problems solve themselves overnight.

---

*Plan created today. Re-plan Phase 2 in detail at end of Week 8. Re-plan Phase 3 at end of Week 12. Live document — update freely, but version every change.*
