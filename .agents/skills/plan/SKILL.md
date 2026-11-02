---
name: plan
description: Fases 4 y 5 del Personal Dev OS. Úsalo cuando una Spec está aprobada para producir specs/<id>/plan.md y specs/<id>/tasks.md con tareas verificables. En modo autónomo (lo lanza ./devos run) el Gate C lo reemplaza el subagente esceptico.
---
# Plan técnico y tareas
1. Sin tocar código. Lee la Spec, `specs/<id>/decisiones/` si existe, y explora solo los módulos de la sección 8 (subagente `explorador` si es amplio). Abre el plan con las decisiones que más probablemente cambien (datos, interfaces, UX); lo mecánico al final.
2. Escribe `plan.md` con [plantilla-plan.md](plantilla-plan.md) para alguien **sin contexto**: archivos exactos, nombres y firmas, valores de la Spec, comando de test. Prohibido "TBD", "manejar errores adecuadamente" o "igual que la tarea 3".
3. Primero el **mapa de archivos**; luego las tareas.
4. Decisiones con trade-off: elige la opción **conservadora y reversible** que respete la Spec y anótala en `plan.md` › Decisiones (opción, alternativa, por qué). Solo si cambia un P0 o exige algo no preautorizado (sección 9): escribe `specs/<id>/BLOQUEO.md` (pregunta concreta + tu recomendación) y termina.
5. `tasks.md`: encabezados exactos `### T<n>: <título> · CA: … · Depende de: T<m>|ninguna`. Una tarea = la unidad más pequeña con su propio ciclo de test (≤ medio día de agente). Pasos: test que falla → rojo → código mínimo → verde. Cada tarea: CA, archivos, comando de verificación. Ordenadas por dependencia.
6. Copia literal las **Restricciones globales** de la Spec y el **Foco de revisión** (5 entradas probables de falla sin test → test que las fija).
7. Consistencia: todo RF P0 tiene tarea y test; nada fuera de alcance. UI: tarea de estados, de Playwright (`pruebas-usuario`) y de `revision-ui`. Público: tarea `seo-aeo`.
8. **Revisión del plan**: pasa `plan.md` + `tasks.md` + la Spec al subagente `esceptico` ("demuestra que el plan no cumple algún CA, rompe 'qué no cambia' o deja un P0 sin test"). Corrige cada P0/P1; anota lo descartado con motivo. Máx. 2 ciclos.
9. Modo interactivo (sin `DEVOS_AUTONOMO`): muéstrame el resumen y pide OK. Modo autónomo: no publiques ni hagas commit; lo hace `./devos`.
