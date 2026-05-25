# ModernizeIQ — Week 3 Daily Plan

> Source of truth for Week 3. Open this every morning before work, look at today's task, follow it step by step. If a step is unclear, that's a bug in this doc — fix it, don't power through.

---

## Context

### Where we are at the end of Week 2

- ✅ Repo, Docker Compose with Postgres + pgvector, Alembic, SQLAlchemy 2.0 models for all 7 entities
- ✅ One real seed row: Carbon Black App Control (anchor for sanity checks)
- ✅ Integration smoke test exercising every relationship — `uv run pytest -v` should always go green before continuing work
- ✅ `docs/data_design.md` — the 5 archetypes with realistic value ranges (this doc IS the spec for the generator)

### Why Week 3 matters

Every AI recommendation in Phase 1 will be reasoning over the data you generate this week. If the dataset is junk, the agent looks dumb even when its logic is right. The 6R distinctions only mean something if the archetypes feel real. Treat this as the foundation of every demo you'll ever give.

### What changed from the original PROJECT_PLAN.md

The original plan said "Applications Monday, Infrastructure + Dependencies Tuesday." That ordering doesn't work because `Application.infrastructure_id` is a `NOT NULL` foreign key — apps can't exist without an infrastructure row to point at. So:

- **Monday now pairs Infrastructure + Application** (generated together, one host per app, naturally aligned by archetype)
- **Tuesday is dedicated to dependencies only**
- **Wed / Thu / Fri are unchanged**

This is also the doc to point at when you re-plan Phase 1 at the end of Week 8 — refer to this format for what "detailed daily" looks like.

---

## Operating reminders (read once Monday morning, then forget)

- **Task sizing:** every day's task is sized 1.5–2 hrs. If you hit 2.5 hrs, stop and ask: am I missing a prerequisite? Do I need to split this? Is there a senior engineer (or Claude) to unblock me?
- **Stuck protocol:** if blocked >30 minutes on a single error, stop and document in `docs/blockers.md`. Sleep on it. Come back fresh, or ask for help. Don't grind.
- **60% rule:** completing 60% of weekday tasks = on track. 80% = ahead. Below 50% two weeks running = re-scope, no guilt.
- **Saturdays/Sundays:** buffer only. Don't pre-plan weekend tasks.

---

# Monday — Infrastructure + Application generator (2 hrs)

## Goal

A single command — `uv run python scripts/generate.py` — populates 50 infrastructure rows and 50 application rows in the DB, with archetype distribution matching the spec. Reproducible across runs via a fixed RNG seed.

## Prerequisites

- Week 2 catch-up committed and pushed
- `pytest -v` green
- Docker container `pgvector_db` running (`docker ps` confirms)
- The DB is in a known state (Carbon Black seed row may or may not be there — generator should handle both)

## Subtasks

### 1. Add `faker` to dependencies (5 min)

```cmd
uv add faker
```

This adds `faker` to your `pyproject.toml` and installs it. Faker generates plausible names, team names, sentences, etc. — saves you from inventing 50 unique app names by hand.

### 2. Scaffold `scripts/generate.py` (20 min)

Create `scripts/generate.py` with this skeleton. **Do not copy-paste this and call it done** — read through it, understand the shape, then write your own version.

