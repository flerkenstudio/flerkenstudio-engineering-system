---
name: ponytail-debt
description: Finds documented shortcut comments and turns their stated limitations into a clear technical-debt ledger without silently changing code.
---

# Ponytail debt ledger

Search the repository for `shortcut:` and legacy `ponytail:` comments. Also inspect any existing debt ledger before proposing changes.

For each marker, capture: file and line, current shortcut/limitation, condition that triggers an upgrade, user or operational impact, and suggested next step. Group duplicates only when they represent the same underlying issue.

Do not infer a deadline, severity, or upgrade requirement not supported by code or project context. Do not remove markers or modify implementation. Present the ledger in the response; create/update a tracked Markdown ledger only when the user explicitly asks for a file artifact. Report searched paths and any excluded areas.
