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
