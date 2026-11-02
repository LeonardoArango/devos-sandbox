# Patrones del Personal Dev OS
Qué patrones nombrados usamos, por qué, dónde viven en el kit y qué **no** usamos. Contexto: proyectos personales, GitHub Issues, Claude Code, Specs en el repo, un solo dueño que interviene en la Spec y la aprobación; el resto lo hacen agentes orquestados por `./devos`.
Regla madre: **empezar con lo más simple y agregar complejidad solo cuando una eval o un incidente demuestren que hace falta** (Anthropic, *Building effective agents*).

## 1. Memoria
- **Patrón:** memoria en archivos versionados + *notas estructuradas* (`NOTES.md`) + consolidación en dos velocidades (retro automática → `memory/proyecto/` directo; cambios de conducta → propuesta → `./devos memoria` con el dueño) + escalera de refuerzo (explicación → checklist → plantilla → hook/test → política).
- **Por qué:** auditable con `git`, sin infraestructura, y nada entra a la memoria sin evidencia ni mi OK. La memoria escrita por el agente sin control es la forma más rápida de envenenar el sistema.
- **Dónde:** `memory/README.md`, `memory/propuestas/`, `.agents/skills/retro-aprendizaje/`, `NOTES.md` (gitignored), fechas `revisar:` en cada entrada.
- **No usamos:** autoescritura de memoria sin gate, ni "memory banks" gigantes que se cargan siempre.

## 2. Testing
- **Patrón:** *backpressure* determinista (Huntley): tests, lint, tipos y gitleaks antes de dar por terminado; TDD por CA (cada criterio de aceptación tiene método de verificación); **verificador independiente** en contexto limpio y sin escritura.
- **Por qué:** el agente no puede "decir" que terminó; el entorno lo confirma. El verificador separado evita que quien construye se autoapruebe.
- **Dónde:** `guardrails/hooks/stop-checks.sh`, `guardrails/hooks/post-edit-lint.sh`, `.agents/skills/verificar/`, sección 7 de `specs/_TEMPLATE.md`, checklist de `.github/pull_request_template.md`.
- **No usamos:** mutation testing ni E2E completos por defecto (solo si la Spec lo pide); tampoco "el LLM revisa el código" como único control.

## 3. Harness engineering
- **Patrón:** Claude Code como *agent harness* + capas: permisos `allow/ask/deny`, **sandbox** de Bash (archivos y red), **hooks** deterministas (PreToolUse/PostToolUse/Stop), presupuesto de tokens por fase y modelo por fase.
- **Por qué:** lo que debe cumplirse siempre va en código (hook/permiso), no en el prompt. El reel lo resume: stack seguro y observable, con reintentos, sandbox y límite de costo.
- **Dónde:** `.claude/settings.json`, `guardrails/hooks/*.sh`, `tokens.md` (parar y preguntar si una fase pasa 2× su presupuesto), `CLAUDE.md`.
- **No usamos:** harness propio con el Agent SDK, orquestadores externos ni contenedores por tarea. Claude Code ya trae esto.

## 4. Loop engineering
- **Patrón:** bucle agéntico **acotado** = plan → ejecutar → verificar con *ground truth* del entorno, con **condiciones de parada** explícitas: (a) checks en verde y CA con evidencia, (b) **máx. 3 reintentos** del Stop hook (después se detiene y me avisa), (c) 2× presupuesto de tokens, (d) `DEVOS_MAX_INTENTOS` por tarea y `DEVOS_MAX_TURNOS` por sesión en `./devos`; al agotarse, `BLOQUEO` y aviso en el Issue. *Una tarea por ciclo* (de Ralph, Huntley).
- **Por qué:** sin criterio de parada, el agente gira gastando tokens o "arregla" el test en vez del código. El reel: cómo repite, cómo mide su progreso y cuándo para.
- **Dónde:** `guardrails/hooks/stop-checks.sh` (contador `DEVOS_MAX_REINTENTOS`; Claude Code también corta a las 8 continuaciones seguidas), `tokens.md`, `tasks.md` (tareas ≤1 día) de `.agents/skills/plan/`.
- **No usamos:** el bucle Ralph sin límite (`while :; do … claude; done`). El propio autor no lo usaría en un código existente; solo lo probaría en un repo greenfield de juguete, en una rama y con límite de iteraciones.

## 5. Context engineering
- **Patrón:** contexto mínimo de alta señal: `AGENTS.md` corto (mapa + ≤15 gotchas) cargado al inicio; el resto **justo a tiempo** (glob/grep, skills con *progressive disclosure*); subagente Explore que devuelve ≤1.500 tokens; `/clear` entre fases y `/compact` en sesiones largas; notas en `NOTES.md` para no depender de la ventana.
- **Por qué:** más contexto no es mejor; la precisión cae a medida que crece (*context rot*). El reel: la información correcta en el momento correcto.
- **Dónde:** `AGENTS.md`, `CLAUDE.md`, `.agents/skills/*/SKILL.md` (frontmatter corto, detalle en archivos anexos), `research/` y `specs/` como contexto persistente.
- **No usamos:** RAG con embeddings sobre el repo, ni pegar documentación entera en el prompt.

