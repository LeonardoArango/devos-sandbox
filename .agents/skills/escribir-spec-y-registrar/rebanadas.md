# Rebanadas verticales ("tracer bullets")
- Cada rebanada atraviesa **todas** las capas necesarias (datos, API, UI, tests) de forma estrecha pero completa; nunca "solo backend" o "solo UI".
- Se puede demostrar o verificar sola, cabe en una sesión limpia (≤1 día) y tiene sus CA.
- El *prefactor* (dejar el código listo para el cambio) va primero.
- Cada rebanada declara **Bloqueada por**: las que deben terminar antes, o "ninguna". Se trabaja la *frontera*: cualquiera cuyos bloqueos estén cerrados.
- Excepción, **refactor amplio** (renombrar una columna o un tipo compartido): expandir (nueva forma junto a la vieja) → migrar por lotes (cada lote bloqueado por expandir) → contraer (borrar la vieja, bloqueada por todos los lotes). CI en verde en cada lote.

## Cuerpo de cada sub-issue
```
## Padre
#<n del Issue de la Spec>
## Qué entrega
<comportamiento de punta a punta, desde la persona usuaria; no lista de capas>
## Criterios de aceptación
- [ ] CA<x> …
## Bloqueada por
#<n> … | ninguna
```
