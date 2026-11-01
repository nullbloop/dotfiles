return {
        {
                "mikavilpas/yazi.nvim",
                version = "*",
                event = "VeryLazy",
                dependencies = { "nvim-lua/plenary.nvim" },
                keys = {
                        { "<leader>-",  "<cmd>Yazi<cr>",        desc = "Yazi at file" },
                        { "<leader>cw", "<cmd>Yazi cwd<cr>",    desc = "Yazi in cwd" },
                        { "<c-up>",     "<cmd>Yazi toggle<cr>", desc = "Resume Yazi" },
                },
                opts = { open_for_directories = false, keymaps = { show_help = "<f1>" } },
        },
}
