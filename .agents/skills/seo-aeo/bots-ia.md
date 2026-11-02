# Política de bots de IA en robots.txt (decisión humana)
Cada token se controla por separado. Distingue **búsqueda/cita** (te trae tráfico y menciones) de **entrenamiento** (no trae tráfico directo). Tokens verificados en la documentación de cada proveedor (nov 2026):
| Token | Para qué | Si lo bloqueas |
|---|---|---|
| `Googlebot` | Búsqueda de Google, incluidos AI Overviews y AI Mode | Desapareces de Google. **No bloquear.** |
| `Google-Extended` | Entrenamiento y grounding de Gemini Apps / Vertex AI (no Search) | No afecta Google Search ni ranking |
| `OAI-SearchBot` | Resultados de búsqueda en ChatGPT | No apareces citado en ChatGPT search |
| `GPTBot` | Entrenamiento de modelos de OpenAI | No afecta ChatGPT search |
| `ChatGPT-User` | Visitas pedidas por un usuario | Puede no respetar robots.txt (acción de usuario) |
| `Claude-SearchBot` | Calidad de búsqueda de Claude | Menos visibilidad en búsquedas de Claude |
| `ClaudeBot` | Entrenamiento de modelos de Anthropic | No afecta búsqueda |
| `Claude-User` | Visitas pedidas por usuarios de Claude | No te leen al responder preguntas |
| `PerplexityBot` | Indexar y enlazar en Perplexity (no entrena modelos) | No apareces en Perplexity |
| `Perplexity-User` | Visitas pedidas por usuarios | Suele ignorar robots.txt (acción de usuario) |
| `Bingbot` | Bing y Copilot (grounding y citas) | Desapareces de Bing/Copilot |
**Recomendación por defecto** (visibilidad sin regalar entrenamiento; confírmala): permitir buscadores (`Googlebot`, `Bingbot`, `OAI-SearchBot`, `Claude-SearchBot`, `PerplexityBot`) y decidir aparte `GPTBot`, `ClaudeBot`, `Google-Extended`.
```txt
User-agent: *
Allow: /
Disallow: /app/
Disallow: /api/

# Entrenamiento de IA: decisión del dueño (descomenta para bloquear)
# User-agent: GPTBot
# Disallow: /
# User-agent: ClaudeBot
# Disallow: /
# User-agent: Google-Extended
# Disallow: /

Sitemap: https://www.example.com/sitemap.xml
```
Notas: robots.txt controla rastreo, no indexación (para sacar una página del índice usa `noindex` y deja que la rastreen). Un WAF/CDN que bloquee bots anula esta política: revísalo. Google anunció soporte para la señal compartida AIPREF de preferencia de entrenamiento a inicios de 2027; vigílalo.
Fuentes: https://developers.google.com/crawling/docs/crawlers-fetchers/google-common-crawlers · https://platform.openai.com/docs/bots · https://support.claude.com/en/articles/8896518-does-anthropic-crawl-data-from-the-web-and-how-can-site-owners-block-the-crawler · https://docs.perplexity.ai/guides/bots · https://www.rfc-editor.org/rfc/rfc9309
