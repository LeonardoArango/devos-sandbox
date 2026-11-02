#!/usr/bin/env bash
# Documenta SIEMPRE en GitHub Issues. El archivo specs/<id>/spec.md es la fuente; el Issue lleva la Spec COMPLETA
# (regenerada en cada versión), las decisiones del challenge y las notas de avance como comentarios.
# Uso:
#   devos-issue.sh publicar <id>          crea el Issue (borrador) o actualiza su cuerpo con la versión actual de la Spec
#   devos-issue.sh nota <id> <archivo.md> agrega un comentario (plan, recibo, retro, decisión) al Issue de la Spec
# Requiere gh autenticado. Cada llamada es escritura externa: permiso "ask" (tú apruebas).
set -euo pipefail
cd "${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel)}"
die(){ echo "devos-issue: $*" >&2; exit 1; }
cmd=${1:-}; id=${2:-}
[[ -n "$cmd" && -n "$id" ]] || die "uso: devos-issue.sh publicar <id> | nota <id> <archivo.md>"
spec="specs/$id/spec.md"; [[ -f "$spec" ]] || die "no existe $spec"
command -v gh >/dev/null || die "falta gh (https://cli.github.com) y 'gh auth login'"
fm(){ awk 'NR==1&&/^---$/{f=1;next} f&&/^---$/{exit} f' "$spec" | sed -n "s/^$1:[[:space:]]*//p" | sed 's/[[:space:]]*#.*$//; s/^"//; s/"$//' | head -1; }
url=$(fm issue); [[ "$url" =~ ^https://github\.com/.+/issues/[0-9]+$ ]] || url=""
case "$cmd" in
publicar)
  repo=$(gh repo view --json nameWithOwner -q .nameWithOwner)
  titulo=$(fm titulo); version=$(fm version); camino=$(fm camino); estado=$(fm estado); aprob=$(fm aprobado)
  body=$(mktemp); trap 'rm -f "$body"' EXIT
  {
    echo "> **Spec v${version:-?}** · camino: ${camino:-?} · estado: ${estado:-?} · fuente: [\`$spec\`](https://github.com/$repo/blob/feat/$id/$spec) (rama \`feat/$id\`; tras el merge, en \`main\`)"
    echo "> Cuerpo generado por \`devos-issue.sh\` desde el repo: no lo edites a mano (los cambios se pierden)."
    echo
    echo "**Autonomía:** preautoriza \`$(fm preautoriza)\` · aprobado: ${aprob:-pendiente (./devos aprobar o etiqueta aprobada)}"
    echo
    awk 'NR==1&&/^---$/{f=1;next} f&&/^---$/{f=0;next} !f' "$spec"
  } > "$body"
  (( $(wc -c <"$body") < 60000 )) || die "la Spec supera el límite de un Issue (~65k): pártela en rebanadas"
  if [[ -z "$url" ]]; then
    url=$(gh issue create --title "[SPEC] $titulo" --body-file "$body" --label spec --label needs-approval)
    sed -i.bak -E "s|^issue:.*|issue: $url|" "$spec" && rm -f "$spec.bak"
    echo "Issue creado: $url (enlazado en $spec)"
    if [[ -f "research/$id.md" ]]; then          # primera vez: deja el challenge documentado en el Issue
      c=$(mktemp); { echo "## Investigación y challenge"; echo "Fuente: \`research/$id.md\`"; echo;
        awk '/^## [0-9]+\. /{p=($2 ~ /^(1|5|6|7)\.$/)} p' "research/$id.md"; } > "$c"
      gh issue comment "$url" --body-file "$c" >/dev/null && echo "Decisiones del challenge publicadas como comentario."; rm -f "$c"
    fi
  else
    gh issue edit "$url" --body-file "$body" >/dev/null
    gh issue comment "$url" --body "Spec actualizada a v${version:-?} (estado: ${estado:-?})." >/dev/null
    echo "Issue actualizado: $url"
  fi ;;
nota)
  [[ -n "$url" ]] || die "la Spec $id aún no tiene Issue: primero 'publicar'"
  f=${3:-}; [[ -f "$f" ]] || die "uso: devos-issue.sh nota <id> <archivo.md>"
  gh issue comment "$url" --body-file "$f" >/dev/null && echo "Nota publicada en $url" ;;
*) die "comando desconocido: $cmd" ;;
esac
