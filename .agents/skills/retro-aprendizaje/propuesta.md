---
fecha:
origen: <spec-id> / incidente / revisión mensual
destino: AGENTS.md | .agents/skills/<x> | specs/_TEMPLATE.md | guardrails/ | memory/proyecto/ | memory/lecciones/
tipo: agregar | modificar | borrar
---
## Patrón observado
## Evidencia (≥1 link: PR, sesión, Issue) y frecuencia
## Cambio propuesto (diff exacto)
## Cómo sabré que funcionó (eval o métrica)
## Decisión: aprobado / rechazado — fecha:

---
## Categorías de mejora del entorno
- **Navegación**: el agente buscó mucho algo que un puntero en AGENTS.md o un mapa le habría dado.
- **Chequeos automáticos**: toda violación mecánica (formato, imports, nombres, secretos) merece un chequeo determinista (lint, test, CI), no otra regla en prosa. Un repo sin guardarraíl para algo que ya falló es un hallazgo.
- **Estándares**: reglas de estilo que el revisor debe hacer cumplir (van a `verificar`, no solo al implementador).
- **AGENTS.md inflado**: líneas que no se usaron o que el modelo ya hace solo → borrar.
- **Economía de herramientas**: pasos repetidos a mano que un script o skill resolvería; herramientas que nadie usa.
- **No-ops**: instrucciones que no cambiaron ninguna conducta → borrar.
- **Acceso a información**: datos que el agente necesitó y no podía leer (docs, logs, entorno).
