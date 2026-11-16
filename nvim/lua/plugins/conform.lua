return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true, lsp_format = "fallback" })
			end,
			mode = { "n", "v" },
			desc = "Format",
		},
	},
	opts = {
		-- THIS IS THE MISSING PIECE: Triggers format when you save
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "fallback",
		},
		default_format_opts = {
			timeout_ms = 3000,
			async = false,
			quiet = false,
			lsp_format = "fallback",
		},
		formatters_by_ft = {
			html = { "prettier" },
			css = { "prettier" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			java = { "clang_format" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			nix = { "nixfmt-rfc-style" },
		},
		formatters = {
			prettier = {
				prepend_args = { "--use-tabs", "--tab-width", "4" },
			},
			clang_format = {
				prepend_args = {
					"--style={BasedOnStyle: LLVM, UseTab: Always, IndentWidth: 4, TabWidth: 4}",
				},
			},
		},
	},
}
