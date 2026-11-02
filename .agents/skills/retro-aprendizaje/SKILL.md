---
name: retro-aprendizaje
description: Fase 9 del Personal Dev OS. Úsalo al cerrar una Spec (lo lanza ./devos run), tras un incidente o en la sesión ./devos memoria. Convierte fallas y patrones en aprendizaje: hechos del proyecto directo a memory/proyecto/, cambios de proceso como propuestas con evidencia.
---
# Retro y aprendizaje
1. Delega en el subagente `aprendiz`. Recolecta: `implementation-notes.md` (Desviaciones), `verificacion/` (rechazos y por qué), `uso.csv` (fases caras o con muchos intentos), `decisiones/` (bloqueos), el diff, y si existen, comentarios de revisión y bugs posteriores.
2. **Aprendizaje directo** (sin gate, bajo riesgo): hechos y decisiones del proyecto → `memory/proyecto/<repo>.md` (ADR corto: fecha · decisión · por qué). Solo lo que la próxima Spec necesitaría y no está en el código.
3. **Propuestas** (cambian conducta, necesitan al dueño): por patrón (≥2 ocurrencias o 1 grave), ¿faltó **conocimiento** (→ gotcha/skill) o **proceso** (→ checklist/hook)? Escalera: explicación → checklist → plantilla → chequeo automático → política. Revisa el **entorno del agente** con las categorías de [propuesta.md](propuesta.md).
4. Una propuesta por archivo: `memory/propuestas/<fecha>-<tema>.md` con [propuesta.md](propuesta.md): diff exacto, evidencia, frecuencia, cómo medir que funcionó. Propón también qué **borrar**.
5. Antes de proponer, pregúntate: ¿esta regla habría evitado una falla real de este ciclo? Si no, no la propongas.
6. En `./devos memoria` (sesión con el dueño): presenta cada propuesta, aplica solo las aprobadas, mueve las decididas a `memory/propuestas/decididas/` y registra en `memory/CHANGELOG.md`.
