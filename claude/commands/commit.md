Genera un mensaje de commit basado en los cambios actuales.

## Pasos
1. Revisa `git diff --staged` o `git diff`
2. Analiza los cambios
3. Genera mensaje en formato Conventional Commits

## Formato
```
<tipo>(<scope>): <descripción>

<cuerpo opcional>
```

## Tipos
feat | fix | refactor | style | docs | test | chore

## Reglas
- Primera línea máximo 72 caracteres
- Imperativo ("add" no "added")
- Sin punto final

Si hay cambios no relacionados, sugiere dividir en commits.
