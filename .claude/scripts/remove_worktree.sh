#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <branch-name>"
  exit 1
fi

BRANCH_NAME="$1"
WORKTREE_NAME="${BRANCH_NAME##*/}"
WORKTREE_DIR="worktrees/${WORKTREE_NAME}"

if [[ ! -d "${WORKTREE_DIR}" ]]; then
  echo "ERROR: worktree directory not found: ${WORKTREE_DIR}"
  exit 1
fi

echo "==> Removing worktree: ${WORKTREE_DIR}"

git worktree remove --force "${WORKTREE_DIR}"

echo "==> Done: ${WORKTREE_DIR}"
