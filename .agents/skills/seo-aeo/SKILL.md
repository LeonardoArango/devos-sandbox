---
name: seo-aeo
description: Obligatorio al crear o cambiar un sitio, landing, blog, docs o cualquier página pública indexable (no paneles tras login). Úsalo también cuando pida SEO, posicionamiento, Google, "aparecer en ChatGPT/Perplexity/AI Overviews", AEO o GEO. Cubre SEO técnico, datos estructurados, Core Web Vitals, contenido citable y pruebas automáticas con Playwright.
---
# SEO + AEO (búsqueda clásica y con IA)
**Principio verificado:** para Google, AEO/GEO *sigue siendo SEO*. No hay archivo, marcado ni "chunking" especial para AI Overviews/AI Mode. Bing/Copilot piden lo mismo y premian contenido claro, verificable y con la respuesta arriba. Nada de trucos: contenido útil y propio + técnica limpia.
1. **Alcance**: lista las páginas públicas (indexables) y las privadas (`noindex` o tras login). Va en la Spec, sección 6.2.
2. **Renderizado**: las páginas indexables entregan el contenido principal en el HTML inicial (SSR/SSG o prerender). Rutas con History API, nada de `#/`. 404 real con estado 404.
3. **Por página**: `<title>` único (~50–60 car.), meta description única, `<link rel=canonical>` absoluta (una sola), `lang`, un `h1`, encabezados en orden, Open Graph + Twitter card, URLs limpias en minúsculas con guiones.
4. **Sitio**: `robots.txt` (con la **decisión de bots de IA** de [bots-ia.md](bots-ia.md), que tomo yo), `sitemap.xml` con solo canónicas y `lastmod` real, favicon ≥48 px + manifest, redirecciones 301, `hreflang` recíproco si hay varios idiomas.
5. **Datos estructurados** JSON-LD que coincidan con lo visible: [datos-estructurados.md](datos-estructurados.md). No marques lo que no se ve.
6. **Rendimiento**: LCP ≤2,5 s, INP ≤200 ms, CLS ≤0,1 (p75); imágenes con `alt`, tamaño y formato moderno (`diseno-ui/tokens-diseno.md`).
7. **Contenido citable (AEO)** con [checklist.md](checklist.md): respuesta directa al inicio, preguntas reales con respuesta visible, entidades nombradas igual en todo el sitio, autor y fechas visibles, fuentes enlazadas, enlaces internos descriptivos. Nada de texto escondido ni dirigido a bots (cloaking / inyección = penalización).
8. **Pruebas obligatorias**: `e2e/seo.spec.ts` desde [pruebas-seo.md](pruebas-seo.md) (meta, canonical, JSON-LD válido, robots/sitemap, un h1, lang). Corre con `DEVOS_E2E_CMD`; el hook Stop exige el archivo si el sitio es público. Lighthouse SEO local opcional (umbral en la Spec).
9. **Fuera del repo** (te lo dejo como pasos, no lo hago): Search Console + Bing Webmaster Tools, enviar sitemap, IndexNow, Business Profile/Merchant Center si aplica.
