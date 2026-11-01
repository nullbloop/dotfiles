return {
        {
                "nvim-telescope/telescope.nvim",
                dependencies = { "nvim-lua/plenary.nvim" },
                config = function()
                        local b = require("telescope.builtin")
                        vim.keymap.set("n", "<leader>b", b.buffers,    { desc = "Buffers" })
                        vim.keymap.set("n", "<leader>f", b.find_files, { desc = "Find files" })
                        vim.keymap.set("n", "<leader>g", b.live_grep,  { desc = "Live grep" })
                end,
        },
}
