local opt = vim.opt

opt.number = true
opt.relativenumber = false
opt.expandtab = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.termguicolors = true
opt.clipboard = "unnamedplus"
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.swapfile = false
opt.undofile = true

vim.diagnostic.config({
	virtual_text = false,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
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

-- Python uses spaces (overrides global tab setting)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})
