---
id: 001-resta-multiplicacion
titulo: "Funciones resta y multiplicación con validación de tipo"
camino: lite
estado: aprobada
version: 0.1
issue: https://github.com/LeonardoArango/devos-sandbox/issues/1
research: research/001-resta-multiplicacion.md
preautoriza: []
aprobado: "2026-11-01 22:58 · Leonardo Arango · cli"
---
# Funciones resta y multiplicación con validación de tipo
Marcadores: `[SUPUESTO]` `[PENDIENTE]` `[Propuesta IA]`. Nunca inventar datos. Un `[PENDIENTE]` que bloquee un P0 impide aprobar.
Lite = secciones 1, 4, 7 y 9 (se agregan 3, 5, 8, 10, 11 y 12, breves).

## 1. Problema y contexto
El sandbox solo tiene `suma`, que no valida sus argumentos. Faltan resta y multiplicación. La coerción implícita de JS da resultados silenciosos y engañosos (`'5' * '2'` → 10), así que las funciones nuevas deben rechazar lo que no sea de tipo number. El valor principal es ejercitar el Personal Dev OS de punta a punta (research §6, abogado del diablo). Fuente: `research/001-resta-multiplicacion.md`.

## 3. Usuarios y camino feliz
- Usuarios: el dueño del repo (sandbox).
- Historia: Como dueño quiero `resta` y `multiplicacion` que fallen con un error claro ante entradas que no son números, para no arrastrar coerciones silenciosas.
- Camino feliz: importa la función → la llama con dos números → recibe el resultado; si pasa algo que no es number → recibe un `TypeError` que dice qué argumento falló y qué tipo recibió.

## 4. Alcance, fuera de alcance y qué NO debe cambiar
- Dentro:
  - Dos funciones exportadas, `resta(a, b)` (a − b) y `multiplicacion(a, b)` (a × b). Cada una en su propio módulo, como `suma`, con su archivo de tests.
  - Validación por tipo (`typeof` = "number").
  - Ampliar el script de lint para que revise también los módulos nuevos, y que falle si cualquiera de ellos tiene un error de sintaxis.
- Fuera:
  - Validar `suma`.
  - Rechazar NaN o ±Infinity.
  - Validar la cantidad de argumentos.
  - Soporte para BigInt.
  - Un helper de validación compartido (YAGNI con 2 funciones).
  - Dependencias nuevas.
- **No debe cambiar:** el comportamiento ni el test de `suma`, el script `test` (`node --test`) y `"type": "module"`.

## 5. Requisitos funcionales — EARS
| ID | Requisito | P |
|---|---|---|
| RF1 | CUANDO se llama `resta(a, b)` con `a` y `b` de tipo number EL SISTEMA DEBE devolver `a - b` | P0 |
| RF2 | CUANDO se llama `multiplicacion(a, b)` con `a` y `b` de tipo number EL SISTEMA DEBE devolver `a * b` | P0 |
| RF3 | CUANDO algún argumento no es de tipo number (string, incluido "3", BigInt, null, undefined, boolean, objeto, `new Number(3)`) EL SISTEMA DEBE lanzar `TypeError` sin calcular | P0 |
| RF4 | CUANDO lanza el error EL SISTEMA DEBE usar el mensaje `"<funcion>: el argumento '<a\|b>' debe ser un número (recibido: <typeof del valor>)"` | P1 |
| RF5 | CUANDO ambos argumentos son inválidos EL SISTEMA DEBE reportar `a` (se valida `a` y luego `b`; se lanza el primer error) | P1 |
| RF6 | CUANDO se pasan argumentos de más EL SISTEMA DEBE ignorarlos, como `suma` | P2 |
| RF7 | CUANDO se recibe NaN, ±Infinity o -0 EL SISTEMA DEBE aceptarlos (son de tipo number) y devolver el resultado de JS | P1 |
| RF8 | CUANDO un módulo de `src` tiene un error de sintaxis EL SISTEMA DEBE hacer fallar `npm run lint` | P1 |

