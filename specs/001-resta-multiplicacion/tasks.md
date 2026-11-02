# Tareas — 001-resta-multiplicacion
Spec: `specs/001-resta-multiplicacion/spec.md` (§4, §5, §7) · Plan: `specs/001-resta-multiplicacion/plan.md`
Comandos: `npm test` · `npm run lint`. Antes de cada tarea, lee las secciones citadas de la Spec y el plan (Contratos, Restricciones globales).

## Restricciones globales (copiadas literal de la Spec)
- Fuera:
  - Validar `suma`.
  - Rechazar NaN o ±Infinity.
  - Validar la cantidad de argumentos.
  - Soporte para BigInt.
  - Un helper de validación compartido (YAGNI con 2 funciones).
  - Dependencias nuevas.
- **No debe cambiar:** el comportamiento ni el test de `suma`, el script `test` (`node --test`) y `"type": "module"`.
- Editar el script `lint` de `package.json` está dentro del alcance (§4); no es una dependencia. Siempre humano (no preautorizable): datos reales/personales en pruebas, envíos reales, gastar dinero, borrar datos, CI/CD, secretos. Decidido con el dueño el 2026-11-01: `preautoriza: []`.

## Foco de revisión
1. `new Number(3)` aceptado por validar con coerción → CA3 (T1, T2).
2. Orden de validación `b` antes que `a` → CA5 (T1).
3. `-0` normalizado a `0` → CA2 con `Object.is` (T2).
4. NaN/Infinity rechazados por exceso de celo → CA7 (T1, T2).
5. Lint que solo revisa el primer archivo → CA8 rompiendo cada módulo por separado (T3).

### T1: resta con validación de tipo · CA: CA1, CA3, CA4, CA5, CA6, CA7 · Depende de: ninguna
Archivos: crear `src/resta.js` / test `test/resta.test.js`. No tocar `src/suma.js`, `test/suma.test.js`, `package.json`.
- [ ] Test que falla — `test/resta.test.js`:
```js
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { resta } from '../src/resta.js';

test('CA1 resta dos números', () => {
  assert.equal(resta(5, 3), 2);
  assert.equal(resta(0.3, 0.1), 0.3 - 0.1);
});

const invalidos = [['string "3"', '3'], ['bigint', 1n], ['null', null], ['undefined', undefined],
  ['boolean', true], ['objeto', {}], ['new Number(3)', new Number(3)]];
for (const [nombre, v] of invalidos) {
  test(`CA3 resta lanza TypeError con ${nombre} en a`, () =>
    assert.throws(() => resta(v, 1), { name: 'TypeError', message: `resta: el argumento 'a' debe ser un número (recibido: ${typeof v})` }));
  test(`CA3 resta lanza TypeError con ${nombre} en b`, () =>
    assert.throws(() => resta(1, v), { name: 'TypeError', message: `resta: el argumento 'b' debe ser un número (recibido: ${typeof v})` }));
}

test('CA4 mensaje exacto de resta', () =>
  assert.throws(() => resta('x', 1), {
    name: 'TypeError',
    message: "resta: el argumento 'a' debe ser un número (recibido: string)",
  }));

test('CA5 con ambos inválidos reporta a', () =>
  assert.throws(() => resta('x', null), {
    name: 'TypeError',
    message: "resta: el argumento 'a' debe ser un número (recibido: string)",
  }));

test('CA6 ignora argumentos de más', () => assert.equal(resta(1, 2, 3), -1));

test('CA7 acepta Infinity y devuelve NaN sin error', () =>
  assert.ok(Number.isNaN(resta(Infinity, Infinity))));

test('RF7 resta acepta -0', () => assert.ok(Object.is(resta(-0, 0), -0)));
```
- [ ] `npm test` → esperado: FAIL por `ERR_MODULE_NOT_FOUND` de `../src/resta.js` (el test de `suma` sigue en verde)
- [ ] Código mínimo — `src/resta.js` según plan › Contratos (valida `a`, luego `b`, con `typeof !== 'number'` → `throw new TypeError(\`resta: el argumento 'a' debe ser un número (recibido: ${typeof a})\`)`; devuelve `a - b`)
- [ ] `npm test` → esperado: PASS (todos los tests, incluido `suma dos números`)
- [ ] Sin commit: lo hace `./devos` al cerrar la tarea (formato `T<n>(001-resta-multiplicacion): …`).