## 6. Tool design
- **Patrón:** pocas herramientas sin solapamiento; **CLI antes que MCP** (`gh`, `git`, `jq`); herramientas que consolidan flujo (un script que hace el trabajo completo, no 5 llamadas); nombres claros y entradas estrictas; **errores accionables** (el hook dice qué falló y qué hacer); *poka-yoke* (rutas absolutas, `${CLAUDE_PROJECT_DIR}`); salidas cortas (`tail -30`).
- **Por qué:** cada herramienta extra consume contexto y abre superficie de ataque. El reel: nombres claros, esquemas estrictos, errores recuperables.
- **Dónde:** `guardrails/hooks/*.sh` (mensajes de error con la acción a tomar), `.agents/skills/escribir-spec-y-registrar/registro.md` (`gh` en vez de MCP), `mcp__github__*` en `ask` dentro de `.claude/settings.json`.
- **No usamos:** construir servidores MCP propios ni instalar MCPs "por si acaso". Uno nuevo solo si un flujo repetido lo pide y pasa por una eval.

## 7. Memory architecture
- **Patrón:** tipos de memoria de **CoALA**: trabajo (sesión, `NOTES.md`), episódica (recibos de PR, Issues, propuestas), semántica (`memory/base`, `proyecto`, `lecciones`) y procedimental (`AGENTS.md`, skills, hooks). Recuperación por **palabra clave** (grep/glob) y por estructura de carpetas. La procedimental es la más riesgosa de cambiar: solo en `./devos memoria` (hook la protege en cualquier otra sesión).
- **Por qué:** separar "qué pasó" de "qué es verdad" y de "cómo se hace" evita mezclar anécdotas con reglas. El reel: corto vs largo plazo, qué guardar y qué no (nada sensible), y escribir cuando el agente aprende o lo corrijo.
- **Dónde:** `memory/README.md` (sección "Tipos de memoria"), `.agents/skills/recibo/` (APRENDIZAJE), `.agents/skills/retro-aprendizaje/`.
- **No usamos:** base vectorial ni memoria semántica con embeddings (el reel la sugiere; para un solo dueño con decenas de archivos, grep basta). Reconsiderar solo si `memory/` pasa de ~200 archivos y grep deja de encontrar.

## 8. Orchestration patterns
- **Patrón:** *workflow* antes que agente libre. **Prompt chaining con orquestador determinista** (`./devos`: una sesión headless por fase y por tarea; el script, no el modelo, hace commit, push, PR y merge), **evaluator-optimizer** (construir ↔ verificador independiente) y **routing** de modelo por fase (Haiku, Sonnet u Opus). Subagentes solo para aislar contexto: Explore (leer) y verificador (romper).
- **Por qué:** el flujo es predecible y repetible; el humano decide al inicio (Spec + autonomía) y los checks deterministas + verificador independiente deciden después. El reel: dividir, entregar y combinar trabajo.
- **Dónde:** `README.md` (diagrama de fases y gates), `.agents/skills/*`, `CLAUDE.md` (subagentes), `tokens.md` (modelo por fase).
- **No usamos:** enjambres multi-agente, *agent teams* ni orquestador-trabajadores en paralelo por defecto: cuestan mucho más en tokens y son difíciles de depurar para una persona. Paralelizar solo investigación independiente.

## 9. Guardrails & permissions
- **Patrón:** **mínimo privilegio** + *defense in depth*: niveles de riesgo R0–R3, `deny` para lo irreversible (force-push, push a `main`, `rm -rf`, merge, leer `.env`), `ask` para lo externo, sandbox, hooks de secretos y paths protegidos. Contenido externo = dato (OWASP LLM01). **Evitar la tripleta letal** (datos privados + contenido no confiable + comunicación externa): cortar siempre una pata.
- **Por qué:** los filtros de prompt-injection no son confiables; lo confiable es que el agente no *pueda* hacer el daño. El reel: limitar herramientas y radio de impacto.
- **Dónde:** `guardrails/permisos.md`, `guardrails/prompt-injection.md` (incluye la tripleta), `guardrails/acciones-humanas.md`, `guardrails/hooks/block-secrets.sh`, `guardrails/hooks/protect-paths.sh`, `.claude/settings.json`.
- **No usamos:** `bypassPermissions` ni `--dangerously-skip-permissions` fuera de un contenedor desechable; tampoco productos de "guardrail" con IA como única defensa.