```python
"""
scripts/generate.py
Generates a synthetic enterprise portfolio: infrastructure + applications +
dependencies + security findings + operational metrics. Reproducible via a
fixed RNG seed.

Usage:
    uv run python scripts/generate.py             # default: 50 apps, seed=42
    uv run python scripts/generate.py --wipe      # wipe DB first
    uv run python scripts/generate.py --n 100     # different size
    uv run python scripts/generate.py --seed 999  # different portfolio
"""
import argparse
import random
from datetime import date, timedelta
from typing import List

from faker import Faker
from sqlalchemy.orm import Session

from db.session import SessionLocal
from db.models import Infrastructure, Application
from api.schemas import (
    EnvironmentType, ArchetypeType, CriticalityLevel,
)


# Archetype distribution — weights drawn from data_design.md
ARCHETYPE_WEIGHTS = [
    (ArchetypeType.LEGACY_MONOLITH,        0.30),
    (ArchetypeType.MODERN_MICROSERVICE,    0.25),
    (ArchetypeType.COTS_VENDOR,            0.20),
    (ArchetypeType.INTERNAL_TOOL,          0.15),
    (ArchetypeType.COMPLIANCE_CRITICAL,    0.10),
]


def pick_archetype(rng: random.Random) -> ArchetypeType:
    """Weighted random archetype selection."""
    archetypes, weights = zip(*ARCHETYPE_WEIGHTS)
    return rng.choices(archetypes, weights=weights, k=1)[0]


def make_infra(archetype: ArchetypeType, rng: random.Random, fake: Faker) -> Infrastructure:
    """One infrastructure row per archetype, with realistic value ranges."""
    # TODO: per-archetype branching (see data_design.md for the ranges)
    raise NotImplementedError


def make_app(archetype: ArchetypeType, infra: Infrastructure,
             rng: random.Random, fake: Faker) -> Application:
    """One application row, linked to its infrastructure host."""
    # TODO: per-archetype branching
    raise NotImplementedError


def wipe(session: Session) -> None:
    """Delete all generated data in dependency-safe order."""
    # Order matters: drop tables that have FKs to other tables first
    # TODO: implement
    raise NotImplementedError


def generate_portfolio(n: int = 50, seed: int = 42, do_wipe: bool = False) -> None:
    rng = random.Random(seed)
    fake = Faker()
    fake.seed_instance(seed)

    with SessionLocal() as session:
        if do_wipe:
            wipe(session)
            session.commit()

        apps: List[Application] = []
        for _ in range(n):
            archetype = pick_archetype(rng)
            infra = make_infra(archetype, rng, fake)
            app = make_app(archetype, infra, rng, fake)
            session.add(infra)
            session.add(app)
            apps.append(app)

        session.commit()
        print(f"Seeded {n} infrastructure + {n} application rows.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--n", type=int, default=50)
    parser.add_argument("--seed", type=int, default=42)
    parser.add_argument("--wipe", action="store_true")
    args = parser.parse_args()
    generate_portfolio(n=args.n, seed=args.seed, do_wipe=args.wipe)
```

### 3. Implement `make_infra()` for all 5 archetypes (30 min)

Open `docs/data_design.md` side-by-side. For each archetype, read the "Infrastructure Profile" section, then translate it to code. Example for Legacy Monolith:

```python
if archetype == ArchetypeType.LEGACY_MONOLITH:
    os_options = [
        ("Windows Server 2008 R2", date(2020, 1, 14)),
        ("Windows Server 2012 R2", date(2023, 10, 10)),
        ("RHEL 6",                  date(2020, 11, 30)),
        ("RHEL 7",                  date(2024, 6, 30)),
    ]
    os_name, eol = rng.choice(os_options)
    return Infrastructure(
        id=f"infra-{fake.uuid4()[:8]}",
        environment_type=EnvironmentType.ON_PREM_VM,
        os_name=os_name,
        os_eol_date=eol,
        cpu_cores=rng.choice([4, 8, 16]),
        memory_gb=rng.choice([8, 16, 32]),
        location=rng.choice(["Hyderabad DC", "Mumbai DC", "On-Prem East"]),
        owner_team=fake.bs().title()[:50],
    )
```

Repeat for the other 4 archetypes. Microservices get modern Linux + K8s, COTS gets dedicated VMs, Internal Tools get small shared VMs, Compliance-Critical gets hardened isolated infra.

### 4. Implement `make_app()` for all 5 archetypes (25 min)

Same pattern — read `data_design.md`, translate to code. Example:

```python
if archetype == ArchetypeType.LEGACY_MONOLITH:
    return Application(
        id=f"app-{fake.uuid4()[:8]}",
        name=fake.catch_phrase()[:90],
        archetype=archetype,
        language=rng.choice(["Java 6", "Java 7", ".NET 4.0", "C++", "COBOL"]),
        runtime_version=rng.choice(["1.6", "1.7", "4.0"]),
        criticality=rng.choices(
            [CriticalityLevel.HIGH, CriticalityLevel.MISSION_CRITICAL, CriticalityLevel.MEDIUM],
            weights=[0.4, 0.4, 0.2],
        )[0],
        owner_team=fake.company()[:90],
        app_owner_name=fake.name()[:90],
        infrastructure_id=infra.id,
    )
```

