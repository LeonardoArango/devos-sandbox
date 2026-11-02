export function resta(a, b) {
  if (typeof a !== 'number') throw new TypeError(`resta: el argumento 'a' debe ser un número (recibido: ${typeof a})`);
  if (typeof b !== 'number') throw new TypeError(`resta: el argumento 'b' debe ser un número (recibido: ${typeof b})`);
  return a - b;
}
