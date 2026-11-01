return {
        {
                "MeanderingProgrammer/render-markdown.nvim",
                ft = { "markdown" },
                dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
                opts = {
                        heading = {
                                enabled = true, sign = false,
                                icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
                                position = "inline",
                        },
                        link     = { enabled = true, image = "🖼 ", email = "✉ ", hyperlink = "🌐 " },
                        checkbox = { enabled = true, unchecked = { icon = "󰄱 " }, checked = { icon = "󰱒 " } },
                        bullet   = { enabled = true, icons = { "●", "○", "◆", "◇" } },
                        code     = { sign = false, width = "block", right_pad = 1, border = "thin" },
                        indent   = { enabled = true, per_level = 2 },
                        html     = { enabled = true },
                },
                keys = {
                        { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Toggle render" },
                },
        },
        {
                "iamcco/markdown-preview.nvim",
                cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
                ft = { "markdown" },
                build = function()
                        require("lazy").load({ plugins = { "markdown-preview.nvim" } })
                        vim.fn["mkdp#util#install"]()
                end,
                keys = {
                        { "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Browser preview" },
                },
        },
}
