import { test } from 'node:test';
import assert from 'node:assert/strict';
import { suma } from '../src/suma.js';
test('suma dos números', () => assert.equal(suma(2, 3), 5));
