# Batería de preguntas por elemento
## Usuario
- ★ ¿Quién lo usa (yo, familia, usuarios públicos)? ¿Qué hace hoy sin esto?
## Valor
- ★ ¿Qué gano si funciona? ¿Hay una alternativa más simple (configuración, script, herramienta existente) que dé el 80%?
## Datos
- ★ ¿Qué datos entran, salen o se guardan? ¿Dónde, cuánto tiempo, quién los ve? ¿Cambia el esquema?
- ¿Hay datos personales de otras personas? (Opcional: aviso de privacidad, consentimiento; Ley 1581 si hay usuarios en Colombia.)
## Seguridad
- ★ ¿Toca auth, pagos, secretos, permisos o integraciones con terceros? (Si sí → camino completo.)
- ¿Qué pasa si alguien manipula la entrada (inyección, archivos, URLs)?
## Plataformas
- ¿Navegadores/dispositivos/SO objetivo? ¿Móvil? ¿Accesibilidad?
## Casos borde
- Vacío, enorme, duplicado, zona horaria (America/Bogota), idioma, red lenta o caída, reintentos.
- ¿Qué pasa si falla el servicio externo?
## Métricas
- ★ ¿Cómo sabré que funcionó? ¿Línea base y de dónde sale? (Si no hay: `[PENDIENTE]`, no inventar.)
## Operación
- ¿Cómo lo despliego? ¿Rollback? ¿Costo mensual nuevo (hosting, APIs)?
## Interfaz (si hay UI)
- ★ ¿Qué es lo **único** que la persona debe poder hacer en esta pantalla? ¿Desde dónde llega y a dónde va después?
- ¿Estados: vacío, cargando, error, éxito, sin permiso, sin conexión? ¿Qué texto ve en cada uno?
- ¿Móvil primero? ¿Anchos objetivo (360, 768, 1280+)? ¿Teclado y lector de pantalla?
- ¿Hay sistema de diseño/tokens o componentes existentes que deba reutilizar? ¿Marca o dirección visual?
- ¿Qué haría que se sienta "genérico de IA"? (Ver `diseno-ui`.)
- ★ ¿Tienes Playwright en el repo? Si no, ¿me autorizas a instalarlo (`npm i -D @playwright/test @axe-core/playwright`)? Sin eso no hay UI verificada.
## SEO / AEO (si hay páginas públicas)
- ★ ¿Qué páginas deben aparecer en Google/ChatGPT/Perplexity y cuáles son privadas? ¿Qué pregunta concreta responde cada una?
- ¿Idiomas y países? (hreflang) ¿Dominio final y versión canónica (www, https, barra final)?
- ¿Permitimos bots de **entrenamiento** de IA (GPTBot, ClaudeBot, Google-Extended)? Recomiendo permitir los de **búsqueda** siempre.
- ¿Qué tenemos que nadie más tiene (datos propios, casos, experiencia)? ¿Quién firma como autor? (Contenido "commodity" no se cita.)
- ¿Negocio local o productos? (Business Profile, Merchant Center, `LocalBusiness`/`Product`) ¿Hace falta `llms.txt` (docs para agentes) o no?
