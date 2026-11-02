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
