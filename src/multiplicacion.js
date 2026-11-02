export function multiplicacion(a, b) {
  if (typeof a !== 'number') throw new TypeError(`multiplicacion: el argumento 'a' debe ser un número (recibido: ${typeof a})`);
  if (typeof b !== 'number') throw new TypeError(`multiplicacion: el argumento 'b' debe ser un número (recibido: ${typeof b})`);
  return a * b;
}
