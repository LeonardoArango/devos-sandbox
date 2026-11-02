# Plan técnico — 001-resta-multiplicacion
- Spec: specs/001-resta-multiplicacion/spec.md (v0.1, aprobada) · Issue: #1 · Revisado por `esceptico`: 2026-11-01
- **Objetivo:** añadir `resta(a, b)` y `multiplicacion(a, b)` con validación `typeof === 'number'` y ampliar `npm run lint` para cubrir los tres módulos de `src/`.
- **Arquitectura:** un módulo ESM por función en `src/` con export nombrado (igual que `src/suma.js`), un archivo de test por módulo en `test/` con `node:test` + `node:assert/strict`. Sin helper compartido: cada módulo valida por su cuenta (Spec §4, fuera de alcance).
- **Stack y versiones:** Node v26.8.2 local; CI usa Node 22 (`.github/workflows/ci.yml`, no se toca). Sin dependencias. `package.json` con `"type": "module"`.

## Restricciones globales (copiadas literal de la Spec)
La Spec lite no tiene una sección "Restricciones globales"; se copian literal las restricciones de §4 y §9:
- Fuera:
  - Validar `suma`.
  - Rechazar NaN o ±Infinity.
  - Validar la cantidad de argumentos.
  - Soporte para BigInt.
  - Un helper de validación compartido (YAGNI con 2 funciones).
  - Dependencias nuevas.
- **No debe cambiar:** el comportamiento ni el test de `suma`, el script `test` (`node --test`) y `"type": "module"`.
- Editar el script `lint` de `package.json` está dentro del alcance (§4); no es una dependencia. Siempre humano (no preautorizable): datos reales/personales en pruebas, envíos reales, gastar dinero, borrar datos, CI/CD, secretos. Decidido con el dueño el 2026-11-01: `preautoriza: []`.

## Enfoque
1. Decisión que más podría cambiar: el **contrato de error** (RF3–RF5). Se fija primero con tests de mensaje exacto.
2. Cada función: validar `a`, luego `b` (orden fijo ⇒ RF5), lanzar `new TypeError(...)` con el mensaje de RF4; si ambos son number, devolver `a - b` / `a * b` sin más lógica (RF7 se cumple solo: NaN/Infinity/-0 son number).
3. Firma con dos parámetros nombrados; los argumentos extra se ignoran de forma natural (RF6).
4. Lint: encadenar un `node --check` por archivo con `&&`, porque `node --check a b` solo revisa el primero (Spec CA8).
5. TDD por tarea: test rojo → código mínimo → verde.

## Mapa de archivos
| Archivo | Crea/Modifica | Responsabilidad |
|---|---|---|
| `src/resta.js` | Crea | `export function resta(a, b)` con validación y `a - b` |
| `test/resta.test.js` | Crea | CA1, CA3 (resta), CA4 (resta), CA5, CA6, CA7 (resta) |
| `src/multiplicacion.js` | Crea | `export function multiplicacion(a, b)` con validación y `a * b` |
| `test/multiplicacion.test.js` | Crea | CA2, CA3 (multiplicacion), CA4 (multiplicacion), CA7 (multiplicacion) |
| `package.json` | Modifica solo `scripts.lint` | Revisar sintaxis de los 3 módulos |
| `specs/001-resta-multiplicacion/verificacion/T3-ca8.md` | Crea (T3) | Evidencia manual de CA8 (salida + exit). `verificacion/T<n>.md` queda reservado al veredicto de `verificar` |
| `src/suma.js`, `test/suma.test.js` | **No se tocan** | — |

## Contratos (API, eventos, esquemas): antes / después, con firmas
Antes: solo `export function suma(a, b)` en `src/suma.js`.
Después (se añade, `suma` idéntico):
```js
// src/resta.js
export function resta(a, b) {
  if (typeof a !== 'number') throw new TypeError(`resta: el argumento 'a' debe ser un número (recibido: ${typeof a})`);
  if (typeof b !== 'number') throw new TypeError(`resta: el argumento 'b' debe ser un número (recibido: ${typeof b})`);
  return a - b;
}
// src/multiplicacion.js — idéntico con el prefijo `multiplicacion:` y `return a * b;`
```
Mensaje (RF4): `"<funcion>: el argumento '<a|b>' debe ser un número (recibido: <typeof del valor>)"`. Ej.: `null` → `object`, `new Number(3)` → `object`, `1n` → `bigint`, `undefined` → `undefined`.

`package.json` › `scripts.lint`:
- Antes: `"node --check src/suma.js"`
- Después: `"node --check src/suma.js && node --check src/resta.js && node --check src/multiplicacion.js"`

## Datos y migraciones (requieren mi aprobación)
No aplica.

## Qué NO cambia y cómo lo protejo (tests de regresión, paths protegidos)
- `src/suma.js` y `test/suma.test.js`: no aparecen en el diff (`git diff --stat origin/main -- src/suma.js test/suma.test.js` vacío) y `npm test` sigue ejecutando `suma dos números` en verde (CA9).
- `scripts.test` sigue siendo `"node --test"` y `"type": "module"` sigue presente: comprobación en T3 con `node -e` sobre `package.json`.
- `.github/workflows/ci.yml` no se toca (CI/CD es siempre humano).

