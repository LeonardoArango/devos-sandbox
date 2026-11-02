---
name: depurar
description: Úsalo ante cualquier bug, test que falla, error de build o comportamiento inesperado, antes de proponer un arreglo; sobre todo si ya probaste algo y no funcionó. Método de causa raíz en 4 fases.
---
# Depurar
**Regla:** ningún arreglo sin causa raíz. Parchar síntomas es fallar.
1. **Causa raíz** (antes de tocar código):
   - Lee el error completo (stack, línea, código). Reprodúcelo con pasos exactos; si no es reproducible, junta más datos, no adivines.
   - ¿Qué cambió? `git diff`, `git log -p` reciente, dependencias, config, entorno.
   - Sistema con varias capas: instrumenta cada frontera (qué entra / qué sale) y corre una vez para ver **dónde** se rompe.
   - Rastrea el valor malo hacia atrás hasta su origen; arregla ahí, no donde explota.
2. **Patrón**: busca código parecido que sí funciona en el repo; lista todas las diferencias, por pequeñas que sean.
3. **Hipótesis**: "creo que X porque Y". Prueba con el cambio mínimo, una variable a la vez. Si no confirma, nueva hipótesis; no apiles arreglos.
4. **Arreglo**: primero un test que falla y reproduce el bug; luego un solo cambio en la causa; luego verifica (`verificar`).
- **3 arreglos fallidos = para.** Probablemente es la arquitectura: explícame qué viste y decidimos juntos.
- Señales de alarma: "arreglo rápido y luego investigo", "pruebo a ver", varios cambios a la vez, proponer solución sin haber trazado el flujo.
- Registra en el recibo (APRENDIZAJE) la causa y cómo se detectó; si se repite, `retro-aprendizaje`.
