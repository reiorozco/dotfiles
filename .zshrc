# --- STARSHIP PROMPT ---
# (Reemplaza Powerlevel10k)

# --- LOCALE UTF-8 ---
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# --- CONFIGURACIÓN BÁSICA ---
export ZSH="$HOME/.oh-my-zsh"
export EDITOR="code --wait"
export VISUAL="$EDITOR"

# Brew prefix cacheado (evita llamadas lentas a brew --prefix)
BREW_PREFIX="/opt/homebrew"

# --- HISTORIAL OPTIMIZADO ---
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS    # No duplicados
setopt HIST_FIND_NO_DUPS       # No mostrar dups al buscar
setopt HIST_SAVE_NO_DUPS       # No guardar dups
setopt SHARE_HISTORY           # Compartir entre sesiones
setopt INC_APPEND_HISTORY      # Guardar inmediatamente

# --- OH MY ZSH ---
ZSH_THEME=""  # Deshabilitado - usando Starship

plugins=(
  git
  zsh-autosuggestions
  docker
  gh
)

source $ZSH/oh-my-zsh.sh

# Autocompletado case-insensitive
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# --- ALIASES GENERALES ---
alias brewup="brew update && brew upgrade && brew cleanup"
alias dev="cd ~/Dev"
alias home="cd ~/"

# --- FUNCIÓN KILLPORT ---
# Uso: killport 3000 3001 8080
function killport() {
  if [ $# -eq 0 ]; then
    echo "Uso: killport <puerto> [puerto2] [puerto3]..."
    return 1
  fi

  for port in "$@"; do
    local pid=$(lsof -ti:$port 2>/dev/null)
    if [ -z "$pid" ]; then
      echo "Puerto $port: limpio"
    else
      echo "$pid" | xargs kill -9
      echo "Puerto $port: proceso eliminado (PID: $pid)"
    fi
  done
}

# --- HERRAMIENTAS MODERNAS ---

# Zoxide (navegación inteligente)
if [[ $- == *i* ]]; then
  eval "$(zoxide init zsh)"
  # Usa 'z' directamente, no sobreescribas 'cd'
fi

# Eza (reemplazo moderno de ls)
alias ls="eza --icons"
alias ll="eza -l --icons --git"
alias la="eza -la --icons --git"
alias tree="eza --tree --icons"

# Bat (reemplazo de cat con syntax highlighting)
alias cat="bat"

# FZF (búsqueda interactiva)
[[ -f "$BREW_PREFIX/opt/fzf/shell/completion.zsh" ]] && source "$BREW_PREFIX/opt/fzf/shell/completion.zsh"
[[ -f "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]] && source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"

# GitHub CLI
alias ghpr="gh pr create"
alias ghprl="gh pr list"
alias ghrc="gh repo create"

# --- DOCKER / BASES DE DATOS ---
DB_PATH="$HOME/Dev/servicios-db/docker-compose.yml"

alias db-start="docker compose -f $DB_PATH up -d"
alias db-stop="docker compose -f $DB_PATH stop"
alias db-restart="docker compose -f $DB_PATH restart"
alias db-logs="docker compose -f $DB_PATH logs -f"
alias db-status="docker compose -f $DB_PATH ps"

# --- WORKSPACE: RANK TITAN ---
function ranktitan() {
  local ROOT="$HOME/Dev/ranktitan"

  if [[ "$TERM_PROGRAM" == "iTerm.app" ]]; then
    echo "Desplegando entorno Rank Titan en iTerm2..."
    osascript -e "tell application \"iTerm\"
      tell current window
        create tab with default profile
        tell current session of current tab
          write text \"cd $ROOT/dashboard-front && clear\"
          set name to \"Dash Front\"
        end tell

        create tab with default profile
        tell current session of current tab
          write text \"cd $ROOT/Google-Rank-AI-Server && clear\"
          set name to \"AI Server\"
        end tell

        create tab with default profile
        tell current session of current tab
          write text \"cd $ROOT/marketplace-front && clear\"
          set name to \"Mkt Front\"
        end tell

        create tab with default profile
        tell current session of current tab
          write text \"cd $ROOT/marketplace-server && clear\"
          set name to \"Mkt Server\"
        end tell
      end tell
    end tell"
  else
    echo "Desplegando entorno Rank Titan en Terminal..."
    osascript -e "tell application \"Terminal\"
      activate
      if not (exists window 1) then reopen

      tell front window
        do script \"cd $ROOT/dashboard-front && clear\" in selected tab

        tell application \"System Events\" to keystroke \"t\" using command down
        delay 0.2
        do script \"cd $ROOT/Google-Rank-AI-Server && clear\" in selected tab

        tell application \"System Events\" to keystroke \"t\" using command down
        delay 0.2
        do script \"cd $ROOT/marketplace-front && clear\" in selected tab

        tell application \"System Events\" to keystroke \"t\" using command down
        delay 0.2
        do script \"cd $ROOT/marketplace-server && clear\" in selected tab
      end tell
    end tell"
  fi
}

# --- PLUGINS EXTERNOS (deben ir al final) ---
# Syntax highlighting
[[ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && \
  source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Entorno adicional
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
export GPG_TTY=$(tty)

# --- STARSHIP PROMPT (debe ir al final) ---
eval "$(starship init zsh)"
