# Agent Instructions

This repo adopts [LPFchan/repo-template](https://github.com/LPFchan/repo-template) conventions. Treat **`AGENTS.md`** as the canonical editable agent-instructions file and defer details to **`REPO.md`**.

## Read first

- **This repo’s** `REPO.md` (root) — not `scaffold/REPO.md` unless you are copying the scaffold elsewhere
- `SPEC.md`
- `STATUS.md`
- `PLANS.md`
- `INBOX.md`
- `skills/README.md`

The macOS application source is under **`apps/kkamppak/`** (`kkamppak.xcodeproj`, Swift sources, helper scripts in `apps/kkamppak/Scripts/`).

## Operating rules

- Keep durable truth in repo files.
- Route work using the ladder in `REPO.md`.
- Preserve boundaries between SPEC / STATUS / PLANS / INBOX / research / records / worklogs.
- Prefer appending to an existing relevant `LOG-*` before creating a new one.
- If commit hooks are enabled, include required trailers (`project`, `agent`, `role`, `artifacts`) or an explicit bootstrap/migration exception.

## Enforcement

- Do not collapse truth, plans, inbox, and worklogs into one mixed artifact.
- Follow directory `README.md` shapes when they define one.
- For product code changes, match existing Swift and shell style in `apps/kkamppak/`.

## Skills

See `skills/*/SKILL.md` for bounded procedures (aligned with [repo-template](https://github.com/LPFchan/repo-template) `scaffold/skills/`). Do not duplicate root `REPO.md` policy inside skills.

To adopt the same system in **another** repository, use [`recreate-prompt.md`](recreate-prompt.md) and copy from [`scaffold/`](scaffold/README.md) to that repo’s root.