### 5. Implement `wipe()` (10 min)

Order matters because of FK constraints — delete children before parents:

```python
def wipe(session: Session) -> None:
    # Future-proof: when more tables exist, delete those first
    from db.models import (
        Dependency, SecurityFinding, OperationalMetric,
        Recommendation, Wave, Application, Infrastructure,
    )
    session.query(Recommendation).delete()
    session.query(SecurityFinding).delete()
    session.query(OperationalMetric).delete()
    session.query(Dependency).delete()
    session.query(Wave).delete()
    session.query(Application).delete()
    session.query(Infrastructure).delete()
```

### 6. Run and verify (20 min)

```cmd
uv run python scripts\generate.py --wipe
```

Expected output:
```
Seeded 50 infrastructure + 50 application rows.
```

Then in `make psql`:

```sql
SELECT archetype, COUNT(*) FROM applications GROUP BY archetype ORDER BY 2 DESC;
SELECT environment_type, COUNT(*) FROM infrastructure GROUP BY environment_type;
SELECT name, archetype, language FROM applications LIMIT 5;
```

Distribution should roughly match the weights (small variation is expected with n=50). If you see 30 Microservices and 5 Monoliths, the weights are wrong.

## Verification: Done when…

- `uv run python scripts/generate.py --wipe` exits 0
- `SELECT COUNT(*) FROM applications;` returns 50
- `SELECT COUNT(*) FROM infrastructure;` returns 50
- The archetype distribution feels right
- Re-running with the same seed gives IDENTICAL ids (test: run twice with `--wipe`, compare `SELECT id FROM applications ORDER BY id LIMIT 5;`)

## If stuck >2 hrs

Stop. The two most likely blockers:
- **`faker` not installed or import error** — `uv sync` and retry
- **FK constraint error on Application insert** — your `make_app` is returning before `make_infra` was added to the session. Check the order: `session.add(infra)` BEFORE `session.add(app)`

Document the blocker in `docs/blockers.md`. Sleep. Resume Tuesday.

---

# Tuesday — Dependency edge generator (1.5–2 hrs)

## Goal

