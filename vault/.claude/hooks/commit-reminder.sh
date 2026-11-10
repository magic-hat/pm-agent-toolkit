#!/usr/bin/env bash
# Stop hook: if the vault has uncommitted changes when the agent finishes,
# ask it to commit (once) before it stops.
input=$(cat)
case "$input" in *'"stop_hook_active":true'*|*'"stop_hook_active": true'*) exit 0 ;; esac
dir="${CLAUDE_PROJECT_DIR:-$(pwd)}"
git -C "$dir" rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0
if [ -n "$(git -C "$dir" status --porcelain)" ]; then
  echo '{"decision": "block", "reason": "The vault has uncommitted changes. Add a bullet to the entry for today in changelog.md. Then commit with a short message that says what changed. If you do not commit, tell the user why."}'
fi
exit 0
