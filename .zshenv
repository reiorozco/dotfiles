
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# --- TOKENS (archivo local, no trackeado) ---
[[ -f "$HOME/.tokens" ]] && source "$HOME/.tokens"
