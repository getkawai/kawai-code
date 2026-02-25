#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: not inside a git repository" >&2
  exit 1
fi

if ! git remote get-url origin >/dev/null 2>&1; then
  echo "Error: missing required remote 'origin'" >&2
  exit 1
fi

if ! git remote get-url upstream >/dev/null 2>&1; then
  echo "Error: missing required remote 'upstream'" >&2
  exit 1
fi

branch="$(git rev-parse --abbrev-ref HEAD)"
if [[ "$branch" != "main" ]]; then
  echo "Error: current branch is '$branch'; switch to 'main' first" >&2
  exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
  echo "Error: working tree is not clean; commit or stash changes first" >&2
  exit 1
fi

echo "Fetching origin and upstream..."
git fetch --prune origin
git fetch --prune upstream

echo "Rebasing main onto upstream/main..."
git rebase upstream/main

echo "Pushing main to origin..."
git push origin main

echo "Sync complete: main is rebased onto upstream/main and pushed to origin/main."
