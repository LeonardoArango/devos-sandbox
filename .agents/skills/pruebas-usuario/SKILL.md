---
name: pruebas-usuario
description: Obligatorio en todo trabajo que toque UI (componentes, páginas, estilos, rutas, formularios). Úsalo al implementar o cambiar una pantalla y antes de verificar. Convierte CA y flujos de la Spec en pruebas E2E de Playwright (escritorio + móvil, estados, accesibilidad con axe, regresión visual) y guarda capturas y trazas como evidencia.
---
# Pruebas de usuario con Playwright (obligatorias en UI)
**Regla:** UI sin una corrida verde de Playwright de este turno = **no verificado**. El hook Stop lo bloquea (`DEVOS_E2E_CMD`, def. `npx --no-install playwright test`).
1. **Setup** (una vez por repo; si falta, pídemelo, no lo instales tú): ver [plantilla-e2e.md](plantilla-e2e.md) y `instalar.sh`. Servidor local vía `webServer`; solo `localhost`.
2. **Deriva tests de la Spec**: un `test()` por CA (nombre = `CA<n>: …`) y uno por flujo de `ux-flujos`: camino feliz + vacío + cargando + error + sin permiso. Simula red con `page.route()` hacia fixtures locales; nunca contra servicios reales.
3. **Selectores de usuario**: `getByRole`, `getByLabel`, `getByText`; `data-testid` solo si no hay otro. Nada de CSS frágil ni `waitForTimeout`: usa aserciones web-first (`await expect(...).toBeVisible()`).
4. **Proyectos**: escritorio (1280×800) y móvil (Pixel o iPhone emulado). WebKit/Firefox si la Spec lo pide.
5. **Accesibilidad**: `@axe-core/playwright` con etiquetas `wcag2a, wcag2aa, wcag21aa, wcag22aa` en cada pantalla y en cada estado; 0 violaciones o excepción anotada en la Spec. Más una prueba de teclado (Tab por el flujo principal).
6. **Datos extremos**: al menos un test con [datos-extremos.md](datos-extremos.md). **Medidas visuales** (`e2e/medidas.spec.ts` de la plantilla): h1 ≤2 líneas y en la primera pantalla, sin scroll horizontal, texto ≥12 px, cuerpo ≥15 px, ≤2 tipografías, sin imágenes rotas.
7. **Regresión visual**: `toHaveScreenshot()` por pantalla y ancho, con animaciones desactivadas y datos fijos. Bases nuevas o cambiadas (`--update-snapshots`) solo con mi OK y capturas antes/después en el PR.
8. **Corre** `DEVOS_E2E_CMD` y lee el resultado completo. Rojo → `depurar` (abre la traza: `npx playwright show-trace`). No relajes asserts para pasar.
9. **Evidencia**: `playwright-report/` + capturas en `specs/<id>/capturas/{antes,despues}/` + traza del fallo si lo hubo → enlázalas en el recibo (línea UI).
10. **Exploración** (opcional, tras los tests): Playwright MCP del proyecto para probar como usuario lo que los tests no cubren. Reglas: [exploracion-mcp.md](exploracion-mcp.md). Todo hallazgo se convierte en test.
