#!/usr/bin/env bash

set -euo pipefail

INPUT="$(cat)"

deny() {
  local reason="$1"

  jq -n \
    --arg reason "$reason" \
    '{
      hookSpecificOutput: {
        hookEventName: "PreToolUse",
        permissionDecision: "deny",
        permissionDecisionReason: $reason
      }
    }'

  exit 2
}

FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path')

case "$FILE_PATH" in
node_modules/* | */node_modules/* | \
  deprecated/* | */deprecated/*)
  deny "Reading blocked: $FILE_PATH"
  ;;
esac

if [[ -f "$FILE_PATH" ]]; then
  LINES=$(wc -l <"$FILE_PATH")

  if ((LINES > 2000)); then
    deny "$(
      cat <<EOF
Blocked large file: $FILE_PATH ($LINES lines)

Never read the entire file.
Read only the relevant section.

Use:
- rg --heading -n to find symbols/classes
- sed -n START,ENDp to read a small range
- head for the beginning of the file
- tail for the end of the file

Examples:
  rg --heading -n 'def perform' $FILE_PATH
  sed -n '120,180p' $FILE_PATH
  head -100 $FILE_PATH
  tail -100 $FILE_PATH
EOF
    )"
  fi
fi
