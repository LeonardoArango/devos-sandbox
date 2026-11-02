# Evaluar una skill
- Guarda casos en `evals/skills/<nombre>/casos.json`: `[{"id":1,"prompt":"…","esperado":"…","aserciones":["…"]}]`.
- Aserciones **objetivas** (archivo existe, sección presente, comando sale 0, no hay X). Lo subjetivo (estilo, diseño) lo juzgo yo mirando la salida.
- Por caso: un subagente con la skill y otro sin ella (o con la versión anterior), mismo prompt, salidas en carpetas separadas. Anota tokens y tiempo.
- Tabla: caso · con skill (✓/✗ por aserción) · sin skill · tokens. Una aserción que pasa en ambos no discrimina: cámbiala.
- Mejora = más aserciones pasadas sin subir mucho los tokens; si no mejora contra la línea base, la skill no se queda.
- Disparo: lista `debe-activar` / `no-debe-activar` (casi-aciertos realistas, no obvios). Revisa a mano en una sesión nueva.
