---
description: Define una especificación spec-driven (interactiva) a partir de una historia de usuario o brief, antes de escribir código.
---

Define una especificación (spec-driven) a partir de una historia de usuario o brief, de forma interactiva, antes de escribir código.

## Reglas
- No escribas código. Solo produces la spec.
- Responde en el idioma del brief/historia.
- Equilibrio de detalle: lo justo para que la IA no invente lógica ni tome decisiones de producto arbitrarias, sin sobre-especificar y matar la velocidad.
- Describe reglas de negocio, flujos y resultados esperados — no funciones ni tablas.

## Pasos
1. Lee el contexto (historia/brief) y redacta una spec base rellenando huecos con supuestos razonables.
2. Expón tus supuestos: lista numerada de los supuestos **funcionales/de producto** (alcance, UX, comportamiento, datos, edge cases) — no detalles técnicos. Solo los que cambiarían el producto si están mal (5–8, más impactantes primero). Pídeme los números que quiero cambiar (o "ninguno").
3. Refina, una pregunta a la vez. Por cada supuesto marcado:
   - Barra de progreso: `[Pregunta X de Y]  ███░░`
   - 4 opciones concretas (1–4) + `5. Otra` (si la elijo, pídeme que especifique).
   Espera mi respuesta antes de la siguiente.
4. Confirma: "Listo para crear la especificación." Con mi visto bueno, escribe la spec.

## Formato de la spec  →  `specs/NNN-<slug>.md`
- Objetivo
- Historias de usuario
- Flujos: happy path y sad path (errores, edge cases)
- Escenarios clave en formato Dado / Cuando / Entonces (Gherkin)
- Requisitos funcionales
- Decisiones clave (los supuestos resueltos)
- Fuera de alcance (lo que explícitamente NO se construye)
- Criterios de aceptación

Mantenla concisa — legible en dos minutos.
