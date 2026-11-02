---
name: escribir-spec-y-registrar
description: Fase 3 del Personal Dev OS. Úsalo tras el challenge (o para una Spec lite) para redactar specs/<id>/spec.md, decidir conmigo la autonomía (sección 9) y documentarla COMPLETA en un GitHub Issue en borrador. La aprobación la doy yo después con ./devos aprobar.
---
# Escribir Spec y registrar
1. Copia `specs/_TEMPLATE.md` a `specs/<id>/spec.md`. Sintetiza solo lo del research y el challenge (no vuelvas a entrevistar); lo que falte va con marcador. Lite: secciones 1, 4, 7 y 9 (+ 6.1 si hay UI).
2. Requisitos en EARS; historias "Como <actor> quiero <x> para <beneficio>" en la sección 3; cada CA con método de verificación (sección 7).
3. **Costuras de prueba**: propone dónde se prueba el comportamiento (la costura más alta posible, idealmente una) y confírmalo conmigo.
4. Sin rutas de archivo ni fragmentos de código en la Spec (envejecen); excepción: un tipo/esquema/máquina de estados de un prototipo que fija una decisión.
5. Sección 11: **rebanadas verticales** con bloqueos según [rebanadas.md](rebanadas.md). Si la Spec pasa de ~1 semana de agente, propón partirla en varias Specs.
5b. Sección 9 (**autonomía**): pregúntame en una sola ronda qué preautorizo (dependencias, migraciones, auth, infra, deploy) con tu recomendación según el riesgo, y escribe la lista en `preautoriza:` del frontmatter. Lo no preautorizado detendrá el PR para mi revisión.
6. Revisa la sección 12. Crea la rama `feat/<id>` y haz commit de la Spec y el research. Muéstrame Spec, rebanadas, sección 9 y bloqueos.
7. Publica (te pedirá permiso): `guardrails/scripts/devos-issue.sh publicar <id>` crea el Issue con la Spec **completa** + un comentario con el challenge, y escribe la URL en `issue:`. Haz commit de ese cambio. Sub-issues de las rebanadas según [registro.md](registro.md). No cierres ni edites otros Issues.
8. La Spec queda en `borrador`. Termina con: `Listo: ./devos aprobar <id>`. **Yo** apruebo (tú no puedes: hook y TTY); desde ahí trabajan los agentes. Cambios de alcance posteriores: sube `version`, vuelve a `borrador` si cambia un P0, y re-publica.
