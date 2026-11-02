# Estados y microcopy
| Estado | Qué mostrar | Ejemplo de texto |
|---|---|---|
| Vacío (primera vez) | Qué es esto + por qué importa + 1 acción principal; mantiene el marco | "Aún no tienes facturas. Crea la primera y te avisamos cuando la paguen." [Crear factura] |
| Vacío (sin resultados) | Qué se buscó + cómo ampliar | "Sin resultados para «acme». Revisa la ortografía o quita filtros." [Quitar filtros] |
| Cargando | <300 ms nada; 0,3–2 s esqueleto con la forma real; >2 s progreso o texto; >10 s permite cancelar | "Generando reporte… puede tardar un minuto." |
| Parcial | Lo que sí cargó + aviso de lo que no | "No pudimos cargar 2 de 10 sucursales. [Reintentar]" |
| Error de validación | Junto al campo, qué pasó + cómo arreglar; foco al primer error | "El NIT debe tener 9 dígitos y el dígito de verificación." |
| Error de red/servidor | Sin culpar, sin código crudo; conserva lo escrito; reintento | "No pudimos guardar. Tus cambios siguen aquí. [Reintentar]" |
| Sin permiso | Por qué + a quién pedirlo | "Solo administradores pueden exportar. Pídeselo a tu administrador." |
| Éxito | Confirmación breve y próximo paso; toast que no tapa acciones; deshacer cuando sea posible | "Factura enviada a pagos@cliente.com. [Deshacer]" |
| Destructivo | Confirmación con el nombre del objeto y consecuencia; botón con el verbo | "¿Eliminar «Sucursal Norte»? Se borrarán 34 pantallas. [Eliminar sucursal]" |
| Sin conexión | Estado visible + qué funciona | "Sin conexión. Guardaremos cuando vuelva la red." |
## Reglas de texto
- Frases cortas, voz activa, sin jerga técnica ni mayúsculas sostenidas. Fechas, números y moneda en formato local (es-CO: 1.234.567,89; "1 nov 2026").
- Singular/plural correcto ("1 pantalla", "2 pantallas"); nunca "Error desconocido" sin salida.
- El mismo concepto se llama igual en todo el producto.
