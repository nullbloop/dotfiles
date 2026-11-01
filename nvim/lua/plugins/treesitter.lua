return {
        {
                "nvim-treesitter/nvim-treesitter",
                branch = "main",
                lazy = false,
                build = ":TSUpdate",
                config = function()
                        local ts = require("nvim-treesitter")
                        ts.setup()
                        ts.install({
                                "lua", "vim", "vimdoc", "query", "python", "javascript", "typescript",
                                "c", "cpp", "java", "markdown", "markdown_inline", "html",
                                "bash", "yaml", "toml",
                        })
                        vim.api.nvim_create_autocmd("FileType", {
                                pattern = "*",
                                callback = function() pcall(vim.treesitter.start) end,
                        })
                end,
        },
}
