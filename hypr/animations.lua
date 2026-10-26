-- ~/dotfiles/hypr/animations.lua

hl.config({
	animations = {
		enabled = true,
	},
})

-- Bezier curves
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.curve("myBezierFast", { type = "bezier", points = { { 0.15, 0.85 }, { 0.3, 1.0 } } })

-- Animations: use bezier = "name", NOT curve = "name"
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "myBezierFast", style = "popin 80%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "myBezier" })
hl.animation({ leaf = "border", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "myBezier", style = "slidefade" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 5, bezier = "myBezier", style = "slidevert" })
