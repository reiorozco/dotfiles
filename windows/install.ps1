# ===========================================
# Dotfiles Installation Script for Windows
# ===========================================

#Requires -RunAsAdministrator

$ErrorActionPreference = "Stop"
$DOTFILES_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$BACKUP_DIR = "$env:USERPROFILE\.dotfiles_backup\$(Get-Date -Format 'yyyyMMdd_HHmmss')"

Write-Host "Installing Windows dotfiles from $DOTFILES_DIR" -ForegroundColor Cyan

# --- FUNCIONES ---
function Backup-And-Copy {
    param([string]$src, [string]$dest)

    if (Test-Path $dest) {
        if (-not (Test-Path $BACKUP_DIR)) {
            New-Item -ItemType Directory -Path $BACKUP_DIR -Force | Out-Null
        }
        Write-Host "Backing up $dest to $BACKUP_DIR/" -ForegroundColor Yellow
        Copy-Item $dest -Destination $BACKUP_DIR -Force
    }

    $destDir = Split-Path -Parent $dest
    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }

    Write-Host "Copying $src -> $dest" -ForegroundColor Green
    Copy-Item $src -Destination $dest -Force
}

# --- INSTALAR WINGET (si no existe) ---
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Installing winget..." -ForegroundColor Cyan
    $progressPreference = 'silentlyContinue'
    Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
    Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
    Remove-Item Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
}

# --- INSTALAR APLICACIONES ---
Write-Host ""
Write-Host "Installing applications via winget..." -ForegroundColor Cyan

$apps = @(
    # Terminal & Shell
    "Microsoft.PowerShell"
    "Microsoft.WindowsTerminal"
    "JanDeDobbeleer.OhMyPosh"
    "Git.Git"

    # Editors & IDEs
    "Microsoft.VisualStudioCode"
    "Cursor.Cursor"
    "JetBrains.Toolbox"

    # DevOps
    "Docker.DockerDesktop"
    "Postman.Postman"

    # Browser
    "Google.Chrome"

    # Utilities
    "7zip.7zip"
    "voidtools.Everything"

    # AI
    "Anthropic.Claude"

    # Entertainment
    "Spotify.Spotify"
    "Valve.Steam"
    "EpicGames.EpicGamesLauncher"
)

foreach ($app in $apps) {
    Write-Host "Installing $app..." -ForegroundColor Gray
    winget install -e --id $app --accept-source-agreements --accept-package-agreements --silent 2>$null
}

# --- INSTALAR MODULOS POWERSHELL ---
Write-Host ""
Write-Host "Installing PowerShell modules..." -ForegroundColor Cyan

$modules = @("Terminal-Icons", "z", "posh-git")
foreach ($module in $modules) {
    if (-not (Get-Module -ListAvailable -Name $module)) {
        Write-Host "Installing $module..." -ForegroundColor Gray
        Install-Module -Name $module -Repository PSGallery -Scope CurrentUser -Force
    }
}

# --- COPIAR CONFIGURACIONES ---
Write-Host ""
Write-Host "Copying configuration files..." -ForegroundColor Cyan

# PowerShell profile
$pwshProfileDir = "$env:USERPROFILE\Documents\PowerShell"
Backup-And-Copy "$DOTFILES_DIR\powershell\Microsoft.PowerShell_profile.ps1" "$pwshProfileDir\Microsoft.PowerShell_profile.ps1"

# Windows Terminal settings
$wtSettingsDir = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
if (Test-Path (Split-Path $wtSettingsDir)) {
    Backup-And-Copy "$DOTFILES_DIR\terminal\settings.json" "$wtSettingsDir\settings.json"
}

# Git config
Backup-And-Copy "$DOTFILES_DIR\.gitconfig" "$env:USERPROFILE\.gitconfig"

# SSH config
$sshDir = "$env:USERPROFILE\.ssh"
if (-not (Test-Path $sshDir)) {
    New-Item -ItemType Directory -Path $sshDir -Force | Out-Null
}
Backup-And-Copy "$DOTFILES_DIR\ssh\config" "$sshDir\config"

# --- GENERAR SSH KEY (si no existe) ---
if (-not (Test-Path "$sshDir\id_ed25519")) {
    Write-Host ""
    $email = Read-Host "Enter your email for SSH key generation"
    if ($email) {
        Write-Host "Generating SSH key..." -ForegroundColor Cyan
        ssh-keygen -t ed25519 -C $email -f "$sshDir\id_ed25519" -N '""'
        Write-Host ""
        Write-Host "Your public key (add to GitHub):" -ForegroundColor Yellow
        Get-Content "$sshDir\id_ed25519.pub"
    }
}

# --- INSTALAR NERD FONT ---
Write-Host ""
$installFont = Read-Host "Install CaskaydiaCove Nerd Font? (y/n)"
if ($installFont -eq "y") {
    Write-Host "Installing font via Oh-My-Posh..." -ForegroundColor Cyan
    oh-my-posh font install CascadiaCode
}

# --- FINALIZADO ---
Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host "Windows dotfiles installed successfully!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Restart Windows Terminal"
Write-Host "  2. If font icons don't show, manually set font to 'CaskaydiaCove Nerd Font'"
Write-Host "  3. Add SSH key to GitHub: https://github.com/settings/keys"
Write-Host ""
