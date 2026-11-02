# Plan técnico — <id>
- Spec: specs/<id>/spec.md (versión) · Issue: #<n> · Revisado por `esceptico`: <fecha>
- **Objetivo** (1 frase) · **Arquitectura** (2–3 frases) · **Stack y versiones**
## Restricciones globales (copiadas literal de la Spec)
## Enfoque (≤10 líneas)
## Mapa de archivos
| Archivo | Crea/Modifica | Responsabilidad |
## Contratos (API, eventos, esquemas): antes / después, con firmas
## Datos y migraciones (requieren mi aprobación)
## Qué NO cambia y cómo lo protejo (tests de regresión, paths protegidos)
## Verificación por CA
| CA | Tipo (unit/integración/e2e/captura/medición) | Dónde |
## Foco de revisión (5 entradas probables de falla sin test → test que las fija)
## Riesgos y rollback
## Tareas → tasks.md
```
### T<k>: <nombre>  · CA: … · Depende de: T<j>|ninguna
Archivos: crear … / modificar … / test …
- [ ] Test que falla (código del test) → `<cmd>` → esperado: FAIL por <motivo>
- [ ] Código mínimo → `<cmd>` → esperado: PASS
- [ ] Commit `<mensaje>`
```
