# Dotfiles

Configuración personal para macOS con stack de desarrollo React/TypeScript/Node.

## Contenido

```
dotfiles/
├── .zshrc                 # Configuración de Zsh
├── .zshenv                # Variables de entorno
├── .gitconfig             # Configuración de Git
├── .gitignore_global      # Gitignore global
├── .npmrc                 # Configuración de npm
├── .p10k.zsh              # Tema Powerlevel10k
├── Brewfile               # Paquetes de Homebrew
├── ssh/
│   └── config             # Configuración SSH
├── vscode/
│   └── settings.json      # Settings de VS Code
└── install.sh             # Script de instalación
```

## Instalación rápida

```bash
git clone https://github.com/reiorozco/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

## Qué instala

### CLI Tools
- **bat** - cat con syntax highlighting
- **eza** - ls moderno
- **fzf** - Fuzzy finder
- **zoxide** - Navegación inteligente
- **gh** - GitHub CLI

### Aplicaciones
- iTerm2, VS Code, Cursor
- OrbStack (Docker)
- Postman, Chrome
- Stats, Alt-Tab, LinearMouse

### Stack de desarrollo
- **Node.js** via Volta (version manager)
- **pnpm** como package manager
- **Oh My Zsh** + Powerlevel10k

## Post-instalación

1. Generar clave SSH:
   ```bash
   ssh-keygen -t ed25519 -C "tu@email.com"
   ```

2. Añadir clave a GitHub:
   ```bash
   gh auth login
   # o manualmente:
   cat ~/.ssh/id_ed25519.pub | pbcopy
   ```

3. Personalizar prompt (opcional):
   ```bash
   p10k configure
   ```

## Actualizar

```bash
cd ~/dotfiles
git pull
./install.sh
```

## Backup manual

Si modificas algo localmente:

```bash
cd ~/dotfiles
git add -A
git commit -m "Update configs"
git push
```
# GPG signing test: Fri Jan 16 00:03:09 -05 2026
