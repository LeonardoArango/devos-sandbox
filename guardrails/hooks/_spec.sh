#!/usr/bin/env bash
# Funciones compartidas por hooks y por ./devos. Se usa con: source "$(dirname "$0")/_spec.sh"
# La Spec "actual" es la que nombra la rama: feat/007-exportar-csv → specs/007-*/spec.md
devos_root(){ echo "${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null || pwd)}"; }
# Frontmatter (entre los dos primeros ---) de un archivo
fm_bloque(){ awk 'NR==1&&/^---$/{f=1;next} f&&/^---$/{exit} f' "$1"; }
# Valor de un campo del frontmatter, sin comentario ni comillas
fm_get(){ fm_bloque "$1" | sed -n "s/^$2:[[:space:]]*//p" | sed 's/[[:space:]]*#.*$//; s/^"//; s/"$//' | head -1; }
spec_de_rama(){ # imprime la ruta de la Spec ligada a la rama actual, o nada
  local root rama num; root=$(devos_root)
  rama=$(git -C "$root" branch --show-current 2>/dev/null || true)
  num=$(grep -oE '(^|[/_-])[0-9]{3}([_-]|$)' <<<"$rama" | grep -oE '[0-9]{3}' | head -1 || true)
  [[ -n "$num" ]] && ls "$root"/specs/"$num"-*/spec.md 2>/dev/null | head -1 || true
}
spec_aprobada(){ [[ -f "$1" && "$(fm_get "$1" estado)" == aprobada ]]; }
# ¿La Spec preautoriza la categoría? (dependencias | migraciones | auth | infra | deploy)
preautoriza(){ [[ -f "$1" ]] && spec_aprobada "$1" && fm_get "$1" preautoriza | tr -d '[] ' | tr ',' '\n' | grep -qx "$2"; }
