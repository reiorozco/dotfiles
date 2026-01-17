# Dotfiles

Configuración personal para **macOS** y **Windows** con stack de desarrollo React/TypeScript/Node.

## Contenido

```
dotfiles/
├── .zshrc                 # Configuración de Zsh (macOS)
├── .zshenv                # Variables de entorno (Volta)
├── .gitconfig             # Git config (macOS)
├── .gitignore_global      # Gitignore global
├── .npmrc                 # Configuración de npm
├── .editorconfig          # Estilo de código global
├── .p10k.zsh              # Tema Powerlevel10k
├── Brewfile               # Paquetes de Homebrew
├── install.sh             # Script de instalación (macOS)
├── ssh/
│   └── config             # Configuración SSH (macOS)
├── gnupg/
│   ├── gpg.conf           # Configuración GPG
│   └── gpg-agent.conf     # Agente GPG con pinentry-mac
├── vscode/
│   └── settings.json      # Settings de VS Code
├── iterm2/
│   └── com.googlecode.iterm2.plist
├── macos/
│   └── defaults.sh        # Configuración de macOS
├── claude/
│   ├── CLAUDE.md          # Instrucciones para Claude Code
│   ├── settings.json      # Settings de Claude Code
│   ├── commands/          # Comandos personalizados
│   └── scripts/           # Scripts de hooks
└── windows/               # Configuración de Windows
    ├── install.ps1        # Script de instalación
    ├── .gitconfig         # Git config (Windows)
    ├── powershell/
    │   └── Microsoft.PowerShell_profile.ps1
    ├── terminal/
    │   └── settings.json  # Windows Terminal
    └── ssh/
        └── config         # Configuración SSH
```

## Instalación rápida

### macOS

```bash
git clone https://github.com/reiorozco/dotfiles.git ~/Dev/dotfiles
cd ~/Dev/dotfiles
./install.sh
```

### Windows

```powershell
git clone https://github.com/reiorozco/dotfiles.git $env:USERPROFILE\dotfiles
cd $env:USERPROFILE\dotfiles\windows
# Ejecutar como Administrador
.\install.ps1
```

## Qué instala

### CLI Tools

| Herramienta | Descripción |
|-------------|-------------|
| bat | cat con syntax highlighting |
| eza | ls moderno con iconos |
| fzf | Fuzzy finder (Ctrl+R) |
| zoxide | Navegación inteligente (z) |
| gh | GitHub CLI |
| gnupg | Firma de commits GPG |
| mprocs | Ejecutar múltiples procesos |

### Aplicaciones

| App | Descripción |
|-----|-------------|
| iTerm2 | Terminal avanzada |
| VS Code | Editor principal |
| Cursor | Editor con AI |
| OrbStack | Docker & Linux VMs |
| Postman | API testing |
| Stats | Monitor de sistema |
| Alt-Tab | Alt-tab estilo Windows |

### VS Code Extensions

- ESLint, Prettier, GitLens
- Error Lens, Pretty TS Errors
- ES7+ React Snippets
- Tailwind CSS, Docker, Prisma
- Material Icon Theme
- GitHub Copilot

### Stack de desarrollo

- **Node.js** via Volta (version manager)
- **pnpm** como package manager
- **Oh My Zsh** + Powerlevel10k

## Configuraciones incluidas

### Zsh
- Historial optimizado (50k, sin duplicados)
- Aliases útiles (`ll`, `la`, `tree`, `cat`, etc.)
- Herramientas modernas (bat, eza, fzf, zoxide)
- Función `killport` para matar procesos por puerto

### Git
- Auto-rebase en pull
- Auto-setup remote en push
- Firma GPG de commits habilitada
- 20+ aliases (`git st`, `lg`, `undo`, etc.)

### SSH
- Defaults globales seguros
- Keepalive para conexiones estables
- Configuración para GitHub

### GPG
- Firma de commits con ED25519
- pinentry-mac para diálogo nativo
- Cache de 8 horas

