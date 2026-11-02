---
name: ux-flujos
description: Úsalo al diseñar o cambiar un flujo de usuario, formulario, onboarding, o cualquier pantalla con datos que pueden faltar, tardar o fallar. Define el recorrido, todos los estados (vacío, cargando, error, éxito) y los textos en español antes de codificar.
---
# Flujos y experiencia de usuario
1. **Trabajo a resolver**: "Cuando <situación>, quiero <acción>, para <resultado>". Una tarea principal por pantalla.
2. **Recorrido** en pasos numerados: entrada (de dónde llega) → pasos → salida (a dónde va). Cuenta clics y campos; quita todo paso que no aporte (mínimo viable, ver `challenge`).
3. **Matriz de estados** por pantalla/componente con [estados-y-microcopy.md](estados-y-microcopy.md): inicial, vacío (primera vez / sin resultados / limpiado), cargando, parcial, error (red, validación, permiso, servidor), éxito, sin conexión. Cada uno con texto y siguiente acción.
4. **Formularios**: [formularios.md](formularios.md).
5. **Heurísticas** mientras diseñas: estado visible del sistema, lenguaje del usuario, control y deshacer, consistencia, prevenir errores antes que mensajes, reconocer mejor que recordar, atajos para expertos, minimalismo, errores que explican y ayudan a salir, ayuda en contexto.
6. **Accesible desde el diseño**: orden de foco lógico, todo operable con teclado, nombres accesibles, anuncios de cambios (`aria-live`) para carga/errores/éxito.
7. Escribe flujo y matriz en la Spec (sección 6.1). Cada flujo y cada estado se vuelve un test en `pruebas-usuario`.
8. Lenguaje: español claro, tú/usted según el producto (decídelo una vez en DESIGN.md), verbos en botones ("Guardar cambios", no "OK").
