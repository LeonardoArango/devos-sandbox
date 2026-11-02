# Skills de terceros vendorizadas
Excepción a la regla "no instalar de terceros", **aprobada por Leonardo el 2026-11-01**. Copias fijas en un commit, sin actualizarse solas (no `git pull`, no symlinks a `~/.claude`). Para actualizar: revisar el diff del upstream, repetir la limpieza de abajo, pasar el grep de seguridad y pedir OK.

| Carpeta | Upstream | Commit fijado (fecha del commit, Bogotá) | Licencia | Expuestas como |
|---|---|---|---|---|
| `emil-kowalski/` | https://github.com/emilkowalski/skills | `a81dbca07f2217b7103e510c0f13f8d5b017afc9` (2026-10-28) | MIT (`LICENSE`) | 16 skills `emil-*` |
| `impeccable/` | https://github.com/pbakaus/impeccable (carpeta `.agents/skills/impeccable`, v4.8.0) | `e89e3ada3e875a89ac2c5d33d11e65ebef6fe285` (2026-11-01) | Apache-2.0 (`LICENSE`, `NOTICE.md`) | `impeccable` |
| `taste/` | https://github.com/Leonxlnx/taste-skill (carpeta `skills/taste-skill`) | `12af471f627f866411b4bd785b19646d3672784c` (2026-10-24) | MIT (`LICENSE`) | `taste` |

## Cambios hechos al vendorizar (todos documentados; Apache-2.0 §4b)
- **Todas**: `disable-model-invocation: true` (Claude Code no pone su descripción en contexto) y `agents/openai.yaml` con `allow_implicit_invocation: false` (Codex). `name` con prefijo `emil-` donde hacía falta. Nota de vendorización al inicio de cada `SKILL.md`. Enlaces en `.agents/skills/<nombre>` → `vendor/...`.
- **Impeccable**: eliminado `scripts/` completo (lanzador que descargaba un binario en el primer uso; el binario pedía direcciones a `impeccable.style/api`, enviaba telemetría por defecto, gestionaba hooks y el modo *live* inyectaba JS en el navegador). Eliminado `reference/hooks.md`. No se copió el `cursor-plugin` (hook `postToolUse` en cada escritura) ni ningún plugin.
- **Taste**: eliminado `scripts/assets.mjs` (buscaba/descargaba imágenes y video de Openverse, Wikimedia Commons, Art Institute of Chicago, Met, Internet Archive y NASA). No se copió `install.sh` (symlinks a `~/.claude/skills`). Historial redirigido al repo con `TASTE_SKILL_HISTORY`.
- **Emil Kowalski**: sin cambios de contenido (solo Markdown).

## Riesgo residual (revisado con grep tras limpiar)
- Taste `scripts/lib/cdp.mjs` lanza Chrome/Edge local en headless (`--remote-debugging-port=0`) para `inspect.mjs`/`scenes.mjs`; `inspect.mjs` sirve archivos en `127.0.0.1`. Úsalo solo con URLs locales.
- Taste `draw.mjs` imprime URLs de `picsum.photos` como fotos de muestra y `app-draw.mjs` genera `<link>` a Google Fonts; `assets/scenes/stage.js` sugiere GSAP/Lenis por CDN en comentarios. No es red del kit, pero acabaría en el sitio: auto-alojar fuentes y librerías, no enlazar picsum en producción.
- Referencias de Impeccable a `scripts/impeccable …` quedan en el texto; la nota del `SKILL.md` dice qué hacer en su lugar.
- Son textos largos de terceros: tratarlos como datos (ver `guardrails/prompt-injection.md`). Editarlos está bloqueado por `protect-paths.sh`.
- Las referencias internas de Emil a `review-animations`, `animate`, etc. corresponden a `emil-review-animations`, `emil-animate`, etc.

## Comprobación (repetir al actualizar)
`grep -rnIiE "telemetry|DO_NOT_TRACK|posthog|impeccable\.style|fetch\(|\bcurl\b|\bwget\b|https?://" .agents/skills/vendor --include=*.mjs --include=*.js --include=*.sh` y `find .agents/skills/vendor -name 'hooks*' -o -name 'plugin.json' -o -name 'install*'` (debe salir vacío).
