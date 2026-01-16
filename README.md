# Dotfiles

Configuración personal para macOS con stack de desarrollo React/TypeScript/Node.

## Contenido

```
dotfiles/
├── .zshrc                 # Configuración de Zsh optimizada
├── .zshenv                # Variables de entorno (Volta)
├── .gitconfig             # Git config + aliases + GPG signing
├── .gitignore_global      # Gitignore global
├── .npmrc                 # Configuración de npm
├── .editorconfig          # Estilo de código global
├── .p10k.zsh              # Tema Powerlevel10k
├── Brewfile               # Paquetes de Homebrew
├── ssh/
│   └── config             # Configuración SSH
├── gnupg/
│   ├── gpg.conf           # Configuración GPG
│   └── gpg-agent.conf     # Agente GPG con pinentry-mac
├── vscode/
│   └── settings.json      # Settings de VS Code
├── iterm2/
│   └── com.googlecode.iterm2.plist  # Configuración iTerm2
├── macos/
│   └── defaults.sh        # Configuración de macOS
└── install.sh             # Script de instalación
```

## Instalación rápida

```bash
git clone https://github.com/reiorozco/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
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
- Screenshots: ~/Screenshots, PNG, sin sombra

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
cd ~/dotfiles
git pull
./install.sh
```

## Backup manual

```bash
cd ~/dotfiles
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
