---
name: challenge
description: Fase 2 del Personal Dev OS. Úsalo después de investigar y antes de escribir una Spec, o cuando quiera construir algo sin haberlo cuestionado. Entrevista por rondas, propone lo más simple y somete las afirmaciones clave a duda en contexto limpio.
---
# Challenge
1. Lee `research/<id>.md`. Arma el **árbol de decisiones**: elementos (pantallas, flujos, integraciones, datos) y las decisiones que cuelgan de cada uno.
2. Pregunta por **rondas** sobre la *frontera* (decisiones cuyos prerrequisitos ya están resueltos), con [preguntas.md](preguntas.md). Máx. 3 por ronda (AskUserQuestion), numeradas, cada una con **mi respuesta recomendada** y redactada para que "sí" la acepte. Lo que más cambia el alcance va primero.
3. Los **hechos** los busco yo (repo, docs; subagente `explorador` si es mucho); a ti solo te pregunto **decisiones**.
4. **YAGNI** (escalera de [duda.md](duda.md)): por cada elemento, ¿hace falta?, ¿ya existe en el repo?, ¿lo da la plataforma/librería instalada? Propón al menos una alternativa más simple y un "¿y si no lo hago?". Nunca recortes: validación en bordes de confianza, manejo de errores que evita pérdida de datos, seguridad, accesibilidad.
5. **Duda**: cada afirmación no trivial que sostiene el alcance ("es seguro", "escala", "cumple la Spec") pasa por el subagente `esceptico` en contexto limpio ([duda.md](duda.md)). Máx. 3 ciclos. Cierra con un abogado del diablo: el caso más fuerte para **no** construirlo.
6. Si hay UI: preguntas *Interfaz* y propone `diseno-ui`/`ux-flujos`/`pruebas-usuario`. Si hay páginas públicas: preguntas *SEO/AEO* y `seo-aeo`.
7. Anota en la sección 6 del research: respuesta / `[SUPUESTO]` / `[PENDIENTE]`. Si pasa de ~1 semana, propone rebanadas verticales.
8. Termina cuando la frontera esté vacía (nada asumido en silencio). Confirma lite o completo (README) y resumen ≤15 líneas. Si respondí todas las rondas, eso es el Gate A: sigue a `escribir-spec-y-registrar` sin pedir otra confirmación; si dije "no vale la pena", marca el research como descartado. Las decisiones de la sección 6 quedan en el Issue al publicarlo (lo hace `devos-issue.sh`).

Camino lite: basta con las 5 preguntas marcadas ★ y el paso 4.
