return {
        {
                "catppuccin/nvim",
                name = "catppuccin",
                lazy = false,
                priority = 1000,
                config = function()
                        require("catppuccin").setup({
                                flavour = "mocha",
                                term_colors = true,
                                integrations = {
                                        cmp = true, gitsigns = true, neotree = true,
                                        treesitter = true, telescope = { enabled = true },
                                        which_key = true, indent_blankline = { enabled = true },
                                        native_lsp = {
                                                enabled = true,
                                                virtual_text = { errors = { "italic" }, hints = { "italic" } },
                                                underlines = { errors = { "underline" }, hints = { "underline" } },
                                        },
                                        markdown = true,
                                },
                        })
                        vim.cmd.colorscheme("catppuccin")
                end,
        },
        { "HiPhish/rainbow-delimiters.nvim", event = "VeryLazy" },
        {
                "lukas-reineke/indent-blankline.nvim",
                main = "ibl",
                event = { "BufReadPre", "BufNewFile" },
                opts = {
                        indent = { char = "│" },
                        scope = { enabled = true, show_start = false, show_end = false },
                },
        },
        {
                "folke/which-key.nvim",
                event = "VeryLazy",
                config = function()
                        require("which-key").setup({ preset = "helix" })
                        require("which-key").add({ { "<leader>t", group = "Tabs" } })
                end,
        },
        {
                "nvim-treesitter/nvim-treesitter-context",
                event = { "BufReadPre", "BufNewFile" },
                config = function()
                        require("treesitter-context").setup({ enable = true, max_lines = 0, mode = "cursor" })
                        vim.keymap.set("n", "<leader>tc", function()
                                require("treesitter-context").toggle()
                        end, { desc = "Toggle context" })
                end,
        },
}
