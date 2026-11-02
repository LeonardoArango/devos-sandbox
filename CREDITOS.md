# Créditos y licencias
Todo el texto propio del kit está escrito con nuestras palabras. La única copia literal son las tres skills **vendorizadas** de abajo (con su licencia y aprobación expresa). De los proyectos MIT/Apache se **adaptaron ideas**; la licencia se conserva aquí como atribución. Licencias revisadas en GitHub el 1 nov 2026.

## Ideas adaptadas (MIT)
| Proyecto | Qué tomamos (como idea) | Dónde |
|---|---|---|
| https://github.com/mattpocock/skills | Entrevista por rondas sobre la "frontera" de decisiones, con respuesta recomendada | `challenge` |
| https://github.com/obra/superpowers | Verificar antes de declarar hecho, planes sin "TBD", depuración por causa raíz | `verificar`, `plan`, `depurar` |
| https://github.com/addyosmani/agent-skills | Skills de ingeniería con evidencia y anti-excusas | `verificar`, `crear-skill` |
| https://github.com/DietrichGebert/ponytail | Escalera YAGNI ("¿hace falta? ¿ya existe? ¿lo da la plataforma?") | `challenge/duda.md` |
| https://github.com/nextlevelbuilder/ui-ux-pro-max-skill | Elegir estilo por tipo de producto; checklist UI/UX | `diseno-ui`, `revision-ui` |
| https://github.com/Leonxlnx/taste-skill | Dirección de arte con referencias reales y revisión en navegador contra lo "genérico de IA"; medidas del inspector como asserts propios | `diseno-ui/anti-slop.md`, `pruebas-usuario/plantilla-e2e.md` (`medidas.spec.ts`) |
| https://github.com/VoltAgent/awesome-design-md | `DESIGN.md` como fuente visual del proyecto | `diseno-ui/plantilla-DESIGN.md` |
| https://github.com/emilkowalski/skills | Criterios de animación: frecuencia, propósito, curvas, duraciones | `diseno-ui/movimiento.md`, `revision-ui/checklist.md` (Movimiento) |

## Vendorizado (copia completa, fijada; aprobado por Leonardo el 2026-11-01)
Detalle, cambios y riesgos: `.agents/skills/vendor/VENDORED.md`. Cada carpeta conserva su `LICENSE` (y `NOTICE.md` en Apache).
| Proyecto | Commit | Fecha del commit (Bogotá) | Licencia | Carpeta |
|---|---|---|---|---|
| https://github.com/emilkowalski/skills | `a81dbca07f2217b7103e510c0f13f8d5b017afc9` | 2026-10-28 | MIT · © Emil Kowalski | `.agents/skills/vendor/emil-kowalski/` |
| https://github.com/pbakaus/impeccable | `e89e3ada3e875a89ac2c5d33d11e65ebef6fe285` | 2026-11-01 | Apache-2.0 · Paul Bakaus (modificado: sin `scripts/` ni hooks) | `.agents/skills/vendor/impeccable/` |
| https://github.com/Leonxlnx/taste-skill | `12af471f627f866411b4bd785b19646d3672784c` | 2026-10-24 | MIT · Leonxlnx (modificado: sin `assets.mjs`) | `.agents/skills/vendor/taste/` |

## Ideas adaptadas (Apache-2.0)
| Proyecto | Qué tomamos | Dónde |
|---|---|---|
| https://github.com/JuliusBrussee/caveman | Respuestas cortas sin perder trabajo (estilo, no su proxy) | `tokens.md`, `.claude/output-styles/conciso.md` |
| https://github.com/pbakaus/impeccable | Crítica visual con vocabulario de diseño y priorización | `revision-ui/critica-visual.md` |
| https://github.com/Graphify-Labs/graphify | Solo como referencia: mapa consultable del código. **No incluido** (dependencia y riesgo innecesarios para repos personales) | `PATRONES.md` |
| https://github.com/microsoft/playwright · https://github.com/microsoft/playwright-mcp · https://github.com/microsoft/playwright-cli | Pruebas de usuario, MCP de exploración, alternativa CLI | `pruebas-usuario`, `.mcp.json` |
| https://github.com/GoogleChrome/lighthouse | Umbral SEO/accesibilidad local opcional | `seo-aeo/pruebas-seo.md` |

## Herramienta referenciada (MPL-2.0)
- https://github.com/dequelabs/axe-core-npm (`@axe-core/playwright`): se usa como dependencia del proyecto, no se copia.

## Parafraseado, sin licencia publicada (no copiar nunca)
- https://github.com/multica-ai/andrej-karpathy-skills: principios generales (pensar antes, simplicidad, cambios quirúrgicos, metas verificables) reescritos en `AGENTS.md`.
- https://github.com/anthropics/skills: el formato de skills es estándar; ningún archivo copiado.

## Documentación de referencia (SEO/AEO)
Google Search Central (https://developers.google.com/search/docs/fundamentals/ai-optimization-guide, https://developers.google.com/search/docs/appearance/ai-features, https://developers.google.com/search/updates) · Bing (https://www.bing.com/webmasters/help/webmasters-guidelines-30fba23a) · https://web.dev/articles/vitals · https://llmstxt.org/ · https://www.indexnow.org/documentation · https://platform.openai.com/docs/bots · https://docs.perplexity.ai/guides/bots · https://support.claude.com/en/articles/8896518-does-anthropic-crawl-data-from-the-web-and-how-can-site-owners-block-the-crawler · https://schema.org/
