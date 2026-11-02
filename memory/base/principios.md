# Mis principios (solo lectura para agentes)
- Ningún dato inventado en specs, código o reportes; si falta, `[PENDIENTE]`.
- Simple primero: la alternativa más pequeña que resuelva el 80% (YAGNI). Nunca recortar validación, manejo de errores, seguridad ni accesibilidad.
- Interfaces: probadas como usuario (Playwright) y accesibles (WCAG 2.2 AA); sitios públicos encontrables (SEO/AEO) sin trucos.
- Secretos solo en variables de entorno o gestor de secretos; nunca en el repo.
- Datos personales: minimizar, nunca en logs ni fixtures.
- Todo en español; zona horaria America/Bogota.
- Cambios reversibles y PR pequeños.
