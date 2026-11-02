#!/usr/bin/env bash
# PreToolUse (Edit|Write|MultiEdit): paths protegidos + nadie se autoaprueba.
# Siempre protegidos: secretos, guardrails, ./devos, memoria procedimental (AGENTS.md, CLAUDE.md, skills, agentes,
# .claude/), memory/base y lecciones, CI, .mcp.json. Condicionales (migraciones, auth, infra): editables solo si la
# Spec de la rama está aprobada y los preautoriza (campo `preautoriza:`). Ajusta los regex a tu repo.
set -euo pipefail
source "$(dirname "$0")/_spec.sh"
in=$(cat)
f=$(jq -r '.tool_input.file_path // .tool_input.path // empty' <<<"$in")
[[ -z "$f" ]] && exit 0
deny(){ jq -n --arg r "$1" '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$r}}'; exit 0; }
SIEMPRE='(^|/)(\.env[^/]*|\.devos\.env$|guardrails/|devos$|memory/base/|memory/lecciones/|\.github/workflows/|\.claude/|\.agents/skills/|AGENTS\.md$|CLAUDE\.md$|\.mcp\.json$)'
# Sesión ./devos memoria (variable del proceso de Claude Code, que el agente no puede cambiar): permite aplicar
# propuestas aprobadas por el dueño a AGENTS.md, CLAUDE.md, skills propias y agentes. Nunca vendor, guardrails ni settings.
MEMORIA='(^|/)(AGENTS\.md$|CLAUDE\.md$|memory/lecciones/|\.claude/agents/|\.agents/skills/)'
if [[ "${DEVOS_MODO_MEMORIA:-}" == 1 && "$f" =~ $MEMORIA && ! "$f" =~ /vendor/|/(emil-[^/]+|impeccable|taste)/ ]]; then exit 0; fi
[[ "$f" =~ $SIEMPRE ]] && deny "Path protegido ($f). Memoria procedimental → propuesta en memory/propuestas/. Resto → guardrails/acciones-humanas.md. En modo autónomo: anótalo en BLOQUEO.md si es imprescindible."
spec=$(spec_de_rama)
for par in 'migraciones:(^|/)(migrations|migrate|alembic|prisma/migrations)/' 'auth:(^|/)auth/' 'infra:(^|/)(infra|terraform|k8s|helm)/|(^|/)(Dockerfile|docker-compose[^/]*)$'; do
  cat=${par%%:*}; re=${par#*:}
  if [[ "$f" =~ $re ]] && ! preautoriza "$spec" "$cat"; then
    deny "$f es '$cat' y la Spec no lo preautoriza (campo preautoriza:). Escribe BLOQUEO.md explicando por qué hace falta."
  fi
done
# Nadie se autoaprueba: solo ./devos aprobar (o la etiqueta 'aprobada' puesta por el dueño) escribe estado/aprobado/preautoriza.
if [[ "$f" =~ (^|/)specs/[^/]+/spec\.md$ ]]; then
  txt=$(jq -r '[.tool_input.content, .tool_input.new_string, (.tool_input.edits // [] | .[].new_string)] | map(select(.!=null)) | join("\n")' <<<"$in")
  if grep -Eq '^estado:[[:space:]]*aprobada' <<<"$txt"; then
    # Reescribir el archivo completo de una Spec YA aprobada conserva su línea: solo se bloquea si el archivo no está aprobado.
    if ! spec_aprobada "$f"; then deny "Solo el dueño aprueba una Spec (./devos aprobar). Déjala en borrador."; fi
  fi
  if [[ -f "$f" ]] && spec_aprobada "$f"; then
    old=$(fm_get "$f" preautoriza); new=$(sed -n 's/^preautoriza:[[:space:]]*//p' <<<"$txt" | sed 's/[[:space:]]*#.*$//' | head -1)
    [[ -n "$new" && "$new" != "$old" ]] && deny "No puedes ampliar 'preautoriza' de una Spec aprobada."
  fi
fi
exit 0
