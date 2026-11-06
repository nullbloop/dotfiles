# ~/.config/fish/functions/y.fish
function y
    set -l tmp (mktemp -t yazi-cwd.XXXXXX)
    yazi $argv --cwd-file="$tmp"
    set -l cwd (cat -- "$tmp")
    if test -n "$cwd"; and test "$cwd" != "$PWD"; and test -d "$cwd"
        cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
