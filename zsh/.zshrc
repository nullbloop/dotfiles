# ZSH PLUGINS (Fish-like features)

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# INTERACTIVE SHELL SETUP
if [[ $- == *i* ]]; then
    # Starship prompt
    if command -v starship &>/dev/null; then
        eval "$(starship init zsh)"
    fi

    # Quickshell terminal sequences
    if [[ -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt ]]; then
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    fi

    # Aliases
    alias clear="printf '\033[2J\033[3J\033[1;1H'"
    alias celar="printf '\033[2J\033[3J\033[1;1H'"
    alias claer="printf '\033[2J\033[3J\033[1;1H'"
    
    if command -v eza &>/dev/null; then
        alias ls='eza --icons'
    fi
    
    alias q='qs -c ii'

    # Custom Aliases (from aliases.fish)
    alias tab='adb disconnect 2>/dev/null; adb connect 100.97.84.85:5555; setsid -f scrcpy --turn-screen-off --stay-awake --max-fps=60 --video-bit-rate=20M --no-audio --window-title=Tablet >/dev/null 2>&1'
fi

# Fastfetch colors sourcing
if [[ -f ~/.config/fastfetch/colors.sh ]]; then
    source ~/.config/fastfetch/colors.sh
fi

# FUNCTIONS

# Yazi wrapper (cd on exit)
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    command yazi "$@" --cwd-file="$tmp"
    local cwd="$(cat -- "$tmp")"
    if [[ -n "$cwd" && "$cwd" != "$PWD" && -d "$cwd" ]]; then
        builtin cd -- "$cwd"
        zle reset-prompt  # Refresh prompt to show new directory
    fi
    rm -f -- "$tmp"
}

# AUTO-START HYPRLAND 
if [[ -z "$DISPLAY" && "$XDG_VTNR" -eq 1 ]]; then
    mkdir -p ~/.cache
    exec start-hyprland > ~/.cache/hyprland.log 2>&1
fi
