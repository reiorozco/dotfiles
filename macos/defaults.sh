#!/bin/bash

# ===========================================
# macOS Defaults - Configuración para desarrollo
# ===========================================

echo "Aplicando configuración de macOS..."

# Cerrar System Preferences para evitar conflictos
osascript -e 'tell application "System Preferences" to quit' 2>/dev/null

# --- GENERAL ---
# Expandir panel de guardar por defecto
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expandir panel de imprimir por defecto
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Guardar en disco (no iCloud) por defecto
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Desactivar "Are you sure you want to open this app?"
defaults write com.apple.LaunchServices LSQuarantine -bool false

# --- TECLADO ---
# Repetición de tecla rápida
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Desactivar auto-corrección
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Desactivar capitalización automática
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Desactivar puntos dobles por espacio doble
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Desactivar smart quotes y dashes (molestan al programar)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# --- TRACKPAD ---
# Tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# --- FINDER ---
# Mostrar extensiones de archivos
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Mostrar archivos ocultos
defaults write com.apple.finder AppleShowAllFiles -bool true

# Mostrar barra de ruta
defaults write com.apple.finder ShowPathbar -bool true

# Mostrar barra de estado
defaults write com.apple.finder ShowStatusBar -bool true

# Búsqueda en carpeta actual por defecto
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Desactivar advertencia al cambiar extensión
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Evitar crear .DS_Store en red y USB
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Vista de lista por defecto
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Mostrar ~/Library
chflags nohidden ~/Library

# Mostrar /Volumes
sudo chflags nohidden /Volumes 2>/dev/null

# --- DOCK ---
# Tamaño de iconos
defaults write com.apple.dock tilesize -int 48

# Ocultar automáticamente
defaults write com.apple.dock autohide -bool true

# Quitar delay de auto-hide
defaults write com.apple.dock autohide-delay -float 0

# Animación rápida de auto-hide
defaults write com.apple.dock autohide-time-modifier -float 0.3

# No mostrar apps recientes
defaults write com.apple.dock show-recents -bool false

# Minimizar a la app
defaults write com.apple.dock minimize-to-application -bool true

# --- SCREENSHOTS ---
# Guardar en ~/Screenshots
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"

# Formato PNG
defaults write com.apple.screencapture type -string "png"

# Sin sombra
defaults write com.apple.screencapture disable-shadow -bool true

# --- SAFARI (Developer) ---
# Mostrar URL completa
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Habilitar menú Develop
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Web Inspector en todo
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# --- ACTIVITY MONITOR ---
# Mostrar todos los procesos
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Ordenar por CPU
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

# --- TEXTEDIT ---
# Plain text por defecto
defaults write com.apple.TextEdit RichText -int 0

# Abrir y guardar como UTF-8
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# --- TIEMPO DE MÁQUINA ---
# No preguntar para usar discos nuevos
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# --- APLICAR CAMBIOS ---
echo "Reiniciando aplicaciones afectadas..."

for app in "Finder" "Dock" "Safari" "SystemUIServer"; do
  killall "${app}" &> /dev/null || true
done

echo ""
echo "=========================================="
echo "macOS configurado correctamente"
echo "=========================================="
echo ""
echo "Nota: Algunos cambios requieren cerrar sesión o reiniciar."
echo ""
