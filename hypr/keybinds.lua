-- ~/dotfiles/hypr/keybinds.lua

local mainMod = "SUPER"

-- Session & compositor
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + D", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })) -- was maximize-column; no exact match
hl.bind(mainMod .. " + A", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("hyprctl dispatch dpms off"))

-- Noctalia panels
local ipc = "noctalia msg "
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(ipc .. "panel-toggle launcher"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(ipc .. "panel-toggle wallpaper"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(ipc .. "panel-toggle notifications"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(ipc .. "dnd-toggle"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.exec_cmd(ipc .. "panel-toggle session"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(ipc .. "panel-toggle control-center"))

-- Lock & power
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd(ipc .. "session lock"))
hl.bind("XF86PowerOff", hl.dsp.exec_cmd(ipc .. "session lock"))

-- Screenshots
hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m window --clipboard-only"))

-- App launchers
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty -e yazi"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("zen-browser"))

-- Focus navigation
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + Left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + Up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + Down", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + Home", hl.dsp.focus({ workspace = "e-10" }))
hl.bind(mainMod .. " + End", hl.dsp.focus({ workspace = "e+10" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + Left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + Up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + Down", hl.dsp.window.move({ direction = "down" }))

-- Multi-monitor focus
hl.bind(mainMod .. " + CTRL + Left", hl.dsp.focus({ monitor = "left" }))
hl.bind(mainMod .. " + CTRL + Right", hl.dsp.focus({ monitor = "right" }))
hl.bind(mainMod .. " + CTRL + Up", hl.dsp.focus({ monitor = "up" }))
hl.bind(mainMod .. " + CTRL + Down", hl.dsp.focus({ monitor = "down" }))

-- Multi-monitor move
hl.bind(mainMod .. " + CTRL + SHIFT + Left", hl.dsp.window.move({ monitor = "left" }))
hl.bind(mainMod .. " + CTRL + SHIFT + Right", hl.dsp.window.move({ monitor = "right" }))
hl.bind(mainMod .. " + CTRL + SHIFT + Up", hl.dsp.window.move({ monitor = "up" }))
hl.bind(mainMod .. " + CTRL + SHIFT + Down", hl.dsp.window.move({ monitor = "down" }))

-- Workspaces 1-9
for i = 1, 9 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Page up/down workspace nav
hl.bind(mainMod .. " + Page_Down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + Page_Up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + Page_Down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + Page_Up", hl.dsp.window.move({ workspace = "e-1" }))

-- Mouse wheel workspace
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + CTRL + mouse_down", hl.dsp.window.move({ workspace = "e+1" }))
hl.bind(mainMod .. " + CTRL + mouse_up", hl.dsp.window.move({ workspace = "e-1" }))

-- Hardware keys (work even when locked, for volume/brightness from lock screen)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. "volume-up"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. "volume-down"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. "volume-mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(ipc .. "mic-mute"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. "brightness-up"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. "brightness-down"), { locked = true }) -- Media keys
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(ipc .. "media toggle"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(ipc .. "media toggle"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(ipc .. "media next"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(ipc .. "media previous"))

-- Reload
hl.bind(mainMod .. " + CTRL + R", hl.dsp.exec_cmd("hyprctl reload"))

-- Touchpad gestures
-- 3-finger horizontal swipe = switch workspaces
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
-- Move window with SUPER + Left Click Drag
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- Resize window with SUPER + Right Click Drag
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- keybinds.lua
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"))


-- Toggle Communication overlay
hl.bind(mainMod .. " + C", hl.dsp.workspace.toggle_special("comm"))

-- Toggle Music/Mail overlay
hl.bind(mainMod .. " + M", hl.dsp.workspace.toggle_special("music"))

hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.move({ workspace = "special:comm" }))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.window.move({ workspace = "special:music" }))

hl.gesture({ fingers = 4, direction = "down", action = "special", workspace_name = "comm" })

hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd("~/.local/bin/toggle-vnc.sh"))
