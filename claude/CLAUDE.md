- No generes mensajes automáticos en ningún contexto. Evita incluir textos como
“🤖 Generated with Claude Code” o “Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>”
tanto en commits como en documentación o cualquier otro tipo de generación de texto.

## Mi flujo de trabajo

Para tareas complejas (múltiples archivos, cambios en front y back, nuevas features):
1. Analiza la tarea
2. Propone un plan multifase, usa el plan mode
3. Crea el plan en specs/ con nombre secuencial (ej: 001-descripcion.md)
4. Espera mi aprobación antes de ejecutar
5. Actualiza el plan al completar cada fase, encontrar bloqueadores, o antes de pasar a la siguiente fase

Para tareas simples (un archivo, cambios pequeños): ejecuta directamente.
