# IDEAS — backlog, not now

## Serverless / Lambda modeling (raised W3)
The current Infrastructure model assumes VM/container compute. Serverless apps
don't fit because AWS/Azure manage the OS and lifecycle.

When we add this:
- Make Application.infrastructure_id nullable
- Add SERVERLESS to EnvironmentType
- Add runtime_platform column to Application

Defer until a "Modern Serverless" archetype lands in data_design.md.

## CVEs aren't matched to tech stack

Tag each CVE with applicable stacks and sample from the matching subset

# Future System Optimization & Enhancements

## Dataset v2 — internal-tool telemetry is too homogeneous
All 7 INTERNAL_TOOLs land at 1–2 incidents / ~97–98% availability / LOW criticality, so retire-vs-rehost can't be cleanly separated on data in the current seed. v2 should widen METRIC_RANGES for INTERNAL_TOOL (e.g. incidents (0,5)) and/or add an explicit usage signal (monthly_active_users) so "low usage → retire" is real, not asserted. Deferred: would change all app IDs; not worth it mid-Phase-0.