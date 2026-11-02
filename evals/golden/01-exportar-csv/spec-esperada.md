---
id: 001-exportar-csv
titulo: "Exportar transacciones del mes a CSV"
camino: lite
estado: aprobada
version: 0.1
issue: https://github.com/<owner>/<repo>/issues/<n>
gates: { B-lite: <fecha>, D: , E: }
---
# Exportar transacciones del mes a CSV

## 1. Problema y contexto
Para cuadrar mis cuentas copio a mano las transacciones del mes a una hoja de cálculo. App de un solo usuario (yo). Volumen por mes: [PENDIENTE] (consultar la base).

## 4. Alcance, fuera de alcance y qué NO debe cambiar
- Dentro: botón "Exportar CSV" en la vista mensual; columnas fecha (AAAA-MM-DD), descripción, categoría, monto (punto decimal), cuenta; separador `;`, UTF-8 con BOM; mes en hora America/Bogota.
- Fuera: otros formatos (Excel, PDF), rangos personalizados, importación.
- No debe cambiar: esquema de la base, vista mensual actual, totales mostrados, dependencias.

## 7. Criterios de aceptación con evidencia
| CA | Dado / Cuando / Entonces | Cómo se verifica | Evidencia |
|---|---|---|---|
| CA1 | Dado un mes con transacciones, cuando exporto, entonces el CSV tiene una fila por transacción y las columnas en el orden definido | test de integración con 3 transacciones sintéticas | |
| CA2 | Dada una transacción a las 23:30 (America/Bogota) del último día, cuando exporto ese mes, entonces aparece en ese mes | test unitario de límites de fecha | |
| CA3 | Dado un mes sin transacciones, cuando exporto, entonces descargo un CSV solo con encabezados | test de integración | |
| CA4 | Dada una descripción que empieza con `=`, cuando exporto, entonces la celda queda escapada (prefijo `'`) | test unitario | |
| CA5 | Dado el archivo descargado, cuando lo abro en Excel en español, entonces se ven tildes y columnas separadas | captura manual | |

## 9. Acciones que requieren mi aprobación
Ninguna prevista. Si hace falta una librería CSV o tocar el esquema: parar y pasar a camino completo.
