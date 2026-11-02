# Tokens de diseño
Defínelos una vez (CSS variables, theme de Tailwind o equivalente del stack) y úsalos por nombre semántico (`--color-error`, no `--rojo-500`).

## Tipografía
- Base 16 px (cuerpo 16–18; nunca <12 en ningún texto). Interlineado cuerpo 1.4–1.6; títulos grandes 1.0–1.15 con tracking levemente negativo.
- Escala modular corta (p. ej. 12 · 14 · 16 · 20 · 24 · 32 · 48). En una pantalla se **ven** 2–3 tamaños; máx. 5.
- Jerarquía con tamaño **y** peso **y** color (tinta vs. tinta suave), no solo tamaño. Medida de línea 45–75 caracteres. Alineado a la izquierda.
- Números en tablas/KPIs: cifras tabulares (`font-variant-numeric: tabular-nums`).

## Espacio y layout
- Rejilla base 4 u 8 px; escala 4 · 8 · 12 · 16 · 24 · 32 · 48 · 64 · 96. Densidad: amplia 24–96, estándar 16–64, densa 8–32.
- Más espacio **entre** grupos que **dentro** de ellos (proximidad = relación). Márgenes exteriores iguales (16 móvil, 24–32 escritorio).
- Pocos bordes izquierdos de alineación (2–3 por pantalla). Ancho máx. de contenido de lectura ~70ch.

## Color
- 1 fondo, 1 tinta, 1 acento (en la acción principal), + semánticos (éxito/aviso/error/info). Separa superficies por un paso de tono, no por cajas con borde.
- Contraste WCAG 2.2 AA: texto normal ≥4.5:1, texto grande (≥24 px o 18.7 px negrita) ≥3:1, bordes de controles e iconos con significado ≥3:1. Mídelo (axe en `pruebas-usuario`, o calculadora), no a ojo.
- El color nunca es el único portador de significado: añade icono, texto o patrón.
- Modo oscuro: tokens propios (no invertir); evita negro puro y blanco puro en grandes áreas.

## Forma y profundidad
- 1–2 radios en todo el producto. Sombra solo en lo que flota (menús, diálogos, toasts). Foco visible siempre (`:focus-visible`, contraste ≥3:1).

## Táctil y responsive
- Objetivos táctiles ≥44×44 px (mínimo AA 24×24) con ≥8 px de separación. No depender de hover.
- Breakpoints por contenido, verificando 360 · 768 · 1280 · 1440. `meta viewport` sin bloquear zoom.

## Rendimiento visual (Core Web Vitals, p75)
- LCP ≤2,5 s · INP ≤200 ms · CLS ≤0,1. Reserva espacio a imágenes y anuncios (width/height o aspect-ratio), WebP/AVIF, `loading="lazy"` bajo el pliegue, fuentes con `font-display: swap` y precarga solo de la principal.