### T2: multiplicacion con validación de tipo · CA: CA2, CA3, CA4, CA7 · Depende de: ninguna
Archivos: crear `src/multiplicacion.js` / test `test/multiplicacion.test.js`. No tocar `src/suma.js`, `test/suma.test.js`, `package.json`.
- [ ] Test que falla — `test/multiplicacion.test.js`:
```js
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { multiplicacion } from '../src/multiplicacion.js';

test('CA2 multiplica dos números', () => {
  assert.equal(multiplicacion(4, 2.5), 10);
  assert.ok(Object.is(multiplicacion(-1, 0), -0));
});

const invalidos = [['string "3"', '3'], ['bigint', 1n], ['null', null], ['undefined', undefined],
  ['boolean', true], ['objeto', {}], ['new Number(3)', new Number(3)]];
for (const [nombre, v] of invalidos) {
  test(`CA3 multiplicacion lanza TypeError con ${nombre} en a`, () =>
    assert.throws(() => multiplicacion(v, 1), { name: 'TypeError', message: `multiplicacion: el argumento 'a' debe ser un número (recibido: ${typeof v})` }));
  test(`CA3 multiplicacion lanza TypeError con ${nombre} en b`, () =>
    assert.throws(() => multiplicacion(1, v), { name: 'TypeError', message: `multiplicacion: el argumento 'b' debe ser un número (recibido: ${typeof v})` }));
}

test('CA4 mensaje exacto de multiplicacion', () =>
  assert.throws(() => multiplicacion(2, null), {
    name: 'TypeError',
    message: "multiplicacion: el argumento 'b' debe ser un número (recibido: object)",
  }));

test('CA7 acepta NaN y devuelve NaN sin error', () =>
  assert.ok(Number.isNaN(multiplicacion(NaN, 2))));

test('RF5 multiplicacion con ambos inválidos reporta a', () =>
  assert.throws(() => multiplicacion(undefined, 'x'), {
    name: 'TypeError',
    message: "multiplicacion: el argumento 'a' debe ser un número (recibido: undefined)",
  }));

test('RF6 multiplicacion ignora argumentos de más', () => assert.equal(multiplicacion(2, 3, 4), 6));
```
- [ ] `npm test` → esperado: FAIL por `ERR_MODULE_NOT_FOUND` de `../src/multiplicacion.js`
- [ ] Código mínimo — `src/multiplicacion.js` según plan › Contratos (prefijo `multiplicacion:`, valida `a` luego `b`, devuelve `a * b`)
- [ ] `npm test` → esperado: PASS (todos los tests, incluido `suma dos números`)
- [ ] Sin commit: lo hace `./devos` al cerrar la tarea (formato `T<n>(001-resta-multiplicacion): …`).

### T3: lint de todos los módulos y regresión de suma · CA: CA8, CA9 · Depende de: T1, T2
Archivos: modificar solo `scripts.lint` de `package.json`; crear `specs/001-resta-multiplicacion/verificacion/T3-ca8.md` (evidencia del constructor; **no** escribir `verificacion/T3.md`, que es el veredicto de `./devos`/`verificar`).
- [ ] Prueba que falla (manual, CA8): con el script actual, añadir temporalmente la línea `export function (` al final de `src/resta.js` → `npm run lint` → esperado: sale 0 (FALLA el CA8: el lint no ve `resta.js`). Revertir con `git checkout -- src/resta.js` si ya está commiteado, o borrando la línea.
- [ ] Cambio mínimo: `"lint": "node --check src/suma.js && node --check src/resta.js && node --check src/multiplicacion.js"` (no tocar `test` ni `type`).
- [ ] CA8 verde, registrado en `verificacion/T3-ca8.md` con la **salida completa** (stdout+stderr) y el código de salida de cada paso (`npm run lint 2>&1; echo "exit=$?"`):
  1. Estado limpio → exit=0.
  2. Añadir al final de `src/resta.js` la línea `export function (` → salida ≠ 0 **y** contiene `src/resta.js` y `SyntaxError`. Revertir.
  3. Igual con `src/multiplicacion.js` → salida ≠ 0 **y** contiene `src/multiplicacion.js` y `SyntaxError`. Revertir.
  4. Estado limpio → exit=0 y `git diff --stat -- src/` sin cambios respecto a lo construido en T1/T2.
- [ ] El verificador independiente repite los pasos 1–4 por su cuenta (no se fía de `T3-ca8.md`).
- [ ] CA9 + restricciones: `git fetch origin main` (si hay red) y `git diff origin/main -- src/suma.js test/suma.test.js` → vacío; `node -e "const p=JSON.parse(require('fs').readFileSync('package.json','utf8'));if(p.scripts.test!=='node --test'||p.type!=='module')process.exit(1)"` → 0; `npm test` → PASS con `suma dos números` en la salida.
- [ ] Sin commit: lo hace `./devos` al cerrar la tarea (formato `T<n>(001-resta-multiplicacion): …`).
