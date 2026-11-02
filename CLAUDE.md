@AGENTS.md

## Solo Claude Code
- **Sesiones con el dueño** (`./devos nuevo`, `./devos memoria`): entrevista con AskUserQuestion, rondas de máx. 3 preguntas con tu respuesta recomendada.
- **Sesiones autónomas** (`./devos run`, headless `-p`, `--permission-mode dontAsk`): una fase o una tarea por sesión, contexto limpio. Lo que no está en `allow` se deniega solo; no lo intentes por otra vía.
- **Subagentes** con mínimo privilegio para explorar, investigar en la web, dudar y verificar: el principal no lee la web ni se autoevalúa.
- Si el dueño te corrige en una sesión interactiva: no repitas el intento en el hilo (él usa `/rewind`); deja la lección en `memory/propuestas/`.
- `/clear` entre fases; `/compact <foco>` antes de saturar (ver `tokens.md`).
- Permisos y hooks: `.claude/settings.json`. Overrides personales: `.claude/settings.local.json` (gitignored).
