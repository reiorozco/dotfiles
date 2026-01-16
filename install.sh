#!/bin/bash

# ===========================================
# Dotfiles Installation Script
# ===========================================

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

echo "Installing dotfiles from $DOTFILES_DIR"

# --- FUNCIONES ---
backup_and_link() {
  local src="$1"
  local dest="$2"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mkdir -p "$BACKUP_DIR"
    echo "Backing up $dest to $BACKUP_DIR/"
    mv "$dest" "$BACKUP_DIR/"
  fi

  if [ -L "$dest" ]; then
    rm "$dest"
  fi

  echo "Linking $src -> $dest"
  ln -sf "$src" "$dest"
}

# --- INSTALAR HOMEBREW ---
if ! command -v brew &> /dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- INSTALAR PAQUETES ---
echo ""
echo "Installing Homebrew packages..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# --- INSTALAR OH MY ZSH ---
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo ""
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# --- INSTALAR ZSH-AUTOSUGGESTIONS ---
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  echo "Installing zsh-autosuggestions..."
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

# --- INSTALAR POWERLEVEL10K ---
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi

# --- INSTALAR VOLTA ---
if [ ! -d "$HOME/.volta" ]; then
  echo ""
  echo "Installing Volta..."
  curl https://get.volta.sh | bash -s -- --skip-setup
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
  volta install node@lts
  volta install pnpm
fi

# --- CREAR SYMLINKS ---
echo ""
echo "Creating symlinks..."

backup_and_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/.zshenv" "$HOME/.zshenv"
backup_and_link "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
backup_and_link "$DOTFILES_DIR/.gitignore_global" "$HOME/.gitignore_global"
backup_and_link "$DOTFILES_DIR/.npmrc" "$HOME/.npmrc"
backup_and_link "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
backup_and_link "$DOTFILES_DIR/.editorconfig" "$HOME/.editorconfig"

# SSH config
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
backup_and_link "$DOTFILES_DIR/ssh/config" "$HOME/.ssh/config"
chmod 600 "$HOME/.ssh/config"

# GPG config
mkdir -p "$HOME/.gnupg"
chmod 700 "$HOME/.gnupg"
backup_and_link "$DOTFILES_DIR/gnupg/gpg.conf" "$HOME/.gnupg/gpg.conf"
backup_and_link "$DOTFILES_DIR/gnupg/gpg-agent.conf" "$HOME/.gnupg/gpg-agent.conf"
chmod 600 "$HOME/.gnupg"/*

# VS Code settings
VSCODE_USER_DIR="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_USER_DIR"
backup_and_link "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"

# iTerm2 settings
ITERM2_PLIST="$HOME/Library/Preferences/com.googlecode.iterm2.plist"
if [ -f "$DOTFILES_DIR/iterm2/com.googlecode.iterm2.plist" ]; then
  echo "Installing iTerm2 settings..."
  if [ -f "$ITERM2_PLIST" ]; then
    mkdir -p "$BACKUP_DIR"
    cp "$ITERM2_PLIST" "$BACKUP_DIR/"
  fi
  cp "$DOTFILES_DIR/iterm2/com.googlecode.iterm2.plist" "$ITERM2_PLIST"
fi

# macOS defaults
if [ -f "$DOTFILES_DIR/macos/defaults.sh" ]; then
  echo ""
  read -p "Apply macOS defaults? (y/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    bash "$DOTFILES_DIR/macos/defaults.sh"
  fi
fi

# --- FINALIZADO ---
echo ""
echo "=========================================="
echo "Dotfiles installed successfully!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: exec zsh"
echo "  2. Run 'p10k configure' if you want to customize the prompt"
echo "  3. Generate SSH keys if needed: ssh-keygen -t ed25519 -C 'your@email.com'"
echo ""