## 10. Evals for agents
- **Patrón:** *eval-driven development* chico: golden set de casos reales; graders **deterministas primero** (tests, checklist), luego **LLM-juez con rúbrica**, calibrado por mí leyendo transcripciones; **evaluar resultados, no el camino**; suites de **capacidad vs regresión**; **pass^k** (k=2) para medir consistencia; métrica norte: salidas aceptadas / (minutos de revisión + tokens).
- **Por qué:** sin evals, cada cambio a una skill es una apuesta. El reel: medir resultados, no outputs, y atrapar regresiones.
- **Dónde:** `evals/README.md`, `evals/golden/`, `evals/rubrica.md`, `evals/resultados.csv`.
- **No usamos:** plataformas de evals (Braintrust, LangSmith, etc.) ni benchmarks públicos: con 5–20 casos, un CSV y una rúbrica bastan. Empezar con 20–50 casos tomados de fallas reales cuando haya historial.

## 14. Autonomía (v0.3)
- **Patrón:** *spec-driven autonomy*: el humano fija intención, límites y preautorizaciones; un orquestador determinista (`./devos`) encadena sesiones headless cortas (`--permission-mode dontAsk`) con *backpressure* (checks fuera del modelo) y *evaluator-optimizer* (verificador independiente con veredicto en archivo). Merge por GitHub auto-merge con checks obligatorios; lo sensible no preautorizado espera al dueño.
- **Por qué:** quitar al humano de cada paso solo es seguro si las reglas viven en código (hooks, permisos, protección de rama) y si la aprobación es un acto que el agente no puede imitar (TTY o etiqueta del dueño validada por el workflow).
- **Dónde:** `devos`, `guardrails/hooks/*`, `extras/github-actions/devos.yml`, sección 9 de `specs/_TEMPLATE.md`.
- **No usamos:** `--dangerously-skip-permissions`, merge hecho por el modelo, ni auto-aplicar cambios a la memoria procedimental.

## Extra del reel
- **Human-in-the-loop:** humano solo en decisiones críticas o irreversibles, sin volverlo cuello de botella → 2 intervenciones (Spec y aprobar) + preautorizaciones declarativas en la sección 9 + escalamiento por `BLOQUEO.md`; ver `guardrails/acciones-humanas.md`.
- **Observabilidad:** registrar cada paso, latencia, costo y tokens → recibo de cambio por PR (`.agents/skills/recibo/`), `evals/resultados.csv` (tokens, minutos), transcripciones locales de Claude Code y `/cost`. **No** montamos OpenTelemetry ni dashboards hasta que haya más de un proyecto activo con agentes en paralelo.

## 11. Frontend: diseño UI y experiencia de usuario
- **Patrón:** dirección visual explícita antes de codificar (`DESIGN.md`, modo Persuadir/Operar/Leer/Exhibir, 5 líneas de dirección) → tokens (tipografía, espacio, color con contraste AA) → flujos y matriz de estados (`ux-flujos`) → crítica visual sobre capturas reales (`revision-ui`) con P0/P1/P2. Anti-"genérico de IA" y movimiento con propósito.
- **Por qué:** los agentes producen interfaces promedio si nadie fija dirección ni mira el resultado renderizado.
- **Dónde:** `.agents/skills/diseno-ui`, `ux-flujos`, `revision-ui`; Spec 6.1. Apoyo opcional y manual con skills vendorizadas: Emil Kowalski (animación), Impeccable (crítica y pulido visual), Taste (dirección de arte y medidas); nuestras skills dicen cuándo leer cada una.

## 12. Pruebas de usuario con Playwright (obligatorio en UI)
- **Patrón:** el gate es `@playwright/test` (determinista, CI, salida corta): CA y estados como tests, `getByRole`, escritorio + móvil, axe WCAG 2.2 AA en 0, capturas comparadas, trazas al fallar. El **MCP** de Playwright (versión fijada, headless, aislado, solo localhost, navegar/evaluar con permiso) solo para explorar; lo que encuentra se vuelve test. Alternativa con menos tokens: `@playwright/cli`.
- **Por qué:** "debería verse bien" no es evidencia; el hook Stop bloquea UI sin corrida verde (`DEVOS_E2E_CMD`).
- **Dónde:** `pruebas-usuario`, `guardrails/hooks/stop-checks.sh`, `.mcp.json`, `evals/golden/02` y `03`.
- **No usamos:** servicios de pruebas en la nube, grabadores de sesiones, `--allowed-origins` como frontera de seguridad.

