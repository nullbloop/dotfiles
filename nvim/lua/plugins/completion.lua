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
                        completion = {
                                autocomplete = false, -- STOPS THE ANNOYING POPUPS
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
                                ["<C-Space>"] = cmp.mapping.complete(), -- Manually trigger
                                ["<C-e>"]     = cmp.mapping.abort(),
                                ["<CR>"]      = cmp.mapping.confirm({ select = false }),
                                ["<Tab>"]     = cmp.mapping.select_next_item(),
                                ["<S-Tab>"]   = cmp.mapping.select_prev_item(),
                        }),
                })
        end,
}
