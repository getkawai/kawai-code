# AGENT.md

Operational guide for agents working in this repository.

## Scope

- This file is a concise operational addendum.
- The canonical, detailed instruction set remains in `AGENTS.md`.
- If there is any conflict, `AGENTS.md` takes precedence.

## Repository remotes

Use this remote model consistently:

- `origin` -> `https://github.com/getkawai/kawai-code`
- `upstream` -> `https://github.com/openai/codex`

Do not swap these roles.

## Branch policy

- Keep `main` aligned with `origin/main`.
- Sync changes from `upstream/main` regularly.
- Place Kawai-specific work on topic branches and merge via PR.

## Upstream sync

Preferred one-command flow:

```bash
just sync-upstream
```

This runs `scripts/sync-upstream.sh`, which:

1. Verifies remotes and branch state.
2. Fetches `origin` and `upstream`.
3. Rebases local `main` onto `upstream/main`.
4. Pushes `main` to `origin/main`.

Manual and setup details: `SYNC_UPSTREAM.md`.

## Rebranding guardrails

- Treat rebranding as phased, not big-bang.
- Preserve compatibility-critical identifiers unless explicitly approved (e.g. package names, crate prefixes, binary names).
- Prefer making repo/workflow/docs references repository-aware (dynamic or allowlisted) over hardcoded single-repo assumptions.

## CI/workflow expectations

- Workflow guards should allow canonical repos (`openai/codex` and `getkawai/kawai-code`) and avoid arbitrary forks.
- Avoid introducing new hardcoded checks for only one repo unless there is a strict security requirement.

## Safety

- Do not run destructive git commands unless explicitly requested.
- Never rewrite history on shared branches without explicit approval.
