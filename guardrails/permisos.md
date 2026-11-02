# Permisos y sandbox
**Modo autónomo:** `./devos run` lanza sesiones headless con `--permission-mode dontAsk`: todo lo que no esté en `allow` se deniega sin preguntar (nada se queda esperando). Lo externo (push, PR, merge, Issues) lo hace el script, no el modelo. Herramientas extra solo por preautorización (p. ej. `npm install` si `preautoriza` incluye `dependencias`; WebFetch/WebSearch solo en la fase de plan).
**Principio:** mínimo privilegio; la política vive en `.claude/settings.json` y hooks, no en el prompt.

| Riesgo | Ejemplos | Regla |
|---|---|---|
| R0 lectura local | leer código, grep, git diff | allow |
| R1 escritura local reversible | editar en rama, commit, tests | allow (paths protegidos: deny + hook) |
| R2 externo reversible | push de rama, crear issue/PR, instalar dependencia, WebFetch, MCP | ask |
| R3 irreversible | force-push, push/merge a main, deploy, secretos, borrar | deny → lo hago yo |

- `.claude/settings.json` versionado; overrides en `.claude/settings.local.json` (gitignored). Revisar con `/permissions`.
- Sandbox de Bash (`/sandbox`): escritura solo en el repo; red solo a registries (npm/pypi), github.com y lo que el proyecto necesite. En Windows nativo: WSL2 o devcontainer.
- **Playwright MCP** (`.mcp.json`, versión fijada, `npx --no-install`): headless, perfil aislado, solo `localhost`/`127.0.0.1`, sin service workers ni WebMCP, sin imágenes en respuestas. Allow: snapshot, click, escribir, capturas. Ask: `browser_navigate`, `browser_evaluate`, subir archivos, `playwright install`, `--update-snapshots`. Deny: editar `.mcp.json` y `npx …@latest`. `--allowed-origins` **no** es frontera de seguridad (no cubre redirecciones): la frontera es el sandbox de red.
- Nada de instalar paquetes, navegadores ni Lighthouse sin mi OK; `instalar.sh` solo imprime los comandos.
- GitHub: `gh` con mi login; si uso GitHub MCP, en modo solo lectura salvo en fases 3 y 5. Nunca tokens en archivos o prompts.
- Red final: gitleaks (pre-commit + GitHub Action), push protection, protección de rama en `main` (PR + checks verdes).
- **Skills vendorizadas** (`.agents/skills/vendor/`, ver `VENDORED.md`): editarlas está bloqueado (`protect-paths.sh` + deny `Edit`). Allow solo `node …/taste/scripts/lint.mjs` y `draw.mjs` (locales, sin red); `inspect.mjs`/`scenes.mjs` abren Chrome local → piden permiso. Env fijo: `DO_NOT_TRACK=1`, `IMPECCABLE_NO_TELEMETRY=1`, historial de Taste en `.taste-skill/`.
