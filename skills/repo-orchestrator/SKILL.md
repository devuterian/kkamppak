---
name: repo-orchestrator
description: "Route work into the correct artifact layer in this repo (repo-template style)."
argument-hint: "Task, capture item, or maintenance request"
---

# Repo Orchestrator

Use with [REPO.md](../../REPO.md).

## Procedure

1. Classify the work using the routing ladder in `REPO.md`.
2. Write or update the smallest set of artifacts that each has a **distinct job**.
3. Use stable IDs when needed: `IBX-*`, `RSH-*`, `DEC-*`, `LOG-*`.
4. Open durable artifacts with `Opened: YYYY-MM-DD HH-mm-ss KST` and `Recorded by agent: <id>`.
5. For Git commits, include trailers: `project:`, `agent:`, `role:`, `artifacts:` (or explicit bootstrap/migration exception).
6. Prefer appending to the current relevant `LOG-*` before creating a new one.

## Escalation

Escalate to the operator when changing public product contracts, security posture, or ambiguous product truth.
