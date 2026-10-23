# Custom aliases
alias tab 'adb disconnect 2>/dev/null; adb connect 100.97.84.85:5555; and setsid -f scrcpy --turn-screen-off --stay-awake --max-fps=60 --video-bit-rate=20M --no-audio --window-title=Tablet >/dev/null 2>&1'
alias notewise 'adb disconnect 2>/dev/null; adb connect 100.97.84.85:5555; and setsid -f scrcpy --new-display=1920x1200 --start-app=com.yygg.note.app --stay-awake --max-fps=60 --no-audio --window-title=Notewise >/dev/null 2>&1'
alias vpnup 'sudo openvpn --config ~/Downloads/tecnico.ovpn --daemon'
alias vpndown 'sudo pkill openvpn'
