function ff --description "fastfetch with Serpentinum colors"
    set -l palette ~/.local/state/serpantinum/qs_colors.json
    if not test -f $palette
        fastfetch $argv
        return
    end
    set -l blue  (grep -oP '"blue"\s*:\s*"\K[^"]+' $palette | head -1)
    set -l mauve (grep -oP '"mauve"\s*:\s*"\K[^"]+' $palette | head -1)
    set -l text  (grep -oP '"text"\s*:\s*"\K[^"]+' $palette | head -1)
    set -l sub1  (grep -oP '"subtext1"\s*:\s*"\K[^"]+' $palette | head -1)

    command fastfetch \
        --color-keys      $blue \
        --color-title     $mauve \
        --color-output    $text \
        --color-separator $sub1 \
        $argv
end


