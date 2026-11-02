## Recibo de cambio
- **OBJETIVO:** <tarea / CA> — Spec `specs/<id>/spec.md` v<x> — Closes #<n>
- **CAMINO:** lite | completo
- **CAMBIADO:**
- **VERIFICADO:** <CA → evidencia>
- **UI (si aplica):** capturas antes/después (360 / 768 / 1280) + checklist `revision-ui`
- **PLAYWRIGHT (UI):** `DEVOS_E2E_CMD` verde este turno: <n> tests · axe 0 violaciones · `playwright-report/` · trazas de fallos corregidos
- **SEO/AEO (público):** `e2e/seo.spec.ts` verde · Lighthouse SEO <n>/umbral o N/A · robots/política bots IA · sitemap
- **NO VERIFICADO:**
- **DECISIONES:**
- **OMITIDO A PROPÓSITO:** <qué y riesgo, o "nada">
- **RIESGOS:**
- **REQUIERE APROBACIÓN:** <migración / deploy / dependencia nueva / ninguno>
- **APRENDIZAJE:** <para memoria, o "nada">

### Checklist
- [ ] Tests, lint y build en verde · [ ] gitleaks limpio · [ ] Verificador independiente corrido
- [ ] Nada de "qué no debe cambiar" se rompió · [ ] Sin datos personales en logs/fixtures
- [ ] UI: Playwright verde, estados (vacío/cargando/error/éxito), teclado, axe AA y capturas adjuntas (o N/A)
- [ ] Público: title/description únicos, canonical, JSON-LD válido, robots.txt + sitemap, un h1, CWV en presupuesto (o N/A)
