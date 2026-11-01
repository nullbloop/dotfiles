return {
        {
                "chomosuke/typst-preview.nvim",
                ft = "typst",
                version = "1.*",
                opts = {},
                keys = {
                        { "<leader>tp", "<cmd>TypstPreviewToggle<cr>",     desc = "Preview" },
                        { "<leader>ts", "<cmd>TypstPreviewSyncCursor<cr>", desc = "Sync cursor" },
                },
        },
}
