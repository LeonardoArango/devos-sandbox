# Movimiento y microinteracciones
1. **¿Debe animarse?** Según frecuencia: acciones de teclado o 100+ veces/día → nada; decenas/día (hover, listas) → mínimo; ocasional (modal, drawer, toast) → estándar; raro (onboarding, celebración) → puede deleitar.
2. **¿Para qué?** Continuidad espacial, indicar cambio de estado, explicar, confirmar (botón que cede al presionar) o evitar saltos bruscos. "Se ve bonito" en algo frecuente = no.
3. **Curva**: entrar/salir → ease-out fuerte (p. ej. `cubic-bezier(0.23,1,0.32,1)`); mover en pantalla → ease-in-out; color/hover → ease. Evita ease-in en UI (se siente lento).
4. **Duración**: presión de botón 100–160 ms · tooltip 125–200 · menú 150–250 · modal/drawer 200–400. Regla: UI <300 ms.
5. **Técnica**: anima solo `transform` y `opacity` (nunca width/height/top); nada aparece desde `scale(0)` (usa 0.95 + opacidad); popovers escalan desde su disparador; transiciones interrumpibles (CSS transitions mejor que keyframes para UI); `:active` con `scale(0.97)` en botones.
6. **Accesibilidad**: `prefers-reduced-motion: reduce` → sin desplazamientos, solo fundidos cortos o nada. Nada parpadea más de 3 veces por segundo.
7. Revisión en tabla **Antes | Después | Por qué**.
