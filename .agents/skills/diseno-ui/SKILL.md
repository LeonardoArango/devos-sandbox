---
name: diseno-ui
description: Úsalo antes de crear o rediseñar cualquier pantalla, página o componente visual (web o app), y cuando algo "se ve genérico" o "de IA". Fija dirección visual, tokens de diseño (tipografía, color, espacio, movimiento) y reglas anti-genérico en DESIGN.md antes de escribir UI.
---
# Dirección de diseño UI
1. **Fuente de verdad visual**: busca `DESIGN.md`, tokens o componentes existentes. Si existen, **respétalos** (refinar conserva identidad; rediseñar solo con mi OK). Si no hay, crea `DESIGN.md` en la raíz con [plantilla-DESIGN.md](plantilla-DESIGN.md) y muéstramelo antes de codificar.
2. **Modo de la pantalla** (decide cuánta expresión): *Persuadir* (landing, precios: audaz, una idea fuerte), *Operar* (app, panel, formularios: precisión y sobriedad), *Leer* (docs: legibilidad), *Exhibir* (portafolio: la obra manda). El modo sale de la pantalla, no de la marca.
3. **Dirección en 5 líneas**: referencia real (no inventada), 1 tipografía (máx. 2), 1 fondo + 1 tinta + 1 acento, densidad (amplia/estándar/densa), qué la hace distinta. Si me das un brief, el brief manda.
4. **Tokens** con [tokens-diseno.md](tokens-diseno.md): escala tipográfica, rejilla de espacio, colores semánticos con contraste verificado (texto ≥4.5:1, UI ≥3:1). En componentes, solo tokens; nunca hex sueltos.
5. **Anti-genérico**: antes de entregar, pasa [anti-slop.md](anti-slop.md). Pantallas de app/paneles: además [pantallas-app.md](pantallas-app.md). Animación: [movimiento.md](movimiento.md).
6. Móvil primero (360 px), luego 768 y 1280+. Sin scroll horizontal, sin bloquear zoom.
7. Mira el resultado **renderizado**, no el código: capturas con Playwright (`pruebas-usuario`) y crítica con `revision-ui`. Junta los arreglos de una mirada antes de volver a capturar.
8. **Skills vendorizadas** (no se cargan solas; léelas solo en su caso, una a la vez): dirección de arte para landing/página pública sin `DESIGN.md` → `taste` (`.agents/skills/taste/SKILL.md`, ~9k tokens); construir o rehacer animación → `emil-animate` (y `emil-design-eng` para pulido fino de componentes). Si contradicen `DESIGN.md`, la Spec o este kit, ganan estos.
9. Si faltan datos de marca, dilo y usa valores por defecto declarados; nunca inventes logos, testimonios ni cifras.
