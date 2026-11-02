---
id: 001-resta-multiplicacion
idea: "Agregar funciones resta y multiplicación a src, que rechacen argumentos que no sean números"
fecha: 2026-11-01
estado: convertida (→ specs/001-resta-multiplicacion)
---
# Investigación: funciones resta y multiplicación con validación de tipo
## 1. Pregunta de investigación
¿Cómo agregar `resta(a, b)` y `multiplicacion(a, b)` en `src/` siguiendo el patrón de `suma`, de modo que lancen un error claro cuando algún argumento no sea un número, y qué cuenta exactamente como "número" (NaN, Infinity, BigInt, strings numéricos)?

## 2. Evidencia interna (repo, Issues, analítica, notas)
| Fuente | Hallazgo | Link |
|---|---|---|
| `src/suma.js` | Única función: `export function suma(a, b) { return a + b; }`, sin validación; ESM, export nombrado, un archivo por función | `src/suma.js:1` |
| `test/suma.test.js` | Patrón de test: `node:test` + `node:assert/strict`, un test | `test/suma.test.js:1-4` |
| `package.json` | `"type": "module"`; `test` = `node --test`; `lint` = `node --check src/suma.js` (**solo revisa suma.js**); sin dependencias | `package.json` |
| Runtime | Node v26.8.2 local; `package.json` no fija `engines` | `node --version` |
| `specs/`, `research/` | Solo plantillas; esta es la primera idea → id `001` | — |
| GitHub Issues | `[PENDIENTE]`: `gh` no conecta desde el sandbox (fallo TLS); no se pudo buscar duplicados | — |
| `memory/proyecto/` | Solo plantilla, sin decisiones previas | — |

## 3. Evidencia externa
Vía subagente `investigador-web` (docs de Node v20; el repo corre Node v26, y estas APIs son estables).
| Fuente | Hallazgo | URL | ¿Confiable? |
|---|---|---|---|
| MDN typeof | `typeof NaN`, `typeof Infinity` → "number"; `typeof new Number(1)` → "object"; `typeof 42n` → "bigint"; `"3"` → "string" | https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/typeof | sí |
| MDN Number.isFinite | No convierte: true solo para valores number finitos; false para NaN, ±Infinity, `"0"`, `null` | https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/isFinite | sí |
| MDN Number.isNaN | No convierte: true solo para el valor number NaN | https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Number/isNaN | sí |
| MDN TypeError | Se lanza cuando un argumento es incompatible con el tipo esperado | https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/TypeError | sí |
| MDN RangeError | Se lanza cuando el valor queda fuera del rango permitido | https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/RangeError | sí |
| Node errors | TypeError = tipo no permitido; RangeError = valor fuera del conjunto aceptable | https://nodejs.org/docs/latest-v20.x/api/errors.html | sí |
| MDN BigInt | Mezclar BigInt con Number en aritmética lanza TypeError (ejemplo con `-`) | https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/BigInt | sí |
| Node assert | `assert.throws(fn, { name: 'TypeError', message: /…/ })` o con la clase; evitar un string como 2.º argumento (`ERR_AMBIGUOUS_ARGUMENT`) | https://nodejs.org/docs/latest-v20.x/api/assert.html | sí |
`[SUPUESTO]`: `Number.isFinite(1n)` y `Number.isFinite(new Number(3))` dan false (se deduce de "non-numbers always false"; no aparece literal). `-0` pasa ambas comprobaciones.

## 4. Estado actual del proyecto
Sandbox mínimo: una función `suma` sin validación, un test, sin build ni dependencias. Agregar las funciones no toca nada más, salvo quizás el script `lint`.

## 5. Opciones
| Opción | Pros | Contras | Esfuerzo |
|---|---|---|---|
| A. `typeof x === 'number'` → TypeError | Literal a "no es número"; mínima | Deja pasar NaN e Infinity (`resta(NaN, 1)` → NaN silencioso) | XS |
| B. `Number.isFinite(x)` → TypeError | Una sola comprobación; rechaza NaN, ±Infinity, strings, BigInt, `new Number`, null | Rechaza Infinity aunque sea un valor JS válido; mensaje único para casos distintos | XS |
| C. `typeof` → TypeError + `Number.isFinite` → RangeError | Semántica de error exacta según MDN/Node | Dos ramas y más tests para un sandbox | S |

Archivos: `src/resta.js` y `src/multiplicacion.js` (un archivo por función, como `suma.js`) con tests en `test/` [Propuesta IA].

### Blindspot pass
- `npm run lint` solo hace `node --check src/suma.js`: los archivos nuevos no se lintean salvo que se amplíe el script.
- `suma` no valida: tras esto habrá una API inconsistente. ¿Se deja igual (qué NO debe cambiar) o se valida también?
- La validación compartida tienta a crear un helper (`src/validar.js`); con 2 funciones sería YAGNI frente a 2 líneas duplicadas.
- `-0`: `multiplicacion(-1, 0)` → `-0`; `assert.equal(-0, 0)` en modo strict usa `Object.is` y falla. Solo importa si un test lo compara.
- Issues duplicados: no verificados (gh sin red desde el sandbox).

## 6. Decisiones del challenge
Camino propuesto: **lite**.
1. Validación: `typeof x !== 'number'` → `TypeError` (opción A). Se aceptan NaN, ±Infinity y -0; se rechazan string (incluido "3"), BigInt, null, undefined, boolean, objetos y `new Number(3)`. · respuesta (dueño)
2. `suma` y `test/suma.test.js` no cambian. · respuesta
3. Lint ampliado a los archivos nuevos. · respuesta
4. `resta(a, b)` y `multiplicacion(a, b)`, export nombrado, en `src/resta.js` y `src/multiplicacion.js`; tests en `test/resta.test.js` y `test/multiplicacion.test.js`. · respuesta
5. Mensaje: `"<funcion>: el argumento '<a|b>' debe ser un número (recibido: <typeof>)"`. · respuesta
6. Usuario: el dueño (sandbox). Sin datos, persistencia, auth, red ni dependencias. Éxito = `npm test` y `npm run lint` en verde con los CA cubiertos. Métricas de negocio: N/A. · respuesta
7. Lint: `node --check src/suma.js && node --check src/resta.js && node --check src/multiplicacion.js`. Verificado: `node --check a.js b.js` solo revisa `a.js` (exit 0 con `b.js` roto, Node v26.8.2). · respuesta (recomendación aceptada)
8. Orden: se valida `a` y luego `b`; se lanza el primer error. · respuesta (recomendación aceptada)
9. Argumentos de más: se ignoran, como en `suma`. · respuesta (recomendación aceptada)
10. Los CA fijan resultados borde con `Object.is` / `Number.isNaN`: `multiplicacion(-1, 0)` → `-0`; `resta(Infinity, Infinity)` → `NaN`. · hallazgo del esceptico, corregido
Duda: 1 ciclo del `esceptico`. 4 hallazgos: lint (alto, corregido en 7), orden (medio, 8), aridad (bajo, 9) y valores borde en tests (bajo, 10). `null` se reporta como "recibido: object", consistente con la decisión 1 (descartado como hueco).
Abogado del diablo: es aritmética nativa; `a - b` ya funciona, y con la opción A la validación solo evita la coerción silenciosa (`'5' * '2'` → 10). Valor real: ejercitar el Dev OS de punta a punta. Se construye.

## 7. Recomendación (Gate A = respondí el challenge)
Seguir, camino lite. Gate A: el dueño respondió todas las rondas, 2026-11-01.
