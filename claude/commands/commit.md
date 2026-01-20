Genera los commits necesarios basándote en los cambios actuales.

## Pasos
1. Revisa `git status` y `git diff`
2. Agrupa cambios por propósito/contexto
3. Si hay cambios no relacionados, divídelos en commits separados
4. Genera cada commit en formato Conventional Commits

## Formato
```
<tipo>(<scope>): <descripción>

<cuerpo opcional>
```

## Tipos
feat | fix | refactor | style | docs | test | chore | perf | build

## Reglas
- Cada commit debe ser conciso, coherente y con propósito claro
- Primera línea máximo 72 caracteres
- Imperativo ("add" no "added")
- Sin punto final
- Un commit = un cambio lógico

## Ejecución
- Presenta los commits propuestos antes de ejecutar
- Espera confirmación para proceder
