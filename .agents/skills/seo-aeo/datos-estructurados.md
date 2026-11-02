# Datos estructurados (JSON-LD)
Reglas: JSON-LD en `<script type="application/ld+json">`, preferiblemente en el HTML inicial; describe **solo lo visible** en la página; un grafo coherente con `@id` (`https://www.example.com/#org`). No es requisito para la búsqueda con IA, pero ayuda a resultados enriquecidos y a dejar claras las entidades. Valida con el Rich Results Test y el Schema Markup Validator (los abro yo; no automatizar llamadas externas).
| Tipo | Dónde | Estado en Google (nov 2026) |
|---|---|---|
| `Organization` (+ `logo`, `sameAs`, `contactPoint`) | Inicio o "Nosotros" | Vigente: logo y panel de la marca |
| `WebSite` (`name`, `alternateName`, `url`) | Inicio | Vigente: nombre del sitio en resultados (la caja de búsqueda ya no existe) |
| `BreadcrumbList` | Páginas internas con migas visibles | Vigente, se muestra solo en escritorio |
| `Product` + `Offer` (+ `aggregateRating` solo con reseñas reales) | Ficha de producto | Vigente (merchant listing / snippet) |
| `Article`/`BlogPosting` (`author` con `url`, `datePublished`, `dateModified`) | Blog, noticias, guías | Vigente; ayuda a autoría y fechas |
| `LocalBusiness` | Negocio físico | Vigente; complementa Business Profile |
| `FAQPage` | Solo si la página ES una FAQ visible | El resultado enriquecido FAQ se retiró en mayo 2026: úsalo por claridad semántica, no esperes rich result |
| `HowTo` | — | Resultado enriquecido retirado (2023): no lo agregues por SEO |
## Plantilla mínima (inicio)
```html
<script type="application/ld+json">
{"@context":"https://schema.org","@graph":[
 {"@type":"Organization","@id":"https://www.example.com/#org","name":"Ejemplo S.A.S.","url":"https://www.example.com/",
  "logo":"https://www.example.com/logo.png","sameAs":["https://www.linkedin.com/company/ejemplo"]},
 {"@type":"WebSite","@id":"https://www.example.com/#web","name":"Ejemplo","url":"https://www.example.com/","publisher":{"@id":"https://www.example.com/#org"}}
]}
</script>
```
## Migas (página interna)
```json
{"@context":"https://schema.org","@type":"BreadcrumbList","itemListElement":[
 {"@type":"ListItem","position":1,"name":"Productos","item":"https://www.example.com/productos"},
 {"@type":"ListItem","position":2,"name":"Pantalla 55\""}]}
```
Fuentes: https://developers.google.com/search/docs/appearance/structured-data/intro-structured-data · https://developers.google.com/search/docs/appearance/structured-data/sd-policies · https://developers.google.com/search/updates · https://schema.org/Organization