## 13. SEO + AEO (obligatorio en páginas públicas)
- **Patrón:** SEO técnico limpio (HTML inicial con contenido, title/description/canonical únicos, robots + sitemap, JSON-LD que coincide con lo visible, CWV en presupuesto) + contenido citable (respuesta primero, entidades claras, autor y fechas, fuentes, experiencia propia) + pruebas Playwright (`e2e/seo.spec.ts`) dentro del mismo gate.
- **Hallazgos verificados (nov 2026):** Google dice que AEO/GEO "sigue siendo SEO": no hay archivos, marcado ni chunking especial para AI Overviews/AI Mode, y llms.txt no ayuda ni perjudica en Google (sí lo usan agentes y plataformas de docs). Bing/Copilot piden lo mismo y premian respuesta temprana, entidades claras y contenido verificable; IndexNow para avisar cambios. El resultado enriquecido FAQ se retiró en mayo 2026 (HowTo en 2023). Los bots de IA se controlan por separado: búsqueda (OAI-SearchBot, Claude-SearchBot, PerplexityBot) ≠ entrenamiento (GPTBot, ClaudeBot, Google-Extended); la decisión es mía por proyecto.
- **Dónde:** `.agents/skills/seo-aeo`, Spec 6.2, `evals/golden/04`.
- **No usamos:** herramientas "AEO/GEO" que prometen posiciones, texto para bots, páginas a escala por ciudad.

## Revisión de reels de skills
- Reel de 10 repos (DeJu_M5inR0) y reel de 5 skills (Dc1v9udvOou, Juana AI: taste-skill, Emil Kowalski, Playwright y otras de diseño): adoptamos las ideas útiles en nuestras palabras (`CREDITOS.md`). Rechazamos hooks de terceros, proxies, telemetría, instalaciones automáticas y copiar repos sin licencia. Reel DfF2-nfFfqe (Emil, Impeccable, Taste, Figma MCP): las tres skills se vendorizaron con la excepción de arriba; el MCP de Figma no se agregó.

## Excepción: skills de terceros vendorizadas (aprobada por Leonardo el 2026-11-01)
- **Regla general:** no instalamos skills, hooks ni plugins de terceros. **Excepción:** Emil Kowalski (MIT), Impeccable (Apache-2.0) y Taste (MIT), copiadas en `.agents/skills/vendor/`.
- **Mitigaciones:** commit fijado (sin `git pull`, sin `install.sh`, sin enlaces a `~/.claude`) · borrados el CLI de Impeccable (descarga de binario, API `impeccable.style`, telemetría, hooks, modo live) y `assets.mjs` de Taste (descargas de imágenes) · ningún hook de terceros · `DO_NOT_TRACK=1` e `IMPECCABLE_NO_TELEMETRY=1` en `settings.json` · `disable-model-invocation: true` y `allow_implicit_invocation: false` (no cargan solas) · `protect-paths.sh` y permisos bloquean editarlas · Playwright sigue siendo el gate · se tratan como texto de terceros (prompt injection).
- **Actualizar:** solo a mano, revisando el diff y repitiendo la limpieza de `VENDORED.md`, con mi OK.

## Fuentes (verificadas)
- Reel: Bhawna Sikriwal (@bhawna.io), "Agentic AI Concepts You Must Master By 2027" — https://www.instagram.com/reel/DdgmEKfh_QF/
- Anthropic, *Building effective agents* — https://www.anthropic.com/engineering/building-effective-agents
- Anthropic, *Effective context engineering for AI agents* — https://www.anthropic.com/engineering/effective-context-engineering-for-ai-agents
- Anthropic, *Writing effective tools for agents* — https://www.anthropic.com/engineering/writing-tools-for-agents
- Anthropic, *Demystifying evals for AI agents* — https://www.anthropic.com/engineering/demystifying-evals-for-ai-agents
- Claude Code, referencia de hooks — https://code.claude.com/docs/en/hooks
- Simon Willison, *The lethal trifecta* — https://simonwillison.net/2025/Jun/16/the-lethal-trifecta/
- Geoffrey Huntley, *Ralph Wiggum as a "software engineer"* — https://ghuntley.com/ralph/
- Sumers, Yao et al., *Cognitive Architectures for Language Agents (CoALA)* — https://arxiv.org/abs/2309.02427
- Yao et al., *τ-bench* (pass^k) — https://arxiv.org/abs/2406.12045
- Playwright, pruebas y accesibilidad — https://playwright.dev/docs/intro · https://playwright.dev/docs/accessibility-testing
- Playwright MCP — https://github.com/microsoft/playwright-mcp
- Google, optimizar para funciones de IA generativa — https://developers.google.com/search/docs/fundamentals/ai-optimization-guide
- Bing Webmaster Guidelines — https://www.bing.com/webmasters/help/webmasters-guidelines-30fba23a
- web.dev, Core Web Vitals — https://web.dev/articles/vitals
- Créditos y licencias de skills adaptadas — `CREDITOS.md`
