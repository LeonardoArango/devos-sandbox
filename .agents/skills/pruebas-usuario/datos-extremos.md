# Datos extremos realistas (no basura)
Entran por el mismo borde que los datos de demo (fixture, mock, `page.route`), nunca editando el HTML. Usa dominios `example.com`.
- **Nombres**: `María José de la Cruz y Fernández`, `Aleksandra Wiśniewska-Kowalczyk`, `Jo`, `王秀英`, `نور الهدى` (RTL), `🦊 Fox` (emoji al inicio), espacios dobles, nombre faltante.
- **Correos/URL/IDs**: `bartolome.fitzgerald@industrias-del-norte-holding.example.com` (sin espacios para cortar), `a@b.co`, `ana+facturas@example.com`, UUID, nombre de archivo largo con versión al final.
- **Textos**: título vacío o solo espacios, 2.000 caracteres pegados, salto de línea en campo de una línea, `<script>alert(1)</script>` (debe verse literal), etiquetas en alemán/francés (~30 % más largas).
- **Números**: 0, 1 ("1 pantalla", no "1 pantallas"), 1.284, 1.000.000, negativos, decimales es-CO, moneda COP sin decimales.
- **Colecciones**: 0, 1, exactamente el tamaño de página, página+1, 500 elementos, 12 etiquetas en un ítem.
- **Tiempo**: ahora, hace 59 s, ayer, el 29 feb, otra zona horaria, fecha futura.
- **Media y estados**: imagen faltante o rota, avatar sin foto, permiso denegado, sesión expirada.
Límites: tómalos del esquema de validación, la BD o la API; si no hay límite, es un hallazgo ("sin límite").
