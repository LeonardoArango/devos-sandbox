---
name: revision-ui
description: Úsalo después de construir o cambiar UI y antes de verificar o abrir el PR, o cuando pida revisar, criticar o pulir una interfaz. Revisa capturas reales con heurísticas, WCAG 2.2 AA, responsive y rendimiento, y entrega hallazgos priorizados.
---
# Revisión de UI
1. **Requisito**: corrida verde de `pruebas-usuario` (Playwright) con capturas en 360, 768 y 1280/1440. Sin capturas no hay revisión: es "no verificado".
2. **Crítica visual sobre capturas**, no sobre código ([critica-visual.md](critica-visual.md)): prueba de 1 s/5 s, entrecerrar ojos, tapar el logo, contar bordes de alineación, márgenes y huecos.
3. **Checklist** [checklist.md](checklist.md): heurísticas de Nielsen, WCAG 2.2 AA, responsive, estados, rendimiento. Lo automatizable sale de axe y Playwright; lo demás, a ojo sobre capturas y con teclado.
4. **Anti-genérico**: `diseno-ui/anti-slop.md`. Si hay `DESIGN.md`, cualquier desvío es hallazgo.
5. Datos extremos (nombres largos, 0 y 1 elementos, textos traducidos): `pruebas-usuario/datos-extremos.md`.
6. **Salida**: tabla priorizada **P0** (bloquea: accesibilidad, flujo roto, pérdida de datos) · **P1** (confunde o se ve roto) · **P2** (pulido), con captura, regla y arreglo propuesto. Cambios de CSS/animación en tabla Antes | Después | Por qué.
7. Arregla P0 y P1 en lote, vuelve a correr Playwright y adjunta capturas antes/después al recibo. P2 se lista; los arreglo si lo pido.
8. **Skills vendorizadas** (solo si aplica, una a la vez): crítica/pulido visual profundo → `impeccable` (`critique`, `audit`, `polish`, `typeset`…; sin CLI, ver su nota); animaciones existentes → `emil-review-animations`; romper la UI con datos extremos → `emil-break-ui`; landing con look genérico → inspector local de `taste` (`node .agents/skills/taste/scripts/inspect.mjs <url>`) como apoyo a Playwright.
Opcional local (sin red en tiempo de prueba): Lighthouse para rendimiento si ya está instalado (`npx --no-install lighthouse http://localhost:<puerto>`); nunca lo instales sin mi OK.
