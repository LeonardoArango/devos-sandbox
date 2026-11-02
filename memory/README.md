# Memoria
Archivos Markdown versionados en Git (legibles, buscables con grep). Sin bases vectoriales al inicio.

## Niveles
| Carpeta | Contenido | Agente | Cambia por |
|---|---|---|---|
| `memory/base/` | mis principios y preferencias globales (copiar igual en todos mis repos) | **solo lectura** (deny + hook) | PR mío (nunca un agente) |
| `AGENTS.md`, `CLAUDE.md`, `.agents/skills/`, `.claude/agents/` | mapa, gotchas, procesos, roles | solo lectura (hook) | `./devos memoria` con el dueño |
| `memory/proyecto/<repo>.md` | decisiones (ADR corto), estado, convenciones | **escribe solo** en la retro de cada Spec | va en el PR de la Spec |
| `memory/lecciones/` | lecciones aprobadas, una por archivo | solo lectura | Gate F |
| `memory/propuestas/` | propuestas con evidencia | **escribe** | — (entrada al proceso) |
| `NOTES.md` (gitignored) | progreso de la tarea en curso | escribe | se descarta al cerrar |

## Aprendizaje
1. **Durante la tarea:** notas en `NOTES.md` y campo APRENDIZAJE del recibo.
2. **Al cerrar una Spec (automático en `./devos run`):** `retro-aprendizaje` actualiza `memory/proyecto/` y deja propuestas.
3. **Revisión mensual** (1 sesión, o tras ~5 PR): el subagente `aprendiz` revisa recibos, PR rechazados y fallas; agrupa patrones; propone agregar **y borrar**.
4. **`./devos memoria`** (cada 2–4 semanas, ~15 min): acepto/rechazo cada propuesta; se aplica, se corre la regresión de evals y se anota en `CHANGELOG.md`.
5. **Escalera:** si una lección escrita se repite, súbela: checklist → plantilla → hook/test → política.

## Trazabilidad
- Todo cambio por PR, con link a la sesión/PR de origen. Rollback = revert.
- Una propuesta = un archivo nuevo (sin ediciones paralelas).
- Cada gotcha/lección lleva `revisar: <fecha>`; la revisión mensual propone borrar lo vencido. Revisión completa con cada modelo nuevo.

## Tipos de memoria (CoALA)
- **Trabajo** (sesión): contexto + `NOTES.md`. Se descarta.
- **Episódica** (qué pasó): recibos de PR, Issues cerrados, `memory/propuestas/`. Se consulta, no se carga siempre.
- **Semántica** (qué es verdad): `memory/base/`, `memory/proyecto/`, `memory/lecciones/`.
- **Procedimental** (cómo se hace): `AGENTS.md`, skills, hooks, permisos. La más riesgosa de cambiar: solo por Gate F.
