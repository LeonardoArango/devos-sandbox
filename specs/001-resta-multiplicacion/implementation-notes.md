# Implementation notes — 001-resta-multiplicacion

## Desviaciones
- T3: el sandbox deniega comandos compuestos (`npm run lint 2>&1; echo "exit=$?"`, `git fetch`). Ejecuté `npm run lint` simple y tomé el código de salida del resultado de la herramienta (`Exit code 1` o sin error). Anotado en `verificacion/T3-ca8.md`.
- T3: no se hizo `git fetch origin main` (sin permiso); CA9 se comparó contra el `origin/main` local ya existente. El diff de `src/suma.js` y `test/suma.test.js` salió vacío.
