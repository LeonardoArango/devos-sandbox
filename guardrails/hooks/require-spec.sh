#!/usr/bin/env bash
# PreToolUse (Edit|Write|MultiEdit): sin Spec aprobada no hay código (forzado en código, no en el prompt).
# Libres sin Spec: specs/, research/, memory/propuestas/, memory/proyecto/, evals/, NOTES.md.
# Lo demás exige rama feat/<NNN>-<slug> con specs/<NNN>-*/spec.md en `estado: aprobada` e `issue:` con URL.
# Escape para spikes: abre Claude Code con DEVOS_SIN_SPEC=1 exportado en TU terminal, en una rama spike/… que no se fusiona.
set -euo pipefail
source "$(dirname "$0")/_spec.sh"
[[ "${DEVOS_SIN_SPEC:-}" == 1 ]] && exit 0
root=$(devos_root)
f=$(jq -r '.tool_input.file_path // .tool_input.path // empty')
[[ -z "$f" ]] && exit 0
rel=${f#"$root"/}
[[ "$rel" == /* ]] && exit 0
[[ "$rel" =~ ^(specs|research|memory/propuestas|memory/proyecto|evals)/ || "$rel" == NOTES.md ]] && exit 0
deny(){ jq -n --arg r "$1" '{hookSpecificOutput:{hookEventName:"PreToolUse",permissionDecision:"deny",permissionDecisionReason:$r}}'; exit 0; }
spec=$(spec_de_rama)
[[ -z "$spec" ]] && deny "Sin Spec no hay código. Trabaja en la rama feat/<NNN>-<slug> de una Spec aprobada (flujo: ./devos nuevo \"<idea>\" → ./devos aprobar <id>)."
spec_aprobada "$spec" || deny "La Spec $(basename "$(dirname "$spec")") no está aprobada. Solo el dueño la aprueba con ./devos aprobar."
[[ "$(fm_get "$spec" issue)" =~ ^https://github\.com/.+/issues/[0-9]+$ ]] || deny "La Spec no tiene GitHub Issue enlazado (devos-issue.sh publicar)."
exit 0
