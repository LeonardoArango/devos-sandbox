# Cómo registrar en GitHub Issues
## Con `gh` (preferido)
1. Duplicados: `gh issue list --state all --search "<palabras> in:title"`.
2. Crear (al terminar la Spec, en borrador; pide permiso): `guardrails/scripts/devos-issue.sh publicar <id>`. Pone la Spec completa como cuerpo, etiquetas `spec` y `needs-approval`, comenta las decisiones del challenge y escribe la URL en `issue:` (enlace de vuelta).
3. Cada versión nueva de la Spec: el mismo comando actualiza el cuerpo y deja un comentario con la versión.
4. Avances (plan aprobado, recibo de cada PR, retro): `devos-issue.sh nota <id> <archivo.md>`. El Issue es la bitácora; el repo, la fuente.
5. `./devos aprobar` cambia `needs-approval` por `aprobada` (tú no tocas etiquetas de aprobación).
6. **Rebanadas** (tras publicar la Spec, en orden de dependencia: primero las que no tienen bloqueos):
   `gh issue create --title "<id> · <rebanada>" --body-file /tmp/reb-<k>.md --parent <n> --blocked-by <m1>,<m2> --label spec`
   Sobre Issues existentes: `gh issue edit <padre> --add-sub-issue <k>` y `gh issue edit <k> --add-blocked-by <m>`. Ver: `gh issue view <k> --json blockedBy,blocking`.
   Si tu `gh` no tiene esas opciones: actualízalo, o deja "Bloqueada por #m" en el cuerpo y checklist en el padre.
## Con GitHub MCP (alternativa)
- Mismo contenido con la herramienta de crear issue; MCP en solo lectura fuera de esta fase.
## Reglas
- Fuente de verdad: el archivo en el repo (versionado y revisable por PR). El Issue lleva la Spec completa regenerada, las decisiones y la bitácora; nunca se edita a mano.
- Cambio de alcance: primero edito la Spec (sube `version`), luego actualizo el Issue.
- Tareas: sub-issues (preferido, con *blocked by* nativo) o checklist en el Issue; el PR que abre `./devos` cierra el Issue padre y las rebanadas listadas en la sección 11.
- Docs: https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/adding-sub-issues · https://docs.github.com/en/issues/tracking-your-work-with-issues/using-issues/creating-issue-dependencies
- Nunca pegues tokens en prompts ni archivos; `gh` usa su propio login.
