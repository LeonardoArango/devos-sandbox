# Memoria de proyecto: devos-sandbox
## Estado actual (≤10 líneas)
- Módulos ESM en `src/`: `suma`, `resta`, `multiplicacion`. Tests en `test/` con `node --test` (40 pasan tras la Spec 001).
- `resta` y `multiplicacion` validan con `typeof` (sin coerción; `new Number(3)`, bigint, null, etc. lanzan TypeError). Validan `a` antes que `b`, ignoran argumentos de más y aceptan NaN/Infinity.
- Formato del error: `<fn>: el argumento '<a|b>' debe ser un número (recibido: <typeof>)`.

## Decisiones (ADR corto: fecha · decisión · por qué · alternativa)
- 2026-11-01 · `npm run lint` enumera cada módulo a mano: `node --check a && node --check b && ...` · `node --check` solo revisa el primer archivo que recibe · alternativa: glob o ESLint (descartado por YAGNI y por no añadir dependencias). Un módulo nuevo en `src/` debe añadirse al script `lint` en `package.json`.
- 2026-11-01 · `suma` queda intacta como referencia de regresión (CA9) · la Spec 001 no debía tocar `src/suma.js` ni `test/suma.test.js`.

## Convenciones que no son obvias
- Para evidencia de verificación que se commitea, usa rutas relativas (el verificador detectó rutas `/Users/...` en `T3-ca8.md`).

## Comandos útiles
- `npm test` · `npm run lint`.
- En el sandbox autónomo no se permiten comandos compuestos (`cmd; echo $?`) ni `git fetch`: ejecuta comandos simples y lee el código de salida del resultado de la herramienta. Compara contra `origin/main` local.
