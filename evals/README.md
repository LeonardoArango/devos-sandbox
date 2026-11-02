# Evals del Personal Dev OS
Mido el **sistema** (skills, plantilla, AGENTS.md), no al modelo en abstracto.

## Set golden
- Carpeta `evals/golden/<nn>-<nombre>/`: `idea.md` (entrada), `notas.md` (qué debe preguntar el challenge y trampas), `spec-esperada.md`.
- Ejemplos: `01-exportar-csv` (lite), `02-pantalla-sedes` (UI con estados), `03-gate-playwright` (regresión del hook Stop), `04-sitio-publico-seo` (SEO/AEO); en 02–04 la salida esperada va en "Debe producir" de `notas.md`. **Construye más con tus funcionalidades pasadas**: toma un PR ya fusionado, escribe la idea original en 1–3 líneas, anota lo que hubieras querido que te preguntaran y lo que salió mal, y reescribe la Spec con la plantilla. Meta: 5–8 casos (incluye 1 lite, 1 con datos personales, 1 con auth o pagos).

## Corrida
- Cada caso **2 veces** con el mismo modelo/config. Antes y después de cada cambio en skills, plantilla o AGENTS.md, y con cada modelo nuevo.
- Yo respondo el challenge usando `notas.md` como guion. El registro se prueba en un repo sandbox (nunca en uno real).

## Métricas
| Métrica | Meta |
|---|---|
| Cobertura del challenge (% preguntas clave de `notas.md`) | ≥ 80% |
| Datos inventados | 0 |
| CA con método de verificación | ≥ 90% |
| Clasificó bien lite/completo | 100% |
| Pidió aprobación antes de crear el Issue | 100% |
| UI: corrida Playwright verde + axe 0 antes de "listo" | 100% |
| Público: `e2e/seo.spec.ts` verde y política de bots decidida por mí | 100% |
| Consistencia de alcance P0 entre corridas | ≥ 80% |
| Tokens y minutos de mi revisión | bajar 20% vs primera corrida |

Métrica norte: **salidas aceptadas / (minutos de revisión + tokens)**. Con `./devos`, el costo y los turnos por fase salen solos de `specs/<id>/uso.csv`, y las intervenciones tuyas = bloqueos + PR en `revisar-humano`; meta: ≤1 intervención por Spec fuera de la Spec y la aprobación. Registro en `resultados.csv`. Un cambio que empeora 2+ métricas no se fusiona.

## Capacidad vs regresión y consistencia
- **Regresión**: los casos que ya pasan deben seguir pasando (~100%). Se corre en **cada cambio** de skill, plantilla, `AGENTS.md`, hooks o modelo. Si baja, no se fusiona.
- **Capacidad**: casos difíciles que hoy fallan (meta: que suban). Cuando un caso pasa estable, "se gradúa" a regresión.
- **pass^k** (todas las k corridas pasan) en vez de pass@k: quiero que el sistema acierte **siempre**, no a veces. Con k=2: pass^2 = casos que pasaron en ambas corridas / casos.
- Graders: primero deterministas (tests, checklist de `rubrica.md`), luego LLM-juez con rúbrica por dimensión y opción "no sé"; yo calibro leyendo 1 de cada 5 transcripciones.
- Fuente nueva de casos: cada falla real (PR rechazado, bug, dato inventado) → un caso nuevo en `golden/`.
