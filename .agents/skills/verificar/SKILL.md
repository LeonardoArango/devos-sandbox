---
name: verificar
description: Fase 7 del Personal Dev OS. Úsalo cuando el código de una tarea parece terminado, antes de decir "listo" o hacer commit. Exige evidencia fresca, corre los chequeos y un verificador independiente que intenta romper el resultado, y deja el veredicto en specs/<id>/verificacion/T<n>.md.
---
# Verificar
**Ley:** nada se declara hecho sin evidencia **de este turno**. Para cada afirmación: comando que la prueba → córrelo completo → lee salida y código → solo entonces afírmala. "Debería", "parece" = no verificado. En esta fase **no editas código**: si algo falla, lo reportas.
1. Chequeos baratos: tests, lint, tipos, build, gitleaks (el orquestador ya los corrió; repítelos solo si dudas).
2. Exige la prueba correcta ([verificador.md](verificador.md)): test de regresión = rojo sin el fix y verde con él; "el subagente terminó" = revisar su diff, no su reporte.
3. Subagente `verificador` (sin edición, contexto limpio) con Spec, tarea y diff (`git diff --cached`): "Intenta demostrar que algún CA NO se cumple o que se rompió algo de 'qué no debe cambiar'".
4. UI: Playwright **obligatorio** (`pruebas-usuario`): suite verde este turno, axe 0, capturas por ancho en `specs/<id>/capturas/`, luego `revision-ui`. Público: `e2e/seo.spec.ts` verde.
5. Escribe `specs/<id>/verificacion/T<n>.md`. **Primera línea exacta**: `VEREDICTO: APROBADO` o `VEREDICTO: RECHAZADO`. Luego tabla CA | veredicto | evidencia (comando + resultado) y, si rechazas, la lista exacta de qué corregir (archivo, CA, por qué). Un CA de la tarea sin evidencia ⇒ RECHAZADO.
