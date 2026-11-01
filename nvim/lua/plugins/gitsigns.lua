return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {},
	keys = {
		{ "<leader>hj", "<cmd>Gitsigns next_hunk<cr>",    desc = "Next git hunk" },
		{ "<leader>hk", "<cmd>Gitsigns prev_hunk<cr>",    desc = "Prev git hunk" },
		{ "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
		{ "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>",   desc = "Stage hunk" },
		{ "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>",   desc = "Reset hunk" },
	},
}
