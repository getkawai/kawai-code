# Upstream Sync Guide

This repository uses:

- `origin` -> `https://github.com/getkawai/kawai-code`
- `upstream` -> `https://github.com/openai/codex`

## One-time remote setup

Run these once if your remotes still use the old layout:

```bash
git remote rename origin upstream
git remote rename kawai origin
git branch --set-upstream-to=origin/main main
```

Verify:

```bash
git remote -v
git status --short --branch
```

## Routine sync flow (recommended)

From a clean `main` branch:

```bash
scripts/sync-upstream.sh
```

The script does:

1. `git fetch --prune origin`
2. `git fetch --prune upstream`
3. `git rebase upstream/main`
4. `git push origin main`

## Manual sync flow

If you prefer manual commands:

```bash
git checkout main
git fetch --all --prune
git rebase upstream/main
git push origin main
```

## Policy suggestion

- Keep `main` in `origin` as close as possible to `upstream/main`.
- Put Kawai-specific work on topic branches and merge via PR.
- If rebase policy is not desired, replace rebase with merge:

```bash
git merge --no-ff upstream/main
git push origin main
```
