# Repo Operating Model

This document is the canonical repo contract for this repository. It follows the layout and discipline described in [LPFchan/repo-template](https://github.com/LPFchan/repo-template).

## Purpose

Keep product truth, current status, and agent workflows legible in-repo. The macOS app lives under `apps/kkamppak/`.

**Canonical rules for this repo** are this file (루트 `REPO.md`) plus 루트의 `SPEC.md` / `STATUS.md` / `PLANS.md` / `INBOX.md`.  
복사용 스캐폴드 원본은 이 레포에 두지 않고 **[LPFchan/repo-template의 `scaffold/`](https://github.com/LPFchan/repo-template/tree/main/scaffold)** 만 유지합니다. 다른 레포에 같은 체계를 심을 때는 [`recreate-prompt.md`](recreate-prompt.md)와 업스트림 트리를 쓰면 됩니다.

## Project identity

- **Project id:** `kkamppak`
- **Canonical repo:** https://github.com/devuterian/kkamppak
- **Primary code:** `apps/kkamppak/` (Xcode project + Swift AppKit app)

## Core Surfaces

| Surface | Role | Mutability |
| --- | --- | --- |
| `SPEC.md` | Durable statement of what the product is supposed to be. | rewritten |
| `STATUS.md` | Current operational truth. | rewritten |
| `PLANS.md` | Accepted future direction. | rewritten |
| `INBOX.md` | Ephemeral capture waiting for triage. | append then purge |
| `research/` | Curated research memos. | append by new file |
| `records/decisions/` | Decision records with rationale. | append-only |
| `records/agent-worklogs/` | Execution history. | append-only |
| `skills/` | Repeatable agent procedures. | edit by skill |

This repo does **not** use `upstream-intake/` unless we start tracking an upstream on a cadence.

## Agent entrypoints

- **`AGENTS.md`** — canonical editable agent instructions; defer policy details to this file.
- **`CLAUDE.md`** — thin shim for Claude Code; points to `AGENTS.md`.

## Commit provenance

Every commit should include these trailers (unless an explicit bootstrap/migration exception):

- `project: kkamppak`
- `agent: <id>`
- `role: orchestrator|worker|subagent|operator`
- `artifacts: ART-YYYYMMDD-NNN[, ...]`

Local hook: `.githooks/commit-msg` → `scripts/check-commit-standards.sh`.  
Remote check: `.github/workflows/commit-standards.yml`.

## Routing ladder

When classifying work, prefer the order in repo-template’s `REPO.md`: inbox → truth (`SPEC`) → status → plans → research → decisions → worklogs.

## Separation rules (summary)

- `SPEC.md` is not a changelog.
- `STATUS.md` is not a transcript.
- `PLANS.md` is not a brainstorm dump.
- `INBOX.md` is not durable truth.

For the full contract text, see [repo-template scaffold REPO.md](https://github.com/LPFchan/repo-template/blob/main/scaffold/REPO.md).
