# ============================================================================
# PowerShell Profile - Optimizado para desarrollo
# ============================================================================

# --- Opciones de consola ---
$Host.UI.RawUI.WindowTitle = "PowerShell"
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

# --- PSReadLine: Mejora la experiencia de linea de comandos ---
if (Get-Module -ListAvailable -Name PSReadLine) {
    try {
        Set-PSReadLineOption -PredictionSource History
        Set-PSReadLineOption -PredictionViewStyle ListView
        Set-PSReadLineOption -EditMode Windows
        Set-PSReadLineOption -HistorySearchCursorMovesToEnd
        Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
        Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
        Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
        Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteCharOrExit
    } catch {
        # Silenciar errores si la terminal no soporta estas opciones
    }
}

# --- Aliases utiles para desarrollo ---
Set-Alias -Name g -Value git
Set-Alias -Name c -Value code
Set-Alias -Name which -Value Get-Command
Set-Alias -Name touch -Value New-Item
Set-Alias -Name ll -Value Get-ChildItem

# --- Funciones personalizadas ---

# Navegacion rapida
function .. { Set-Location .. }
function ... { Set-Location ../.. }
function .... { Set-Location ../../.. }

# Git shortcuts
function gs { git status }
function ga { git add $args }
function gaa { git add --all }
function gc { git commit -m $args }
function gp { git push }
function gl { git pull }
function gd { git diff $args }
function gco { git checkout $args }
function gb { git branch $args }
function glog { git log --oneline --graph --decorate -15 }

# Abrir directorio actual en VS Code
function codeh { code . }

# Crear directorio y entrar
function mkcd {
    param([string]$path)
    New-Item -ItemType Directory -Path $path -Force | Out-Null
    Set-Location $path
}

# Limpiar terminal
function cls { Clear-Host }

# IP local
function myip { (Invoke-WebRequest -Uri "https://api.ipify.org" -UseBasicParsing).Content }

# Buscar en historial
function hg { Get-History | Where-Object { $_.CommandLine -like "*$args*" } }

# Reload del perfil
function reload { . $PROFILE }

# --- Directorios de trabajo frecuentes ---
function work { Set-Location "C:\Users\rfoc1\Desktop\Work" }
function desktop { Set-Location "C:\Users\rfoc1\Desktop" }
function docs { Set-Location "C:\Users\rfoc1\Documents" }

# --- Oh-My-Posh Prompt ---
# Tema: catppuccin_mocha (paleta suave, elegante)
# Cambiar tema: reemplaza 'catppuccin_mocha' por: agnoster, paradox, jandedobbeleer, atomic, etc.
# Lista completa: https://ohmyposh.dev/docs/themes
$omp_theme = "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/catppuccin_mocha.omp.json"
oh-my-posh init pwsh --config $omp_theme | Invoke-Expression

# --- Terminal-Icons: Iconos en ls/dir ---
Import-Module Terminal-Icons

# --- z: Navegacion rapida a directorios frecuentes ---
# Uso: z <parte-del-nombre> (ej: z work, z desktop)
Import-Module z

# --- posh-git: Autocompletado de git ---
Import-Module posh-git

# --- fzf: Fuzzy finder ---
# Ctrl+R: Busqueda fuzzy en historial
# Ctrl+T: Busqueda fuzzy de archivos
if (Get-Command fzf -ErrorAction SilentlyContinue) {
    Import-Module PSFzf
    Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
    Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
    $env:FZF_DEFAULT_OPTS = '--height 40% --layout=reverse --border'
}

# --- bat: cat con syntax highlighting ---
if (Get-Command bat -ErrorAction SilentlyContinue) {
    Set-Alias -Name cat -Value bat -Option AllScope
    $env:BAT_THEME = "Catppuccin Mocha"
}

# --- Variables de entorno utiles ---
$env:EDITOR = "code --wait"
$env:VISUAL = "code --wait"

# --- Mensaje de bienvenida ---
Write-Host "PowerShell $($PSVersionTable.PSVersion)" -ForegroundColor DarkGray
