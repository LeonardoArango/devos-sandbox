#!/usr/bin/env bash
# Stop: impide "terminar" con lint/tests/E2E en rojo o secretos staged. exit 2 = bloquea y devuelve stderr al agente.
# Bucle acotado: como máximo DEVOS_MAX_REINTENTOS (def. 3) bloqueos seguidos; luego deja parar y me avisa.
# (Claude Code además corta a las 8 continuaciones seguidas por Stop hook.)
# Configura DEVOS_TEST_CMD / DEVOS_LINT_CMD; si no, autodetecta npm o Python; si no hay nada, no bloquea.
# UI: si cambiaron archivos de frontend (DEVOS_UI_REGEX), Playwright es OBLIGATORIO: corre DEVOS_E2E_CMD
# (def. "npx --no-install playwright test"); bloquea si falla o si no hay Playwright configurado.
# Sitio público (DEVOS_SITIO_PUBLICO=1, o el repo tiene robots/sitemap): además exige e2e/seo*.spec.* (skill seo-aeo),
# que corre dentro de DEVOS_E2E_CMD; el contenido (content|posts|blog|docs/*.md[x]) también cuenta como cambio de UI.
set -uo pipefail
cd "${CLAUDE_PROJECT_DIR:-.}"
[[ -f .devos.env ]] && { set -a; source .devos.env; set +a; }   # DEVOS_TEST_CMD, DEVOS_LINT_CMD, DEVOS_E2E_CMD…
[[ "${DEVOS_SALTAR_STOP:-}" == 1 ]] && { cat >/dev/null 2>&1 || true; exit 0; }   # fases sin código (verificar, retro, recibo): el orquestador ya corrió los checks
cat >/dev/null 2>&1 || true                                  # consume el JSON de entrada
MAX=${DEVOS_MAX_REINTENTOS:-3}
CNT="$(git rev-parse --git-dir 2>/dev/null || echo .)/devos-stop-reintentos"
n=$(cat "$CNT" 2>/dev/null || echo 0)
ok(){ rm -f "$CNT"; exit 0; }
bloquea(){ # $1 = mensaje
  n=$((n+1))
  if (( n > MAX )); then
    rm -f "$CNT"
    jq -nc --arg m "Stop: $1 sigue fallando tras $MAX reintentos. El agente se detiene; revisa y decide." '{systemMessage:$m}'
    echo "Límite de $MAX reintentos alcanzado: detente, resume qué falla y pide ayuda (no sigas intentando)." >&2
    exit 0
  fi
  echo "$n" > "$CNT"; echo "[$n/$MAX] $1. Corrígelo antes de cerrar:" >&2; exit 2
}
# Archivos cambiados: sin commitear + staged + nuevos no ignorados
cambios=$( { git rev-parse -q --verify HEAD >/dev/null && git diff --name-only HEAD; git diff --name-only --cached;
             git ls-files --others --exclude-standard; } 2>/dev/null | sort -u )
# Fases de documento (research, spec, memoria, evals) no disparan tests: solo cuenta el código.
cambios=$(grep -vE '^(specs|research|memory|evals)/|^NOTES\.md$' <<<"$cambios" || true)
[[ -z "$cambios" ]] && ok                                    # sin cambios de código
if [[ -f package.json ]]; then T="npm test --silent"; L="npm run lint --silent"
elif [[ -f pyproject.toml || -f setup.py ]]; then T="pytest -q"; L="ruff check ."
else T=""; L=""; fi
TEST_CMD=${DEVOS_TEST_CMD:-$T}; LINT_CMD=${DEVOS_LINT_CMD:-$L}
if [[ -n "$LINT_CMD" ]] && ! out=$($LINT_CMD 2>&1); then echo "$out" | tail -30 >&2; bloquea "Lint falla"; fi
if [[ -n "$TEST_CMD" ]] && ! out=$($TEST_CMD 2>&1); then echo "$out" | tail -30 >&2; bloquea "Tests fallan"; fi
# --- Puerta UI: Playwright obligatorio ---
UI_RE=${DEVOS_UI_REGEX:-'\.(tsx|jsx|vue|svelte|astro|css|scss|sass|less|html)$|(^|/)(components|pages|views|layouts|styles|ui)/'}
ui=$(grep -E "$UI_RE" <<<"$cambios" | grep -vE '\.(md|txt)$' | head -5)
pub=${DEVOS_SITIO_PUBLICO:-}
if [[ -z "$pub" ]]; then pub=0
  { git ls-files; git ls-files --others --exclude-standard; } 2>/dev/null | grep -v node_modules/ \
    | grep -Eq '(^|/)(robots\.(txt|ts|js)|sitemap[^/]*\.(xml|ts|js))$' && pub=1; fi
if [[ "$pub" == 1 ]]; then
  ui=$(printf '%s\n%s' "$ui" "$(grep -E '(^|/)(content|posts|blog|docs)/.*\.mdx?$|(^|/)(robots|sitemap)[^/]*$' <<<"$cambios")" | sed '/^$/d' | head -5)
fi
if [[ -n "$ui" ]]; then
  if [[ "$pub" == 1 ]] && [[ -z "$(find . -path ./node_modules -prune -o -type f -name 'seo*.spec.*' -print -quit 2>/dev/null)" ]]; then
    printf 'Sitio público con cambios:\n%s\nFalta e2e/seo.spec.ts: aplica la skill seo-aeo (pruebas-seo.md).\n' "$ui" >&2
    bloquea "Sitio público sin pruebas SEO"
  fi
  if [[ -z "${DEVOS_E2E_CMD:-}" ]] && ! ls playwright.config.* >/dev/null 2>&1; then
    printf 'Cambios de UI:\n%s\nNo hay playwright.config.*: aplica la skill pruebas-usuario (setup + tests por CA).\n' "$ui" >&2
    bloquea "UI sin pruebas Playwright configuradas"
  fi
  E2E_CMD=${DEVOS_E2E_CMD:-npx --no-install playwright test}
  if ! out=$(bash -c "$E2E_CMD" 2>&1); then
    echo "$out" | tail -40 >&2; echo "Abre la traza: npx playwright show-report / show-trace (skill depurar)." >&2
    bloquea "Pruebas de usuario (Playwright) fallan en cambios de UI"
  fi
fi
if command -v gitleaks >/dev/null && ! gitleaks protect --staged --no-banner >/dev/null 2>&1; then
  bloquea "gitleaks detectó secretos en cambios staged"; fi
ok
