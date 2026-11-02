# Formularios
- Etiqueta visible arriba del campo (el placeholder no es etiqueta); ayuda breve debajo; marca lo **opcional**, no lo obligatorio, si casi todo es obligatorio.
- Pide lo mínimo; agrupa en secciones; divulgación progresiva para lo avanzado. Una columna.
- Tipo de entrada correcto (`type=email|tel|number`, `inputmode`, `autocomplete`) para el teclado móvil y el autollenado.
- Valida al salir del campo (no mientras escribe), y otra vez al enviar; mensaje junto al campo con `aria-describedby`; resumen arriba si hay varios errores y foco al primero.
- No borres lo escrito ante un error. Botón de enviar siempre habilitado (explica qué falta), con estado "Guardando…" y protección contra doble envío.
- Contraseñas: mostrar/ocultar, reglas visibles antes de escribir, permitir pegar y gestores de contraseñas.
- Objetivos táctiles ≥44 px; etiquetas clicables; orden de tabulación natural.
