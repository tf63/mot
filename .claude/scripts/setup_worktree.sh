#!/usr/bin/env bash

set -euo pipefail

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <branch-name>"
  exit 1
fi

BRANCH_NAME="$1"
WORKTREE_NAME="${BRANCH_NAME##*/}"
WORKTREE_DIR="worktrees/${WORKTREE_NAME}"

COPY_FILES=()

echo "==> Creating worktree: ${WORKTREE_DIR}"
echo "    branch: ${BRANCH_NAME}"

git worktree add "${WORKTREE_DIR}" "${BRANCH_NAME}"

echo "==> Copying files and directories"

for file in "${COPY_FILES[@]}"; do
  if [[ ! -e "${file}" ]]; then
    echo "    SKIP: path not found: ${file}"
    continue
  fi

  destination="${WORKTREE_DIR}/${file}"
  mkdir -p "$(dirname "${destination}")"

  cp -a "${file}" "${destination}"

  echo "    ${file} -> ${destination}"
done

echo
echo "==> Done: ${WORKTREE_DIR}"
