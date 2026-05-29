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