Realiza un code review de los cambios actuales de la rama.

## Contexto
1. Detecta la rama base (busca `dev`, `develop`, `main` o `master` en ese orden)
2. Ejecuta `git diff <rama-base>...HEAD` para ver todos los cambios
3. Si no hay cambios contra la rama base, revisa el código proporcionado por el usuario

## Analiza
- **Bugs**: Edge cases, errores de lógica, null/undefined
- **Seguridad**: Validación de inputs, exposición de datos, inyecciones
- **Performance**: Operaciones costosas, memory leaks, N+1 queries
- **Code smells**: Código duplicado, funciones muy largas, acoplamiento
- **Estilo**: Inconsistencias con el resto del código

## Output
Si todo está bien, responde brevemente que no hay issues.

Si hay problemas, lista cada uno con:
- **Severidad**: 🔴 Alta | 🟡 Media | 🟢 Baja
- **Archivo y línea**
- **Descripción del problema**
- **Sugerencia de fix**
