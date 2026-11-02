# Fuentes sugeridas
- Uso real: analítica del proyecto (si existe), Issues y bugs abiertos, mis notas.
- Técnico: docs oficiales del framework/librería, changelog y versiones soportadas, arquitectura del repo (`docs/`).
- Seguridad: OWASP Top 10 / ASVS para web; avisos de seguridad de dependencias.
- Privacidad (opcional, si hay usuarios con datos personales): leyes aplicables; en Colombia, Ley 1581/2012 y Decreto 1377/2013.
- Alternativas: proyectos open source o productos similares; marcar "marketing" si no hay evidencia.
- UI/UX: sistema de diseño o componentes del repo; heurísticas de Nielsen; WCAG 2.2 (ver `revision-ui/checklist.md`).

## Jerarquía de fuentes
1. Doc oficial de la versión instalada · 2. changelog/guía de migración · 3. estándares (MDN, WCAG, RFC) · 4. compatibilidad de navegador. Foros, blogs y respuestas de IA: solo pista, nunca fuente única.
Cita: `Fuente: <URL exacta>` (o `[SUPUESTO]` si no hay).

## Repo grande (opcional)
Antes de leer cientos de archivos, genera un mapa: estructura de carpetas, puntos de entrada, módulos y quién importa a quién (`git ls-files`, `rg -l`, grafo de imports si tu stack lo trae). Guárdalo en `research/<id>-mapa.md` y consúltalo en vez de releer. Herramientas de grafo de código existen, pero no instales nada sin mi OK.
