return {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
        keys = {
                { "]c", "<cmd>Gitsigns next_hunk<cr>",            desc = "Next hunk" },
                { "[c", "<cmd>Gitsigns prev_hunk<cr>",            desc = "Prev hunk" },
                { "<leader>hp", "<cmd>Gitsigns preview_hunk<cr>", desc = "Preview hunk" },
                { "<leader>hs", "<cmd>Gitsigns stage_hunk<cr>",   desc = "Stage hunk" },
                { "<leader>hr", "<cmd>Gitsigns reset_hunk<cr>",   desc = "Reset hunk" },
        },
}
