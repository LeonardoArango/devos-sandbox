# Duda y YAGNI (se carga solo cuando el SKILL.md lo pide)

## Escalera YAGNI: toma el primer peldaño que resuelve todo
1. ¿Tiene que existir? Lo que nadie pidió (opciones, configuración, "para después") se nombra en una línea y se omite.
2. ¿Ya existe en este repo (helper, componente, patrón)? Úsalo como lo usa el código vecino.
3. ¿Lo da la plataforma o la librería estándar? Úsalo.
4. ¿Lo da una dependencia ya instalada? Úsala. Nunca una dependencia nueva por unas pocas líneas.
5. Si no: el mínimo código que funciona, **completo** (callers, tests y fixtures que el cambio rompe).
Atajo con límite conocido → comentario `atajo: <límite>, <cuándo mejorar>`.

## Ciclo de duda (para decisiones no triviales)
No trivial = agrega/cambia ramas lógicas, cruza un módulo o servicio, afirma algo que el compilador no prueba (idempotencia, orden, seguridad), o es irreversible (migración, API pública, deploy). No aplica a renombres, formato ni instrucciones claras.
1. **AFIRMACIÓN**: 2–3 líneas + por qué importa si es falsa.
2. **EXTRAE**: el artefacto (texto de Spec, diff o decisión) y el contrato (CA, "qué no debe cambiar"), **sin** mi razonamiento.
3. **DUDA**: subagente `esceptico` (contexto limpio, sin escritura): "Intenta demostrar que esta afirmación es falsa. Cita el texto exacto. Si no puedes, di qué evidencia faltaría."
4. **CONCILIA**: cada hallazgo → corregido / descartado con motivo (citando el artefacto) / `[PENDIENTE]` para mí.
5. **PARA**: hallazgos triviales, 3 ciclos, o yo digo basta. Si ya estás dentro de un subagente, no anides: avísame y márcalo como duda degradada.