Each app has 2–5 outgoing dependency edges. The full graph is connected (no orphan apps), reasonably realistic (top app doesn't have 30 dependents), and persists in the `dependencies` table.

## Prerequisites

- Monday's generator works
- 50 apps + 50 infra rows in the DB

## Subtasks

### 1. Decide on cycle handling (5 min, just a decision)

For Week 3 v1: **allow cycles**. Real enterprises have circular deps. Detection happens Wednesday with NetworkX. Don't over-engineer cycle prevention into the generator — it's harder than it sounds and the data is more realistic without it.

### 2. Add `generate_dependencies()` to `scripts/generate.py` (40 min)

Per-archetype edge count weighting (data_design.md tells you which archetypes are "chatty"):

```python
DEPENDENCY_COUNT_RANGES = {
    ArchetypeType.LEGACY_MONOLITH:     (1, 3),
    ArchetypeType.MODERN_MICROSERVICE: (3, 5),
    ArchetypeType.COTS_VENDOR:         (2, 3),
    ArchetypeType.INTERNAL_TOOL:       (1, 3),
    ArchetypeType.COMPLIANCE_CRITICAL: (2, 4),
}

PROTOCOLS = ["HTTPS", "HTTPS", "HTTPS", "gRPC", "JDBC", "MQ"]  # HTTPS-weighted

def generate_dependencies(apps: List[Application], rng: random.Random,
                          fake: Faker) -> List[Dependency]:
    deps = []
    for app in apps:
        low, high = DEPENDENCY_COUNT_RANGES[app.archetype]
        edge_count = rng.randint(low, high)

        # Pool of possible targets: all OTHER apps
        candidates = [a for a in apps if a.id != app.id]

        # Slight bias toward same-archetype targets (60/40 mix)
        same_arch = [a for a in candidates if a.archetype == app.archetype]
        other = [a for a in candidates if a.archetype != app.archetype]

        targets = []
        for _ in range(edge_count):
            if same_arch and rng.random() < 0.6:
                targets.append(rng.choice(same_arch))
            elif other:
                targets.append(rng.choice(other))

        # Dedupe in case of accidental repeats
        targets = list({t.id: t for t in targets}.values())

        for tgt in targets:
            deps.append(Dependency(
                id=f"dep-{fake.uuid4()[:8]}",
                source_app_id=app.id,
                target_app_id=tgt.id,
                protocol=rng.choice(PROTOCOLS),
                criticality=rng.choices(
                    [CriticalityLevel.HIGH, CriticalityLevel.MEDIUM, CriticalityLevel.LOW],
                    weights=[0.3, 0.5, 0.2],
                )[0],
            ))
    return deps
```

### 3. Wire `generate_dependencies()` into `generate_portfolio()` (10 min)

After the infra+app loop and commit:

```python
deps = generate_dependencies(apps, rng, fake)
session.add_all(deps)
session.commit()
print(f"Seeded {len(deps)} dependency edges.")
```

### 4. Update `wipe()` (5 min)

Add `session.query(Dependency).delete()` before applications.

### 5. Run and inspect (20 min)

```cmd
uv run python scripts\generate.py --wipe
```

In psql:

```sql
-- Edge count distribution
SELECT COUNT(*) FROM dependencies;

-- Per-source edge counts
SELECT source_app_id, COUNT(*) AS out_degree
FROM dependencies
GROUP BY source_app_id
ORDER BY out_degree DESC
LIMIT 10;

-- Top "blast radius" candidates (most depended-upon)
SELECT target_app_id, COUNT(*) AS in_degree
FROM dependencies
GROUP BY target_app_id
ORDER BY in_degree DESC
LIMIT 10;
```

Total edges should be ~125–175 for 50 apps. Top out-degree ≤ 5 (sanity). Top in-degree ≤ ~10 (realistic — a couple of "everybody-uses-it" services). If anything is 25+, generator has a bug.

## Verification: Done when…

- `SELECT COUNT(*) FROM dependencies;` returns 100–200
- Out-degrees max out at 5 (matches the spec)
- No app has zero outgoing edges (verify with a NOT IN query)
- Re-running with same seed produces IDENTICAL edge set

## If stuck >2 hrs

- **Empty dependencies after run** — check that `session.add_all(deps)` runs AFTER the apps-commit (otherwise FKs fail silently? unlikely but check)
- **Duplicate-key errors on `id`** — fake.uuid4()[:8] occasionally collides. Switch to a counter or full UUID.

---

# Wednesday — NetworkX + graph QA (1.5 hrs)

## Goal

Validate Tuesday's dependency graph is realistic. Learn NetworkX, which you'll lean on in Phase 2 for blast-radius analysis.

## Prerequisites

- Tuesday's dependencies are in the DB
- You have ~30 minutes of mental energy for reading

## Subtasks

### 1. Add NetworkX to dependencies (2 min)

```cmd
uv add networkx
```

### 2. Read NetworkX intro (25 min)

Open https://networkx.org/documentation/stable/tutorial.html — skim the tutorial.

Focus on these concepts only:
- `nx.DiGraph()` — directed graph
- `G.add_edge(u, v)`
- `G.nodes()`, `G.edges()`
- `G.in_degree(node)`, `G.out_degree(node)`
- `nx.weakly_connected_components(G)` — to find isolated subgraphs
- `nx.simple_cycles(G)` — to find cycles

Don't read about visualization, advanced algorithms, or the whole library. You need these 6 things.

### 3. Write `scripts/inspect_graph.py` (30 min)

```python
"""
Loads the dependency graph from the DB into NetworkX and prints stats.
Run after generate.py to sanity-check the synthetic portfolio.
"""
import networkx as nx
from collections import Counter
from db.session import SessionLocal
from db.models import Application, Dependency


def build_graph() -> nx.DiGraph:
    with SessionLocal() as session:
        apps = session.query(Application).all()
        deps = session.query(Dependency).all()
        g = nx.DiGraph()
        for app in apps:
            g.add_node(app.id, name=app.name, archetype=app.archetype.value)
        for dep in deps:
            g.add_edge(dep.source_app_id, dep.target_app_id, protocol=dep.protocol)
        return g


def print_stats(g: nx.DiGraph) -> None:
    print(f"Nodes: {g.number_of_nodes()}")
    print(f"Edges: {g.number_of_edges()}")

    # Out-degree distribution
    out_degs = [d for _, d in g.out_degree()]
    print(f"Out-degree: min={min(out_degs)} max={max(out_degs)} avg={sum(out_degs)/len(out_degs):.2f}")

    # In-degree (= blast radius proxy)
    in_degs = [d for _, d in g.in_degree()]
    print(f"In-degree:  min={min(in_degs)} max={max(in_degs)} avg={sum(in_degs)/len(in_degs):.2f}")

    # Connected components
    components = list(nx.weakly_connected_components(g))
    print(f"Weakly connected components: {len(components)}  (sizes: {sorted([len(c) for c in components], reverse=True)[:5]})")

    # Cycles
    cycles = list(nx.simple_cycles(g))
    print(f"Cycles detected: {len(cycles)}")
    if cycles:
        print(f"  Example cycle: {cycles[0]}")

    # Top 5 blast-radius candidates
    top_in = sorted(g.in_degree(), key=lambda x: x[1], reverse=True)[:5]
    print("Top 5 blast-radius candidates (highest in-degree):")
    for node, deg in top_in:
        print(f"  {deg:3d} <- {node}  ({g.nodes[node]['name']})")


if __name__ == "__main__":
    g = build_graph()
    print_stats(g)
```

### 4. Run and eyeball (15 min)

```cmd
uv run python scripts\inspect_graph.py
```

Expected shape of output:
- 50 nodes, 100–200 edges
- 1 weakly connected component (everything is reachable)
- 0–5 cycles (real but uncommon)
- Top blast-radius candidates: realistic in-degree of 4–8 each

**If anything looks off** (10 connected components, app with in-degree 35, etc.), the generator has a bug. Go back to Tuesday's code, fix, re-run `generate.py --wipe`, re-run `inspect_graph.py`. Iterate until the graph feels right.

### 5. Note 1 paragraph in `docs/learning-log.md` (10 min)

Honest, short. What surprised you about the graph structure? What's one thing you'd want to ask a senior engineer? File it as a question for later.

## Verification: Done when…

- `inspect_graph.py` runs cleanly
- All 50 apps are in one weakly connected component
- No app has insane in-degree
- Learning-log entry written

---

# Thursday — Security findings + Operational metrics (1.5–2 hrs)

## Goal

Each app has 0–10 security findings (skewed by archetype + OS age) and exactly one operational metrics row (also archetype-driven). After this, every app has a complete "story."

## Subtasks

### 1. Define a CVE catalog (15 min)

Add to `scripts/generate.py`:

```python
# Plausibly-shaped synthetic CVEs. Drawn from real CVEs for realism but
# severity/title combinations are not claimed to match the real world.
CVE_CATALOG = [
    ("CVE-2021-44228", "Log4Shell Remote Code Execution",         9.8, SeverityLevel.CRITICAL),
    ("CVE-2023-38831", "WinRAR Remote Code Execution",            7.8, SeverityLevel.HIGH),
    ("CVE-2023-22515", "Confluence Broken Access Control",        9.1, SeverityLevel.CRITICAL),
    ("CVE-2022-22965", "Spring4Shell RCE",                        9.8, SeverityLevel.CRITICAL),
    ("CVE-2014-0160",  "Heartbleed Memory Disclosure",            7.5, SeverityLevel.HIGH),
    ("CVE-2017-5638",  "Apache Struts2 RCE",                      10.0, SeverityLevel.CRITICAL),
    ("CVE-2019-19781", "Citrix Path Traversal",                   9.8, SeverityLevel.CRITICAL),
    ("CVE-2020-1472",  "Zerologon Privilege Escalation",          10.0, SeverityLevel.CRITICAL),
    ("CVE-2023-46604", "Apache ActiveMQ RCE",                     10.0, SeverityLevel.CRITICAL),
    ("CVE-2024-3094",  "XZ Utils Backdoor",                       10.0, SeverityLevel.CRITICAL),
    # Add 5-10 more medium/low severity ones for variety
    ("CVE-2022-30190", "Follina MSDT RCE",                        7.8, SeverityLevel.HIGH),
    ("CVE-2023-4863",  "WebP Heap Overflow",                      8.8, SeverityLevel.HIGH),
    ("CVE-2023-50164", "Apache Struts File Upload",               9.8, SeverityLevel.CRITICAL),
    ("CVE-2022-26134", "Confluence OGNL Injection",               9.8, SeverityLevel.CRITICAL),
    ("CVE-2021-26855", "Microsoft Exchange SSRF (ProxyLogon)",    9.1, SeverityLevel.CRITICAL),
]

CVE_COUNT_RANGES = {
    ArchetypeType.LEGACY_MONOLITH:     (4, 10),  # the worst — old, unpatched
    ArchetypeType.MODERN_MICROSERVICE: (0, 2),
    ArchetypeType.COTS_VENDOR:         (2, 6),
    ArchetypeType.INTERNAL_TOOL:       (1, 4),
    ArchetypeType.COMPLIANCE_CRITICAL: (0, 1),   # the best — heavily audited
}
```

### 2. Implement `generate_security_findings()` (25 min)

```python
def generate_security_findings(apps, rng, fake) -> List[SecurityFinding]:
    findings = []
    for app in apps:
        low, high = CVE_COUNT_RANGES[app.archetype]
        n = rng.randint(low, high)
        sampled = rng.sample(CVE_CATALOG, k=min(n, len(CVE_CATALOG)))

        for cve_id, title, cvss, severity in sampled:
            has_fix = rng.random() < 0.6  # 60% have fixes available
            findings.append(SecurityFinding(
                id=f"vuln-{fake.uuid4()[:8]}",
                application_id=app.id,
                cve_id=cve_id,
                title=title,
                severity=severity,
                cvss_score=cvss,
                discovered_date=fake.date_between(start_date="-2y", end_date="today"),
                remediation_available=has_fix,
                remediation_steps="Vendor patch available" if has_fix else None,
                mitigation_status=None if has_fix else "Isolated from public internet",
            ))
    return findings
```

### 3. Implement `generate_operational_metrics()` (25 min)

Per-archetype value ranges, drawn from `docs/data_design.md`:

```python
METRIC_RANGES = {
    # archetype: (incidents, mttr_hrs, availability_pct, cpu_pct)
    ArchetypeType.LEGACY_MONOLITH:     ((5, 10), (8.0, 24.0), (95.0, 98.0), (60.0, 90.0)),
    ArchetypeType.MODERN_MICROSERVICE: ((0, 1),  (0.1, 0.5),  (99.95, 99.99), (10.0, 30.0)),
    ArchetypeType.COTS_VENDOR:         ((1, 4),  (2.0, 8.0),  (99.0, 99.9), (40.0, 70.0)),
    ArchetypeType.INTERNAL_TOOL:       ((0, 2),  (4.0, 12.0), (97.0, 98.5), (1.0, 5.0)),
    ArchetypeType.COMPLIANCE_CRITICAL: ((0, 1),  (0.5, 2.0),  (99.95, 99.99), (30.0, 60.0)),
}

def generate_operational_metrics(apps, rng, fake) -> List[OperationalMetric]:
    metrics = []
    for app in apps:
        (i_lo, i_hi), (m_lo, m_hi), (a_lo, a_hi), (c_lo, c_hi) = METRIC_RANGES[app.archetype]
        metrics.append(OperationalMetric(
            id=f"metric-{fake.uuid4()[:8]}",
            application_id=app.id,
            incidents_last_quarter=rng.randint(i_lo, i_hi),
            mttr_hours=round(rng.uniform(m_lo, m_hi), 2),
            availability_pct=round(rng.uniform(a_lo, a_hi), 3),
            cpu_utilization_pct=round(rng.uniform(c_lo, c_hi), 2),
        ))
    return metrics
```

### 4. Wire both into `generate_portfolio()` (5 min)

After the dependency commit:

```python
findings = generate_security_findings(apps, rng, fake)
metrics  = generate_operational_metrics(apps, rng, fake)
session.add_all(findings)
session.add_all(metrics)
session.commit()
print(f"Seeded {len(findings)} security findings + {len(metrics)} metrics.")
```

Update `wipe()` to delete these too.

### 5. Run and verify (15 min)

```cmd
uv run python scripts\generate.py --wipe
```

In psql:

```sql
-- Should have ~150 findings (avg 3 per app)
SELECT COUNT(*) FROM security_findings;

-- Exactly one metric row per app
SELECT COUNT(*) FROM operational_metrics;  -- should be 50

-- The big payoff query — does the archetype story hang together?
SELECT a.archetype,
       COUNT(DISTINCT a.id)      AS apps,
       COUNT(DISTINCT sf.id)     AS findings,
       ROUND(AVG(om.availability_pct)::numeric, 2) AS avg_availability,
       ROUND(AVG(om.incidents_last_quarter)::numeric, 2) AS avg_incidents
FROM applications a
LEFT JOIN security_findings sf ON sf.application_id = a.id
LEFT JOIN operational_metrics om ON om.application_id = a.id
GROUP BY a.archetype
ORDER BY avg_availability;
```

The story should be: Legacy Monoliths have the most findings + lowest availability + most incidents. Modern Microservices have the cleanest profile. Compliance-Critical has high availability but variable findings.

## Verification: Done when…

- All five archetypes show the EXPECTED tier in the big query
- No app has zero metrics rows
- The numbers feel like a real enterprise summary

---

# Friday — QA + reproducibility + commit (2 hrs)

## Goal

The dataset is trustworthy enough that you'd hand it to a hiring manager. The generator is reproducible from a single `make seed` command. Documentation reflects reality.

## Subtasks

### 1. Manual spot-check (30 min)

In psql, pick 5 random apps and look at their FULL story:

```sql
SELECT a.id, a.name, a.archetype, a.criticality, a.runtime_version,
       i.os_name, i.os_eol_date,
       om.availability_pct, om.incidents_last_quarter,
       (SELECT COUNT(*) FROM security_findings WHERE application_id = a.id) AS cve_count,
       (SELECT COUNT(*) FROM dependencies WHERE source_app_id = a.id) AS out_deps,
       (SELECT COUNT(*) FROM dependencies WHERE target_app_id = a.id) AS in_deps
FROM applications a
JOIN infrastructure i ON i.id = a.infrastructure_id
JOIN operational_metrics om ON om.application_id = a.id
ORDER BY random()
LIMIT 5;
```

For each row, ask: does the story make sense? Examples of red flags:
- Legacy monolith with 99.99% availability → bug in metric ranges
- Modern microservice with 8 CRITICAL CVEs → bug in CVE distribution
- Compliance-Critical app with criticality=LOW → bug in app generator

### 2. Document oddities in `docs/dataset-qa.md` (20 min)

For each oddity you found and fixed: one sentence describing it, one sentence on the fix. If you found none, write "Spot-checked 5 random apps; archetype-driven patterns held as expected" — even a clean QA is a result worth noting.

Example:

```markdown
# Dataset QA — Week 3

Spot-checked 5 random applications across all 5 archetypes. Findings:

1. **app-3f8a2b9c** (Legacy Monolith) showed availability 99.5% — too high for a
   monolith on RHEL 6. Root cause: `METRIC_RANGES` tuple was misaligned.
   Fixed and re-ran.

2. **app-7c44d811** (Modern Microservice) had a CRITICAL Log4Shell CVE.
   Not impossible (Java microservices can have it), but felt overweighted.
   Adjusted `CVE_COUNT_RANGES[MODERN_MICROSERVICE]` from (0, 4) to (0, 2).

3-5. No issues — archetype patterns held cleanly.
```

### 3. Add `make seed` / `make wipe-seed` (10 min)

Edit `makefile`:

```makefile
.PHONY: up down psql seed wipe-seed test

up:
	docker compose up -d
down:
	docker compose down
psql:
	docker exec -it pgvector_db psql -U postgres -d mydb
seed:
	uv run python scripts/generate.py
wipe-seed:
	uv run python scripts/generate.py --wipe
test:
	uv run pytest -v
```

### 4. Verify reproducibility (10 min)

```cmd
make wipe-seed
make psql
```

Save 3 app IDs you see. Then:

```cmd
make wipe-seed
make psql
```

The 3 app IDs should be IDENTICAL on the second run. If they differ, your seed isn't being applied somewhere — likely `Faker()` was instantiated without `seed_instance(seed)`, or you used the global `random` module instead of `rng`. Fix it.

### 5. Optional but recommended: pg_dump (10 min)

```cmd
docker exec pgvector_db pg_dump -U postgres -d mydb --data-only > data\seed.sql
```

This dumps the current data to a SQL file you can commit. Belt-and-suspenders reproducibility: if anyone ever wants to skip running the generator, they can `psql < data/seed.sql` instead.

### 6. Commit + push (15 min)

Two clean commits:

```cmd
git add scripts/generate.py scripts/inspect_graph.py docs/dataset-qa.md makefile pyproject.toml uv.lock
git commit -m "feat(data): synthetic 50-app portfolio generator + graph inspector"
git push

git add data/seed.sql
git commit -m "data: commit reproducible seed dump"
git push
```

### 7. Update README "Project Status" (5 min)

```markdown
## Project Status

**Current phase:** Phase 0 — Foundations

- Week 1: ✅ Complete
- Week 2: ✅ Complete (SQLAlchemy + Alembic, smoke tests)
- Week 3: ✅ Complete (50-app synthetic portfolio with dependencies, CVEs, metrics)
- Week 4: in progress — Eval harness skeleton + 20 scenarios
```

Final commit:

```cmd
git add readme.md
git commit -m "docs: mark week 3 complete"
git push
```

---

## Checkpoint: Week 3 Done

- [ ] `scripts/generate.py` produces 50 apps + 50 infra + dependencies + findings + metrics in one command
- [ ] Archetype distribution matches the spec (~30/25/20/15/10)
- [ ] Dependency graph is one connected component (verified by NetworkX)
- [ ] `inspect_graph.py` confirms realistic in/out-degree distributions
- [ ] Per-archetype patterns hold (legacy = worst, microservices = best)
- [ ] Fixed RNG seed → IDENTICAL portfolio on every re-run
- [ ] `make seed` / `make wipe-seed` work
- [ ] `docs/dataset-qa.md` written
- [ ] `data/seed.sql` committed (optional)
- [ ] README updated
- [ ] All commits pushed

---

## Common pitfalls (read once, recognize when you see them)

- **Non-determinism creeps in via `random.uuid4()`** — use `fake.uuid4()[:8]` from a seeded Faker, never the bare `uuid.uuid4()`.
- **`Faker()` without `seed_instance(seed)`** — Faker has its own RNG; you must seed it explicitly. `fake.seed_instance(seed)` is the call.
- **Mixing `rng.random()` and `random.random()`** — pick one RNG and pass it around. The global `random` module ignores your seed unless you also do `random.seed(seed)`.
- **Adding a row whose FK target wasn't committed yet** — same class of bug that broke last Saturday's dependency test. Either `session.flush()` between dependent inserts, or add a relationship to teach the unit-of-work the order.
- **Forgetting to update `wipe()` when adding new entity types** — failed wipes leave orphan data that breaks the next run.

---

## What Week 4 looks like (no need to plan it now)

Week 4 is **eval harness skeleton + 20 test scenarios**. You'll handpick apps from your generated portfolio and write the expected 6R decision for each, plus the keywords the explanation should mention. This becomes the "definition of correct" for the AI you build in Phase 1. The detailed Week 4 daily breakdown gets written at the END of Week 3, once you know where you actually landed.

---

*Document version: 1.0. Update freely — this is a living plan. Version every change.*