## Verificación por CA
| CA | Tipo | Dónde |
|---|---|---|
| CA1 | unit | `test/resta.test.js` — `resta(5,3)===2`, `resta(0.3,0.1)` igual a `0.3 - 0.1` |
| CA2 | unit | `test/multiplicacion.test.js` — `multiplicacion(4,2.5)===10`, `Object.is(multiplicacion(-1,0), -0)` |
| CA3 | unit | ambos tests — 7 valores × posición `a` y `b`, `assert.throws(..., { name: 'TypeError', message: <mensaje RF4 exacto con typeof v> })` (el mensaje evita falsos verdes: `1 - 1n` ya lanza TypeError nativo) |
| CA4 | unit | `resta('x',1)` y `multiplicacion(2,null)` con mensaje completo exacto |
| CA5 | unit | `test/resta.test.js` — `resta('x', null)` mensaje con `'a'` (mensaje completo exacto) |
| CA6 | unit | `test/resta.test.js` — `resta(1,2,3) === -1` |
| CA7 | unit | `Number.isNaN(resta(Infinity, Infinity))`, `Number.isNaN(multiplicacion(NaN, 2))` |
| CA8 | manual registrada | T3: romper sintaxis temporalmente en `src/resta.js` y luego en `src/multiplicacion.js` → `npm run lint` ≠ 0; revertir → 0. Salida debe contener la ruta rota y `SyntaxError`. Registro en `verificacion/T3-ca8.md`; el verificador repite los pasos |
| CA9 | diff + `npm test` | T3: `git diff origin/main -- src/suma.js test/suma.test.js` vacío + `npm test` verde |

## Foco de revisión (5 entradas probables de falla sin test → test que las fija)
1. `new Number(3)` aceptado si se valida con `Number.isFinite`/coerción en vez de `typeof` → CA3 incluye `new Number(3)` en `a` y `b`.
2. Validar `b` antes que `a` o combinar errores → CA5 con mensaje exacto de `resta('x', null)`.
3. `-0` normalizado a `0` (p. ej. `|| 0`, `+ 0`) → CA2 con `Object.is(..., -0)`.
4. Rechazar NaN/Infinity por exceso de celo (`Number.isFinite`) → CA7.
5. Lint que solo revisa el primer archivo (`node --check a b c`) → CA8 rompiendo cada módulo nuevo por separado, no solo el primero.

## Riesgos y rollback
- Riesgo: CI con Node 22 y local con 26: el código solo usa sintaxis ES2015+ y `node:test` (estable en 22) → bajo.
- Riesgo: el error de sintaxis temporal de CA8 se queda en el árbol → T3 exige `git diff --stat` sin cambios en esos archivos tras revertir y `npm run lint` = 0.
- Rollback: revertir el PR (solo archivos nuevos + una línea de `package.json`).

## Decisiones
| Decisión | Opción elegida | Alternativa | Por qué |
|---|---|---|---|
| Forma del lint | `node --check` encadenado con `&&` por archivo | glob/bucle `for f in src/*.js` | Explícito, portable (npm usa `sh`; en Windows `cmd` también soporta `&&`), sin depender de expansión de globs; reversible. Coste/límite conocido: RF8 habla de "un módulo de `src`"; un módulo futuro exigirá añadirlo al script (fuera de alcance de esta Spec) |
| Mensaje con `typeof` | `typeof` del valor tal cual (`null` → `object`) | Nombre "amigable" (`null`) | La Spec fija literal `<typeof del valor>` y CA4 espera `object` para `null` |
| Cobertura extra P1/P2 | Casos para RF7 `-0` en `resta`, RF5 y RF6 en `multiplicacion` | Solo lo que piden los CA | Barato, misma costura, fija RF que el plan promete cubrir |
| Tests de CA3 | Bucle sobre una tabla de valores, un `test()` por valor y posición | Un único test con muchos asserts | Un fallo señala el valor exacto; misma costura pública |

## Revisión del esceptico (2026-11-01, 1 ciclo)
Sin P0. Corregido: P1 evidencia de CA8 sobrescrita por el veredicto (`verificacion/T3.md`) → `T3-ca8.md` + el verificador repite; P1 CA8 solo con exit code → exige salida con `SyntaxError` y ruta. P2 corregidos: CA3 con mensaje exacto (falso verde con BigInt), casos RF5/RF6 en `multiplicacion` y RF7 `-0` en `resta`, mensajes de commit alineados con `./devos`, CA9 contra `origin/main`. P2 anotado sin cambio: lint encadenado no cubre módulos futuros (ver Decisiones). Descartado: mensaje RF4 con todos los `typeof` → ya cubierto al exigir el mensaje en CA3. Verificado en local: `node --check` con `export function (` sale 1 con `SyntaxError` (Node 26.8.2); Node 22 en CI no comprobable desde el sandbox, `[SUPUESTO]` mismo comportamiento.

## Tareas → tasks.md