### macOS Defaults
- Finder: archivos ocultos, extensiones, path bar
- Dock: autohide instantáneo, sin recientes
- Teclado: repetición rápida, sin autocorrección
- Screenshots: ~/Pictures/Screenshots, PNG, sin sombra

### iTerm2
- Fuente MesloLGS Nerd Font
- 10,000 líneas de scrollback
- Option key como Meta

### EditorConfig
- 2 espacios para JS/TS/JSON/YAML
- 4 espacios para Python/Rust
- Tabs para Go/Makefile
- UTF-8, LF, trim whitespace

## Post-instalación

### 1. Generar clave SSH

```bash
ssh-keygen -t ed25519 -C "tu@email.com"
gh ssh-key add ~/.ssh/id_ed25519.pub
```

### 2. Generar clave GPG

```bash
gpg --full-generate-key
# Elegir: (1) RSA and RSA, 4096 bits, 0 = no expira

# Obtener Key ID
gpg --list-secret-keys --keyid-format LONG

# Configurar Git
git config --global user.signingkey <KEY_ID>

# Añadir a GitHub
gpg --armor --export <KEY_ID> | gh gpg-key add -
```

### 3. Personalizar prompt

```bash
p10k configure
```

## Actualizar

```bash
cd ~/Dev/dotfiles
git pull
./install.sh
```

## Backup manual

```bash
cd ~/Dev/dotfiles
git add -A
git commit -m "Update configs"
git push
```

## Git Aliases

| Alias | Comando |
|-------|---------|
| `git st` | status -sb |
| `git lg` | log --oneline --graph (20) |
| `git co` | checkout |
| `git cb` | checkout -b |
| `git cm` | commit -m |
| `git undo` | reset --soft HEAD~1 |
| `git sync` | fetch + rebase origin/main |
| `git pushf` | push --force-with-lease |

---

## Windows

### Qué instala

#### Aplicaciones (via winget)

| App | Descripción |
|-----|-------------|
| PowerShell Core | Shell moderno |
| Windows Terminal | Terminal con tabs y splits |
| Oh-My-Posh | Prompt moderno con temas |
| VS Code | Editor principal |
| Cursor | Editor con AI |
| Docker Desktop | Contenedores |
| Postman | API testing |

#### Módulos PowerShell

| Módulo | Descripción |
|--------|-------------|
| Terminal-Icons | Iconos en `ls` |
| z | Navegación rápida |
| posh-git | Autocompletado git |
| PSReadLine | Historial predictivo |

### Configuraciones incluidas

#### PowerShell Profile
- Oh-My-Posh con tema `catppuccin_mocha`
- PSReadLine con predicción de historial
- Aliases: `g`, `c`, `ll`, `..`, `...`
- Git shortcuts: `gs`, `ga`, `gc`, `gp`, `gl`, `glog`
- Funciones: `mkcd`, `reload`, `myip`, `work`, `desktop`

#### Windows Terminal
- Tema: One Half Dark
- Fuente: CaskaydiaCove Nerd Font
- Atajos: Ctrl+T (nueva tab), Alt+Shift+Plus (split)

#### Git
- Auto-rebase en pull
- Auto-setup remote en push
- 25+ aliases

### PowerShell Shortcuts

| Comando | Acción |
|---------|--------|
| `g` | git |
| `c` | code |
| `ll` | ls con iconos |
| `..` / `...` | Subir 1/2 niveles |
| `work` | Ir a Desktop/Work |
| `z <nombre>` | Saltar a directorio |
| `gs` | git status |
| `gp` / `gl` | git push/pull |
| `glog` | git log gráfico |
| `mkcd <dir>` | Crear carpeta y entrar |
| `reload` | Recargar perfil |

### Atajos Windows Terminal

| Atajo | Acción |
|-------|--------|
| `Ctrl+T` | Nueva pestaña |
| `Ctrl+W` | Cerrar pestaña |
| `Ctrl+Tab` | Siguiente pestaña |
| `Alt+Shift+Plus` | Split vertical |
| `Alt+Shift+Minus` | Split horizontal |
| `Alt+Flechas` | Mover entre paneles |
