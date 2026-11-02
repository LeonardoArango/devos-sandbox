# Checklist de revisión (✓/✗/N.A.)
## Heurísticas (Nielsen)
- [ ] Estado del sistema visible (carga, guardado, selección) · [ ] Lenguaje del usuario, no del sistema
- [ ] Salida y deshacer claros · [ ] Consistente con el resto del producto y con convenciones de la plataforma
- [ ] Previene errores (confirmaciones, límites, valores por defecto) · [ ] Opciones visibles, no memorizadas
- [ ] Atajos o acciones masivas si el uso es frecuente · [ ] Sin información irrelevante
- [ ] Errores en lenguaje claro con solución · [ ] Ayuda contextual donde se duda
## WCAG 2.2 AA (lo más frecuente)
- [ ] Contraste texto ≥4.5:1 (grande ≥3:1); controles, foco e iconos con significado ≥3:1 (1.4.3, 1.4.11)
- [ ] Todo operable con teclado, sin trampas, orden lógico (2.1.1, 2.1.2, 2.4.3) · [ ] Foco visible y **no tapado** por barras fijas (2.4.7, 2.4.11)
- [ ] Nombres accesibles: imágenes con `alt`, botones-icono con `aria-label`, campos con etiqueta (1.1.1, 4.1.2, 3.3.2)
- [ ] Encabezados y landmarks correctos; `lang="es"` (1.3.1, 3.1.1) · [ ] Color no es el único medio (1.4.1)
- [ ] Objetivos ≥24×24 px o con espacio suficiente (2.5.8); recomendado 44 · [ ] Arrastrar tiene alternativa de un clic (2.5.7)
- [ ] Zoom 200 % y ancho 320 px sin pérdida ni scroll horizontal (1.4.4, 1.4.10) · [ ] Errores identificados y con sugerencia (3.3.1, 3.3.3)
- [ ] Sin pedir dos veces lo mismo en un proceso (3.3.7) · [ ] Login sin pruebas cognitivas; permite pegar y gestores (3.3.8)
- [ ] Mensajes de estado anunciados (`aria-live`) (4.1.3) · [ ] Movimiento respeta `prefers-reduced-motion`
## Responsive y estados
- [ ] 360 · 768 · 1280/1440 sin cortes, solapes ni texto <12 px · [ ] Táctil ≥44 px, sin depender de hover
- [ ] Vacío, cargando, error, éxito, sin permiso implementados y con texto de `ux-flujos`
- [ ] Datos extremos no rompen el layout
## Movimiento (criterios adaptados de Emil Kowalski, MIT; detalle: `/emil-review-animations`)
- [ ] ¿Debe animarse? Lo que se usa cientos de veces al día y todo lo iniciado por teclado (atajos, paleta de comandos): sin animación
- [ ] Curva según intención: entrar/salir `ease-out`, mover en pantalla `ease-in-out`, color/hover `ease`, progreso continuo `linear`; nunca `ease-in` en UI
- [ ] Duración corta: UI <300 ms (presionar 100–160, menús 150–250; modales/cajones hasta ~500); salidas más rápidas que entradas; escalonado 30–80 ms sin bloquear · [ ] Nada aparece desde `scale(0)`: parte de ~0.95 + opacidad
- [ ] Popovers y menús escalan desde su disparador (`transform-origin`), no desde el centro · [ ] Botón con respuesta al presionar (`:active` sutil)
- [ ] Solo `transform` y `opacity` (no `width/height/top/margin`) · [ ] Interrumpible: un clic a mitad de animación no la reinicia ni salta
- [ ] `prefers-reduced-motion`: se reduce a fundidos o nada · [ ] Revisado en cámara lenta (DevTools ×2–5) y en dispositivo real si hay gestos
## Rendimiento
- [ ] Sin saltos de layout (CLS ≤0,1), imágenes con tamaño reservado y formato moderno · [ ] Interacción responde rápido (INP ≤200 ms) · [ ] LCP ≤2,5 s en el entorno de prueba
- [ ] Consola sin errores ni advertencias nuevas durante la prueba
Referencias: https://www.nngroup.com/articles/ten-usability-heuristics/ · https://www.w3.org/WAI/WCAG22/quickref/ · https://web.dev/articles/vitals
