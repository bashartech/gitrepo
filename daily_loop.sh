#!/usr/bin/env bash
set -uo pipefail

cd "$(dirname "$0")"

DATE=$(date +%Y-%m-%d)
HEADER="## Findings ($DATE)"

TODOS=$(grep -rn "TODO" --include="*.py" --include="*.md" --include="*.sh" . \
  | grep -v "\.git/" \
  | grep -v "daily_loop.sh" \
  | grep -v "progress.md" \
  | grep -v "node_modules/" \
  | grep -v "agentfactory-labs/" \
  | grep -v "\.claude/" \
  | grep -v "\.opencode/" \
  | grep -v "\.pytest_cache/" \
  | grep -v "\.deepeval/" \
  | head -20 || true)
[ -z "$TODOS" ] && TODOS="- no TODOs found"

SUMMARY=$(mktemp)
echo "Running daily loop for $DATE"
echo ""
echo "TODO comments in repo:"
echo "$TODOS"

printf '%s\n' "$HEADER" > "$SUMMARY"
printf 'Todo count: %s\n' "$(printf '%s\n' "$TODOS" | grep -c './' )" >> "$SUMMARY"
printf '%s\n' "$TODOS" >> "$SUMMARY"
printf '%s\n' "" >> "$SUMMARY"
printf '%s\n' "---" >> "$SUMMARY"

if [ -f progress.md ]; then
  tail -n +2 progress.md >> "$SUMMARY"
else
  printf '%s\n' "# Progress" >> "$SUMMARY"
fi
mv "$SUMMARY" progress.md

echo ""
echo "progress.md updated for $DATE"
