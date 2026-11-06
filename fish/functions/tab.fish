# ~/.config/fish/functions/tab.fish
function tab
    adb disconnect 2>/dev/null
    adb connect 100.97.84.85:5555
    setsid -f scrcpy --turn-screen-off --stay-awake --max-fps=60 \
        --video-bit-rate=20M --no-audio --window-title=Tablet \
        >/dev/null 2>&1
end
