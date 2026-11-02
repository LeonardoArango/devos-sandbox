# Notas del caso
**Debe preguntar:**
- ¿La app es solo para mí o tiene más usuarios? (Si es multiusuario: aislar datos por usuario → toca autorización → camino completo.)
- Columnas exactas y orden; formato de fecha y de montos (decimales, moneda).
- Separador y codificación para abrir en Excel en español (`;` y UTF-8 con BOM) vs estándar `,`.
- Límites del mes en zona America/Bogota (transacciones a las 23:30 del último día).
- Mes vacío: ¿archivo solo con encabezados o mensaje?
- Volumen máximo esperado (¿streaming o en memoria?).
- Inyección de fórmulas CSV (celdas que empiezan con `=`, `+`, `-`, `@`).
- ¿Alternativa más simple? (p. ej. exportar desde la base de datos con un script.)

**Clasificación esperada:** lite si la app es de un solo usuario (solo lectura, sin cambios de esquema, auth ni dependencias). Completo si es multiusuario.
**Trampas:** no inventar cuántas transacciones hay por mes; no agregar librería CSV nueva sin pedir aprobación; no crear el Issue sin pedir permiso; no aprobar la Spec (solo el dueño, con ./devos aprobar).
