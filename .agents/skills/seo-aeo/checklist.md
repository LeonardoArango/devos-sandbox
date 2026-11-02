# Checklist SEO + AEO (página pública)
## Técnico
- [ ] Contenido principal en el HTML inicial (SSR/SSG/prerender); enlaces `<a href>` rastreables; sin rutas `#/`
- [ ] Estado HTTP correcto: 200, 301 (permanente), 404/410 en lo borrado; sin "soft 404" en SPA
- [ ] `<title>` único y descriptivo (marca al final); meta description única que resume la página
- [ ] Una `rel=canonical` absoluta, igual en HTML inicial y renderizado; sin canonical a páginas distintas
- [ ] `<html lang="es">` (o el idioma real); `hreflang` recíproco + `x-default` si hay varios idiomas
- [ ] `robots.txt` en la raíz con `Sitemap:` y la política de bots de IA decidida; no bloquea CSS/JS
- [ ] `sitemap.xml` con solo URLs canónicas indexables y `lastmod` real; se actualiza al publicar
- [ ] `noindex` en privadas, búsqueda interna, staging (y staging protegido con contraseña)
- [ ] URLs cortas, minúsculas, con guiones, estables; parámetros mínimos; sin duplicados (http/https, www, barra final)
- [ ] Open Graph (`og:title`, `og:description`, `og:image` 1200×630, `og:url`, `og:type`) + `twitter:card`
- [ ] Favicon cuadrado ≥48 px, `apple-touch-icon`, `manifest.webmanifest`, `theme-color`
- [ ] HTTPS, sin contenido mixto; móvil usable (mismo contenido que escritorio)
## Contenido y estructura
- [ ] Un `h1` que dice de qué trata; `h2/h3` en orden; HTML semántico (`header/nav/main/article/footer`)
- [ ] Imágenes: `alt` que describe, nombre de archivo descriptivo, `width/height`, WebP/AVIF, `lazy` bajo el pliegue
- [ ] Enlaces internos con texto descriptivo (no "clic aquí"); cada página importante a ≤3 clics; migas visibles
- [ ] Datos estructurados que coinciden con lo visible (datos-estructurados.md)
## AEO: contenido que una IA puede citar
- [ ] **Respuesta primero**: el primer párrafo responde la pregunta principal en 1–3 frases; detalle después
- [ ] Una página = un tema/intención; título, h1 y contenido alineados
- [ ] Afirmaciones verificables por sí solas (cifras con unidad, fecha y fuente enlazada); definiciones explícitas
- [ ] **Entidades claras**: nombre exacto de la empresa, productos, personas y lugares, siempre igual (y igual que en `Organization`/`sameAs`)
- [ ] Preguntas reales de clientes con respuesta visible (sección "Preguntas frecuentes" si aporta, no relleno)
- [ ] Experiencia propia (E-E-A-T): autor con bio y enlace, experiencia de primera mano, datos propios, política editorial; nada de contenido "commodity" ni generado en masa sin revisión
- [ ] Frescura: "Actualizado: <fecha>" visible + `dateModified`; revisa y corrige lo desactualizado
- [ ] Tablas y listas para comparaciones y pasos; texto (no solo imagen/video) para la información clave; transcripción en videos
- [ ] Nada oculto para bots, nada de instrucciones a modelos en el HTML (Bing lo trata como manipulación)
- [ ] Opcional: `/llms.txt` (propuesta comunitaria, v2 ago 2026; muy usada en docs técnicas). Google Search lo ignora (ni ayuda ni perjudica); útil para agentes y otros servicios. Solo si hay docs o contenido que agentes consulten.
## Rendimiento (p75, móvil)
- [ ] LCP ≤2,5 s · INP ≤200 ms · CLS ≤0,1 · imagen LCP con `fetchpriority="high"` y sin lazy
## Medición (fuera del repo, la hago yo)
- [ ] Search Console (incluye informe de IA generativa) y Bing Webmaster Tools verificados; sitemap enviado
- [ ] IndexNow al publicar/actualizar/borrar (clave en archivo en la raíz; Bing, Yandex y otros comparten las URLs)
Fuentes: https://developers.google.com/search/docs/fundamentals/ai-optimization-guide · https://developers.google.com/search/docs/appearance/ai-features · https://www.bing.com/webmasters/help/webmasters-guidelines-30fba23a · https://developers.google.com/search/docs/crawling-indexing/javascript/javascript-seo-basics · https://developers.google.com/search/docs/fundamentals/creating-helpful-content · https://llmstxt.org/ · https://www.indexnow.org/documentation · https://web.dev/articles/vitals · https://ogp.me/
