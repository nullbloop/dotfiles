return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip",
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			-- THIS IS THE FIX: Makes the rectangle appear as you type
			completion = {
				autocomplete = { require("cmp.types").cmp.TriggerEvent.TextChanged },
			},
			snippet = {
				expand = function(args) require("luasnip").lsp_expand(args.body) end,
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			},
			mapping = cmp.mapping.preset.insert({
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"]     = cmp.mapping.abort(), -- Closes the rectangle

				-- select = false means it will NOT auto-write the first item.
				-- You must press <Tab> to highlight an item, then <CR> to confirm it.
				["<CR>"]      = cmp.mapping.confirm({ select = false }),

				-- Use Tab to move down the rectangle, Shift-Tab to move up
				["<Tab>"]     = cmp.mapping.select_next_item(),
				["<S-Tab>"]   = cmp.mapping.select_prev_item(),
			}),
		})
	end,
}
