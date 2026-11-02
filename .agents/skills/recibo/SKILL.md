---
name: recibo
description: Úsalo al cerrar una Spec o tarea del Personal Dev OS, después de verificar. Escribe specs/<id>/recibo.md con el formato de recibo de cambio; ./devos lo usa como cuerpo del PR y como nota en el Issue.
---
# Recibo de cambio
Escribe `specs/<id>/recibo.md` con [formato.md](formato.md), cubriendo todas las tareas (evidencia en `specs/<id>/verificacion/`, desviaciones en `implementation-notes.md`, costo en `uso.csv`). Reglas:
- "VERIFICADO" solo con evidencia; lo demás en "NO VERIFICADO".
- Riesgos literales, sin maquillaje.
- **REQUIERE APROBACIÓN**: escribe `ninguno` solo si es verdad. Cualquier otra cosa detiene el auto-merge (es a propósito).
- No incluyas `Closes #…` ni abras el PR: lo hace `./devos`. Tú nunca haces push ni merge.
