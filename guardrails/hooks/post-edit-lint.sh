#!/usr/bin/env bash
# PostToolUse (Edit|Write): lint rápido del archivo editado; el resultado vuelve al agente.
f=$(jq -r '.tool_input.file_path // empty')
case "$f" in
  *.ts|*.tsx|*.js) npx --no-install eslint --quiet "$f" 2>&1 | tail -20 ;;
  *.py) ruff check "$f" 2>&1 | tail -20 ;;
esac
exit 0
