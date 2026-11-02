# T3 · CA8 — evidencia del constructor
(No es el veredicto de `verificar`. Nota: el sandbox deniega `cmd; echo "exit=$?"`, así que el código de salida se toma del resultado de la herramienta: "Exit code 1" = falla; sin error = 0.)

Lint: `node --check src/suma.js && node --check src/resta.js && node --check src/multiplicacion.js`

## Rojo previo (lint antiguo, solo `suma.js`, con `export function (` añadido a `src/resta.js`)
```
npm notice run node --check src/suma.js
```
exit=0 → el lint no veía `resta.js` (CA8 fallaba, como se esperaba).

## 1. Estado limpio
```
npm notice run node --check src/suma.js && node --check src/resta.js && node --check src/multiplicacion.js
```
exit=0

## 2. `export function (` al final de `src/resta.js`
```
/Users/leonardoarango/devos-sandbox/src/resta.js:6
export function (
       ^^^^^^^^

SyntaxError: Function statements require a function name
    at checkSyntax (node:internal/main/check_syntax:84:5)
Node.js v26.8.2
```
exit=1 (revertido)

## 3. `export function (` al final de `src/multiplicacion.js`
```
/Users/leonardoarango/devos-sandbox/src/multiplicacion.js:6
export function (
       ^^^^^^^^

SyntaxError: Function statements require a function name
    at checkSyntax (node:internal/main/check_syntax:84:5)
Node.js v26.8.2
```
exit=1 (revertido)

## 4. Estado limpio tras revertir
- `npm run lint` → exit=0
- `git diff --stat -- src/` → vacío (sin cambios respecto a lo construido en T1/T2).

## CA9 + restricciones
- `git diff origin/main -- src/suma.js test/suma.test.js` → vacío (ref `origin/main` local, sin `git fetch`).
- `package.json`: `test` sigue `node --test` y `"type": "module"` intacto (verificado leyendo el archivo).
- `npm test` → 40 pass, 0 fail, incluye `✔ suma dos números`.
