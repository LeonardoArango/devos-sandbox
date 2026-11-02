---
name: crear-skill
description: Úsalo solo cuando pida crear, mejorar o evaluar una skill del Personal Dev OS (/crear-skill). Guía formato, descripción que dispara bien y pruebas con y sin la skill.
disable-model-invocation: true
---
# Crear o mejorar una skill
1. **Intención**: ¿qué hace?, ¿cuándo debe activarse (frases reales mías)?, ¿qué salida produce?, ¿cómo sé que salió bien? Si viene de una conversación, extrae los pasos y correcciones que ya hicimos.
2. **Estructura** en `.agents/skills/<nombre>/`: `SKILL.md` (<30 líneas, imperativo, explica el *porqué* en vez de MAYÚSCULAS) + anexos que se cargan solo cuando el SKILL.md los enlaza. Sin scripts con red ni hooks.
3. **Descripción** (lo único siempre en contexto, ≤~60 palabras): qué hace + cuándo usarla, con palabras que yo diría; un poco insistente para que no se quede sin usar. Manual o con efectos (deploy, publicar): `disable-model-invocation: true`.
4. **Pruebas** ([evals.md](evals.md)): 2–3 tareas reales; corre cada una **con** y **sin** la skill (subagentes limpios); compara contra aserciones verificables; muéstrame resultados.
5. **Disparo**: ~10 frases que deben activarla y ~10 parecidas que no; ajusta la descripción hasta que acierte.
6. Itera con mi feedback: generaliza (no sobreajustes a los ejemplos), quita lo que no cambió la conducta.
7. Es cambio de memoria/kit: se aplica en `./devos memoria` (sesión con el dueño) y PR. Fuente adaptada → línea en `CREDITOS.md`.
