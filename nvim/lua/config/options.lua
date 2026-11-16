local opt = vim.opt

-- General settings
opt.number = true
opt.relativenumber = false
opt.termguicolors = true
opt.clipboard = "unnamedplus"
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.swapfile = false
opt.undofile = true
opt.smartindent = true

-- Global defaults: Tabs
opt.expandtab = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

-- Stop .editorconfig from overriding
vim.g.editorconfig = false

-- Force tabs globally on every file
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.cindent = false
		vim.opt_local.smartindent = true
	end,
})

-- The ONLY exception: Python
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt_local.expandtab = true
	end,
})

-- Diagnostics (Required for tiny-inline-diagnostic to work)
vim.diagnostic.config({
	virtual_text = false, -- MUST be false for tiny-inline-diagnostic to show
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
	-- Hide the annoying FIXME/TODO information tags safely
	filter = function(diagnostic)
		-- Safety check: Sometimes Neovim passes a number instead of a table
		if type(diagnostic) ~= "table" then
			return true
		end
		
		if diagnostic.severity == vim.diagnostic.severity.INFO and 
		   diagnostic.message and
		   (diagnostic.message:match("FIXME") or diagnostic.message:match("TODO")) then
			return false
		end
		return true
	end,
})

-- Wipe stale diagnostics from the screen the second you save
vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		vim.diagnostic.reset()
	end,
})

-- OSC 52 clipboard (works over SSH)
vim.g.clipboard = {
	name  = "OSC 52",
	copy  = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*")
	},
	paste = {
		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
		["*"] = require("vim.ui.clipboard.osc52").paste("*")
	},
}
