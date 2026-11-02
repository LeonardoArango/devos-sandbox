---
id: NNN-slug              # carpeta specs/<id>/ y rama feat/<id>
titulo: "<nombre>"
camino: lite | completo
estado: borrador          # borrador | aprobada | cerrada · "aprobada" SOLO vía ./devos aprobar o etiqueta `aprobada` del dueño
version: 0.1
issue: <URL del GitHub Issue>   # lo escribe devos-issue.sh publicar
research: research/<id>.md      # opcional en lite
preautoriza: []           # qué pueden hacer los agentes sin mí: dependencias, migraciones, auth, infra, deploy (ver sección 9)
aprobado: ""              # lo escribe ./devos aprobar: fecha · quién · vía
---
# <Título>
Marcadores: `[SUPUESTO]` `[PENDIENTE]` `[Propuesta IA]`. Nunca inventar datos. Un `[PENDIENTE]` que bloquee un P0 impide aprobar.
Lite = secciones 1, 4, 7 y 9.

## 1. Problema y contexto
Qué me duele (o al usuario), cuánto y cómo lo sé.

## 2. Objetivo y métricas
| Métrica | Línea base (fuente) | Meta | Cómo se mide |
|---|---|---|---|

## 3. Usuarios y camino feliz
- Usuarios:
- Camino feliz (3–8 pasos):

## 4. Alcance, fuera de alcance y qué NO debe cambiar
- Dentro:
- Fuera:
- **No debe cambiar** (contratos, comportamiento, datos existentes):

## 5. Requisitos funcionales — EARS
| ID | "CUANDO <evento> EL SISTEMA DEBE <comportamiento>" | P0/P1/P2 |
|---|---|---|

## 6. Requisitos no funcionales
Rendimiento · Plataformas/navegadores · Seguridad (OWASP) · Accesibilidad · Observabilidad · Costo mensual.
- [ ] (Opcional) Datos personales: minimización, consentimiento, borrado; Ley 1581/2012 si hay usuarios en Colombia.
### 6.1 Interfaz (si hay UI) — `ux-flujos`, `diseno-ui`
- Trabajo principal por pantalla · Recorrido · Matriz de estados (vacío/cargando/error/éxito/sin permiso) con microcopy · Anchos 360/768/1280 · Teclado y lector · `DESIGN.md`
- **Pruebas de usuario (obligatorio):** cada CA y estado tiene test Playwright (`e2e/<id>.spec.ts`), axe sin violaciones WCAG 2.2 AA, capturas por ancho. Comando: `DEVOS_E2E_CMD=<…>`
### 6.2 SEO / AEO (si hay páginas públicas) — `seo-aeo`
| Página pública | Intención / pregunta que responde | Title | H1 | JSON-LD | Idiomas |
|---|---|---|---|---|---|
- Privadas (`noindex` o login): `<rutas>` · Renderizado: SSR/SSG/prerender `<cuál>`
- Política bots IA (bots-ia.md): buscadores `<permitir>` · entrenamiento (GPTBot, ClaudeBot, Google-Extended) `<permitir/bloquear>` · llms.txt `<sí/no y por qué>`
- Presupuesto CWV: LCP ≤2,5 s · INP ≤200 ms · CLS ≤0,1 · Lighthouse SEO local ≥`<90 | N/A>`
- Entidades (nombre exacto de empresa/productos/personas) y autor visible: `<…>`

## 7. Criterios de aceptación con evidencia
| CA | Dado / Cuando / Entonces | RF | Cómo se verifica | Evidencia (link) |
|---|---|---|---|---|
Cada CA responde sí/no. Los P0 con verificación automática salvo justificación.

## 8. Contexto técnico (mapa, no manual)
- Módulos afectados · Contratos de datos/API · Gotchas (`AGENTS.md`)

## 9. Autonomía y preautorizaciones
Tras `./devos aprobar`, los agentes planean, construyen, verifican, abren PR y lo fusionan **solos**. Aquí decides qué más pueden hacer sin ti. Lo que no esté preautorizado detiene el PR para tu revisión (etiqueta `revisar-humano`).
| Categoría | ¿Preautorizada? | Límite / condición |
|---|---|---|
| dependencias (nuevas o actualizadas) | no | <p. ej. solo MIT/Apache, mantenidas> |
| migraciones (esquema) | no | <p. ej. solo aditivas, reversibles> |
| auth / permisos | no | |
| infra (Docker, IaC) | no | |
| deploy (lo hace el CI al fusionar en main) | no | <entorno> |
Siempre humano (no preautorizable): datos reales/personales en pruebas, envíos reales (correo, SMS, webhooks), gastar dinero, borrar datos, CI/CD, secretos. La lista que manda es `preautoriza:` del frontmatter.

## 10. Riesgos y preguntas abiertas
| Tipo | Descripción | Impacto | Estado |
|---|---|---|---|
Una pregunta abierta que bloquee un P0 detiene el desarrollo.

## 11. Rebanadas
| Rebanada | Valor | CA | Issue/tarea |
|---|---|---|---|

## 12. Lista para desarrollo
- [ ] Problema con fuente · [ ] CA verificables · [ ] Qué no cambia definido · [ ] Seguridad/datos revisados
- [ ] UI → 6.1 completa · Público → 6.2 completa · [ ] Sin preguntas P0 abiertas · [ ] Issue creado y enlazado · [ ] Sección 9 decidida (autonomía)

## 13. Cierre (post-release)
| Métrica | Meta | Real | Fuente |
|---|---|---|---|
- Qué malinterpretó el agente / qué faltó en la Spec:
- Propuestas → `memory/propuestas/`:
