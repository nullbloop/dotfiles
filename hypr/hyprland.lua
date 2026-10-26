-- ~/dotfiles/hypr/hyprland.lua
local ok, colors = pcall(require, "colors")
if not ok then
	colors = {
		active_border = "rgba(4cb9ffcc)",
		inactive_border = "rgba(03243a80)",
	}
end

-- Environment Variables
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GTK_THEME", "adw-gtk3-dark")
hl.env("NIXOS_OZONE_WL", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_QPA_PLATFORMTHEME", "kde")
hl.env("QT_STYLE_OVERRIDE", "Darkly")
hl.env("QT_LOGGING_RULES", "quickshell.dbus.properties=false")
hl.env("XDG_MENU_PREFIX", "plasma-")

-- Cursor theme
hl.env("XCURSOR_THEME", "catppuccin-mocha-pink-cursors")
hl.env("XCURSOR_SIZE", "24")

-- Input (from 10-input-and-cursor.kdl)
hl.config({
	input = {
		kb_layout = "pt",
		repeat_delay = 250,
		repeat_rate = 50,
		follow_mouse = 1,
		accel_profile = "flat",
		natural_scroll = true,
		touchpad = {
			tap_to_click = true,
			natural_scroll = true,
			clickfinger_behavior = true,
		},
	},
	cursor = {
		no_hardware_cursors = 1,
		hide_on_key_press = true,
		inactive_timeout = 5,
	},
})
-- Monitor (auto-detect)
hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = 1,
})

-- General appearance
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 0,
		col = {
			active_border = colors.active_border,
			inactive_border = colors.inactive_border,
		},
		layout = "dwindle",
		resize_on_border = true,
	},
	dwindle = {
		preserve_split = true,
	},
	decoration = {
		rounding = 16,
		active_opacity = 1.0,
		inactive_opacity = 0.9,
		shadow = {
			enabled = true,
			range = 30,
			render_power = 5,
			offset = "0 5",
			color = "rgba(00000070)",
		},
		blur = {
			enabled = true,
			size = 8,
			passes = 2,
		},
	},
	misc = {
		disable_hyprland_logo = true,
	},
	debug = {
		vfr = true,
	},
})

-- Autostart
hl.on("hyprland.start", function()
	-- Noctalia Shell
	hl.exec_cmd("noctalia")

	-- Clipboard history
	hl.exec_cmd("bash -c 'wl-paste --type text --watch cliphist store'")
	hl.exec_cmd("bash -c 'wl-paste --type image --watch cliphist store'")

	-- EasyEffects
	hl.exec_cmd("systemctl --user enable --now easyeffects")

	-- KDE menu indexing
	hl.exec_cmd("bash -c 'systemctl --user import-environment XDG_MENU_PREFIX && kbuildsycoca6'")

	-- PipeWire readiness
	hl.exec_cmd(
		"sh -c 'systemctl --user start pipewire pipewire-pulse wireplumber; until wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null | grep -q Volume; do sleep 0.3; done'")

	-- Polkit authentication agent
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

	-- GNOME Keyring
	hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")

	-- WiFi powersave off
	hl.exec_cmd("sh -c 'iw dev wlp3s0 set power_save off'")
	hl.exec_cmd("hyprresume")
end)

-- Window Rules
-- Inactive window opacity (tiled only)
hl.window_rule({
	match = { float = false },
	opacity = "1.0 0.9",
})

-- Picture-in-Picture (floating)
hl.window_rule({
	match = { title = "^(Picture-in-Picture)$" },
	float = true,
})
hl.window_rule({
	match = { class = "^(zen)$", title = "^(Picture-in-Picture)$" },
	float = true,
})

-- Steam notification toasts
hl.window_rule({
	match = { class = "^(steam)$", title = "^(notificationtoasts_\\d+_desktop)$" },
	float = true,
	no_focus = true,
	move = "10 10",
})
-- xembedsniproxy (invisible, no focus, no border, no shadow)
hl.window_rule({
	match = { class = "^(xembedsniproxy)$" },
	float = true,
	no_focus = true,
	opacity = "0.0",
	border_size = 0,
	no_shadow = true,
})

hl.window_rule({ match = { class = "^(whatsie)$" }, workspace = "special:comm" })
hl.window_rule({ match = { class = "^(equibop)$" }, workspace = "special:comm" })
hl.window_rule({ match = { class = "^(thunderbird)$" }, workspace = "special:comm" })

hl.window_rule({ match = { class = "^(Spotify)$" }, workspace = "special:music" })


hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")

-- Load submodules
require("animations")
require("keybinds")