## 7. Criterios de aceptación con evidencia
Costura de prueba única: la API pública de cada módulo (import de la función exportada) vía `npm test`; más `npm run lint`.
| CA | Dado / Cuando / Entonces | RF | Cómo se verifica | Evidencia (link) |
|---|---|---|---|---|
| CA1 | Dado `resta`, cuando `resta(5, 3)` y `resta(0.3, 0.1)`, entonces 2 y `0.3 - 0.1` (igualdad exacta con la expresión JS) | RF1 | test automático | |
| CA2 | Dado `multiplicacion`, cuando `multiplicacion(4, 2.5)`, entonces 10; cuando `multiplicacion(-1, 0)`, entonces `-0` (comparado con `Object.is`) | RF2, RF7 | test automático | |
| CA3 | Dado cada función, cuando algún argumento es `'3'`, `1n`, `null`, `undefined`, `true`, `{}` o `new Number(3)` (probado en posición `a` y en `b`), entonces lanza `TypeError` | RF3 | test automático (`assert.throws` con `{ name: 'TypeError' }`) | |
| CA4 | Dado `resta('x', 1)`, entonces mensaje exacto `resta: el argumento 'a' debe ser un número (recibido: string)`; dado `multiplicacion(2, null)`, entonces `multiplicacion: el argumento 'b' debe ser un número (recibido: object)` | RF4 | test automático (mensaje completo) | |
| CA5 | Dado `resta('x', null)`, entonces el mensaje nombra `'a'` | RF5 | test automático | |
| CA6 | Dado `resta(1, 2, 3)`, entonces -1 | RF6 | test automático | |
| CA7 | Dado `resta(Infinity, Infinity)` y `multiplicacion(NaN, 2)`, entonces NaN (con `Number.isNaN`), sin error | RF7 | test automático | |
| CA8 | Dado un módulo nuevo con un error de sintaxis introducido temporalmente, cuando `npm run lint`, entonces sale ≠ 0; al revertirlo sale 0 (nota: `node --check a b` solo revisa el primer archivo, verificado en Node v26.8.2) | RF8 | verificación manual registrada en `verificacion/` | |
| CA9 | `suma` y su test sin cambios en el diff; `npm test` en verde, incluido el test de `suma` | §4 No debe cambiar | diff + `npm test` | |

## 8. Contexto técnico (mapa, no manual)
- Módulos: `src` (un módulo por función, ESM, export nombrado), `test` (`node:test` + `node:assert/strict`), script de lint en `package.json`.
- Gotcha: `assert.strict.equal` usa `Object.is`, así que distingue `-0` de `0` y considera NaN igual a NaN. Fijar los valores esperados como en los CA2 y CA7.
- Node local v26.8.2; `engines` no está fijado.

## 9. Autonomía y preautorizaciones
Tras `./devos aprobar`, los agentes planean, construyen, verifican, abren PR y lo fusionan **solos**. Lo que no esté preautorizado detiene el PR para mi revisión (etiqueta `revisar-humano`).
| Categoría | ¿Preautorizada? | Límite / condición |
|---|---|---|
| dependencias (nuevas o actualizadas) | no | no hacen falta |
| migraciones (esquema) | no | no aplica |
| auth / permisos | no | no aplica |
| infra (Docker, IaC) | no | no aplica |
| deploy (lo hace el CI al fusionar en main) | no | no aplica |
Editar el script `lint` de `package.json` está dentro del alcance (§4); no es una dependencia. Siempre humano (no preautorizable): datos reales/personales en pruebas, envíos reales, gastar dinero, borrar datos, CI/CD, secretos. Decidido con el dueño el 2026-11-01: `preautoriza: []`.

## 10. Riesgos y preguntas abiertas
| Tipo | Descripción | Impacto | Estado |
|---|---|---|---|
| Diseño | API inconsistente: `suma` no valida y las nuevas sí | bajo | aceptado; validar `suma` sería otra Spec |
| Diseño | NaN e Infinity se aceptan y propagan NaN | bajo | decisión del dueño (opción A) |
| Proceso | Duplicados en GitHub Issues no verificados (sin red desde el sandbox) | bajo | `[PENDIENTE]` al publicar |
Sin preguntas P0 abiertas.

## 11. Rebanadas
| Rebanada | Valor | CA | Issue/tarea |
|---|---|---|---|
| R1 · resta y multiplicación validadas + lint | Ambas funciones usables con errores claros y lint que las cubre | CA1–CA9 | Bloqueada por: ninguna. Sin sub-issue: la rebanada única es el Issue padre |

## 12. Lista para desarrollo
- [x] Problema con fuente · [x] CA verificables · [x] Qué no cambia definido · [x] Seguridad/datos revisados (no hay)
- [x] UI → N/A · Público → N/A · [x] Sin preguntas P0 abiertas · [ ] Issue creado y enlazado · [x] Sección 9 decidida (autonomía)
