---
name: project-onboarding
description: Inspects an unfamiliar repository and produces an evidence-based architecture and risk map without changing files.
---

# Project onboarding

## Read-only discovery
1. List top-level directories and key manifests/configuration.
2. Identify languages, frameworks, runtime versions, package managers, build/test commands.
3. Map application entry points, modules, API routes, persistence, auth, integrations, and background jobs.
4. Read README, architecture docs, CI workflows, environment examples, and relevant tests.
5. Identify deployment topology only from repository evidence; mark unknowns.
6. Note security-sensitive flows and data types without printing secrets.
7. Run only safe, non-destructive inspection commands. Do not install dependencies or modify files unless asked.

## Report
- Confirmed stack and versions
- Architecture and request/data flow
- Development and test commands
- Key modules and ownership
- Security-sensitive areas
- Unknowns/assumptions
- Prioritized risks and suggested next steps

Cite paths and observed evidence. Never infer production infrastructure from a local config alone.
