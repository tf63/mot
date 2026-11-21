#!/usr/bin/env bash

set -euo pipefail

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "?"')
dir=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // empty')
effort=$(echo "$input" | jq -r '.effort.level // empty')
ctx=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // empty')
five=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
week=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')

# モデル / effort / コンテキスト使用率
line="💎 $model"
[ -z "$effort" ] || line="$line ($effort)"
[ -z "$ctx" ] || line="$line · $(printf '%.0f' "$ctx")% used"

# ディレクトリ / git
line="$line | 📁 $(basename "${dir:-?}")"

branch=$(git -C "$dir" branch --show-current 2>/dev/null || true)
if [ -n "$branch" ]; then
  if [ -n "$(git -C "$dir" status --porcelain 2>/dev/null || true)" ]; then
    branch="$branch*"
  fi
  line="$line (⎇ $branch)"
fi

# コスト
[ -z "$cost" ] || line="$line | 💰 \$$(printf '%.2f' "$cost")"

# プランの使用量(5時間枠・週間枠)
limits=""
[ -z "$five" ] || limits="5h:$(printf '%.0f' "$five")%"
[ -z "$week" ] || limits="${limits:+$limits, }7d:$(printf '%.0f' "$week")%"
[ -z "$limits" ] || line="$line | 🔋 $limits"

echo "$line"
printf '\xe2\xa0\x80\n' # 空行

exit 0
