#!/usr/bin/env bash
# PreToolUse (Edit|Write|Bash): bloquea contenido o comandos que parezcan secretos. Complementa gitleaks + push protection.
set -euo pipefail
payload=$(jq -r '[.tool_input.content, .tool_input.new_string, .tool_input.command, (.tool_input.edits // [] | .[].new_string)] | map(select(.!=null)) | join("\n")')
PATRONES='(AKIA[0-9A-Z]{16}|-----BEGIN [A-Z ]*PRIVATE KEY-----|ghp_[A-Za-z0-9]{36}|github_pat_[A-Za-z0-9_]{20,}|xox[bpas]-[A-Za-z0-9-]+|sk-[A-Za-z0-9_-]{20,}|(sk|rk)_live_[A-Za-z0-9]{16,}|AIza[0-9A-Za-z_-]{35}|(password|passwd|secret|api[_-]?key|token)[[:space:]]*[:=][[:space:]]*["'"'"'][^"'"'"']{8,})'
if grep -Eiq "$PATRONES" <<<"$payload"; then
  jq -n '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:"Posible secreto detectado. Usa variables de entorno o un gestor de secretos; nunca lo escribas en código, prompts ni logs."}}'
fi
exit 0
