# Tokens con presupuesto personal
Meta: más funcionalidades aceptadas por menos minutos de mi revisión y menos consumo del plan.

## 1. Contexto mínimo
- `AGENTS.md` ≤ 60 líneas: se carga en **cada** sesión. Usa `/context` para ver qué ocupa espacio.
- Skills: solo nombre + descripción viven en contexto; el cuerpo carga al usarse. Mantén cada `SKILL.md` < 30 líneas.
- Skills vendorizadas (Emil, Impeccable, Taste): **0 tokens fijos** (`disable-model-invocation: true`, sin descripción en contexto). Al leerlas: `taste` ≈9k · `emil-design-eng` ≈5k · `emil-animate` ≈2,5k · `emil-review-animations` ≈1,6k (+ STANDARDS ≈1,9k) · `impeccable` ≈2,3k + la referencia del comando (`critique` ≈10k, `audit` ≈1,8k, `polish` ≈1,3k). Nuestros punteros en `diseno-ui`/`revision-ui` suman ≈150. Lee una por tarea y solo cuando aplique; nunca todas "por si acaso".
- Al codificar, pasa la tarea de `tasks.md` y las secciones relevantes de la Spec, no el research entero.
- Scripts deterministas se **ejecutan**, no se leen.
- Desactiva MCP que la fase no use (`/mcp`); cada esquema ocupa contexto. Prefiere `gh` a GitHub MCP.

## 2. Sesiones (el orquestador ya lo hace por ti)
- `./devos run` abre **una sesión headless nueva por fase y por tarea**: contexto limpio, solo la tarea y las secciones de la Spec que cita. Es el mayor ahorro del sistema.
- Tope por sesión: `DEVOS_MAX_TURNOS` (80). Reintentos por tarea: `DEVOS_MAX_INTENTOS` (3); después se detiene y te avisa en vez de quemar tokens.
- Los checks deterministas (tests, lint, Playwright) corren **fuera** del modelo antes de gastar un verificador; si fallan, el feedback va directo al siguiente intento.
- Fases sin código (verificar, retro, recibo) no vuelven a correr el hook Stop (`DEVOS_SALTAR_STOP=1`).
- Cada sesión registra turnos y costo en `specs/<id>/uso.csv`; `./devos estado` suma por Spec.
- Interactivo (`nuevo`, `memoria`): `/clear` entre fases, `/compact <foco>`, `/rewind` en vez de corregir en el hilo.

## 3. Subagentes
- Solo para aislar contexto: `explorador` (Haiku, ≤1.500 tokens), `investigador-web` (resumen citado), `esceptico` y `verificador` (contexto limpio, sin edición). Para lo demás, un solo agente.
- Workflows dinámicos ("use a workflow") solo para Specs enormes en paralelo (migraciones, auditorías): cuestan mucho más.

## 4. Modelo por fase (`.devos.env`)
| Fase | Variable | Por defecto | Presupuesto orientativo* |
|---|---|---|---|
| Investigación + challenge + Spec (contigo) | — (tu sesión) | Opus | 80–110k |
| Plan + revisión del esceptico | `DEVOS_MODELO_PLAN` | opus | 60k |
| Construcción (por tarea) | `DEVOS_MODELO_BUILD` | sonnet | 60–100k |
| Verificación (por tarea) | `DEVOS_MODELO_VERIF` | opus | 30–40k |
| Retro + recibo | `DEVOS_MODELO_RETRO` | sonnet | 30k |
\*Calibrar con `uso.csv`. Si una Spec cuesta 2× lo esperado, la retro debe explicar si faltó contexto (Spec) o sobró esfuerzo (tareas grandes). Para tareas muy difíciles, sube solo `DEVOS_MODELO_BUILD` (p. ej. `claude-fable-5-1`), no todo.

## 5. Respuestas cortas, trabajo completo
- Regla: respuestas breves (resultado, evidencia, siguiente paso); **el ahorro nunca recorta** código, tests, validaciones, seguridad ni accesibilidad.
- Opcional: `/output-style conciso` (`.claude/output-styles/conciso.md`, conserva las instrucciones de código).
- UI: el gate es `npx playwright test` (salida resumida); el MCP de Playwright solo para explorar, con `--image-responses omit` y snapshots de accesibilidad en vez de capturas. Alternativa más barata en tokens: `@playwright/cli` + su skill.
- SEO: las pruebas viven en `e2e/seo.spec.ts` y se **ejecutan**; la checklist de `seo-aeo` se carga solo en páginas públicas.

## 6. Hábitos que más ahorran (equipo de Claude Code, 2026)
- `/rewind` en vez de corregir: el intento fallido no queda ocupando contexto.
- Brief completo en el primer turno (objetivo, restricciones, CA): delegar cuesta menos que guiar.
- Con contexto de 1M: `CLAUDE_CODE_AUTO_COMPACT_WINDOW=400000` para compactar antes de la degradación.
- `/usage` muestra qué skills, MCP o plugins consumen más.

## 7. Anti-patrones
Pegar documentos completos "por si acaso" · reglas en MAYÚSCULAS repetidas · "revisa dos veces" en vez de un verificador · sesiones de días · usar Opus para editar archivos triviales.
