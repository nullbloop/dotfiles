# ~/.config/fish/config.fish

# Interactive-only setup
set fish_greeting
if status is-interactive
    # Starship prompt
    if command -q starship
        starship init fish | source
    end

    # Quickshell terminal sequences
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    alias clear="printf '\033[2J\033[3J\033[1;1H'"
    alias celar="printf '\033[2J\033[3J\033[1;1H'"
    alias claer="printf '\033[2J\033[3J\033[1;1H'"
    alias q='qs -c ii'

    if command -q eza
        alias ls='eza --icons'
    end
end

# Fastfetch colors


if test -f ~/.config/fastfetch/colors.fish
    source ~/.config/fastfetch/colors.fish
end


# Auto-start Hyprland on TTY1

if test -z "$DISPLAY"; and test "$XDG_VTNR" = 1
    mkdir -p ~/.cache
    exec start-hyprland >~/.cache/hyprland.log 2>&1
end
