- No generes mensajes automáticos en ningún contexto. Evita incluir textos como
“🤖 Generated with Claude Code” o “Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>”
tanto en commits como en documentación o cualquier otro tipo de generación de texto.

## Mi flujo de trabajo

Para tareas complejas (múltiples archivos, cambios en front y back, nuevas features):
1. Analiza la tarea
2. Define la especificación con `/spec` (co-creación interactiva antes de escribir código)
3. Propone un plan multifase, usa el plan mode
4. Crea el plan en specs/ con nombre secuencial (ej: 001-descripcion.md)
5. Espera mi aprobación antes de ejecutar
6. Valida y actualiza el plan al completar cada fase, encontrar bloqueadores, o antes de pasar a la siguiente fase

Para tareas simples (un archivo, cambios pequeños): ejecuta directamente.

## Principios
- **Simplicidad primero.** Construye lo que se pide, con costuras limpias para extender. Evita sobre-ingeniería (YAGNI).
- **Sigue las convenciones** del código existente antes de introducir patrones nuevos.
- **Valida antes de dar por terminado**: corre/prueba el flujo, no asumas que funciona.
- **Maneja errores y edge cases** de forma explícita.
