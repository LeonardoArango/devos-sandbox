# Propuesta: en el challenge, preguntar solo alcance, datos y seguridad
- Origen: sesión interactiva de la Spec 001-resta-multiplicacion, 2026-11-01.
- Evidencia: el dueño cortó la 3.ª ronda (orden de validación, aridad, forma del comando lint) con: «Acepta todas tus recomendaciones. Pregúntame solo lo que cambie el alcance, los datos o la seguridad, en una sola ronda.»
- Cambio propuesto (skill `challenge`, paso 2): las decisiones de implementación de bajo impacto no se preguntan. Se aplica la recomendación y se anota en research §6 como "recomendación aceptada". AskUserQuestion queda para alcance, datos, seguridad y autonomía, en una sola ronda cuando se pueda.
- Riesgo: asumir en silencio algo que sí importaba. Mitigación: todo queda listado en §6 y en el comentario del Issue, revisable antes de `./devos aprobar`.
- revisar: 2027-02-01
