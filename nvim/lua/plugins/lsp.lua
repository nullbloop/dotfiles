return {
        { "williamboman/mason.nvim", opts = {} },

        {
                "williamboman/mason-lspconfig.nvim",
                dependencies = { "williamboman/mason.nvim" },
                opts = {
                        ensure_installed = {
                                "lua_ls", "pyright", "ts_ls", "clangd", "jdtls",
                                "bashls", "html", "cssls", "jsonls", "yamlls", "taplo", "tinymist",
                        },
                        automatic_installation = false,
                        automatic_enable = false,
                },
        },

        {
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                dependencies = { "williamboman/mason.nvim" },
                opts = { ensure_installed = {}, run_on_start = true },
        },

        {
                "neovim/nvim-lspconfig",
                dependencies = { "williamboman/mason-lspconfig.nvim", "hrsh7th/cmp-nvim-lsp" },
                config = function()
                        vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
                        vim.lsp.config("lua_ls", {
                                settings = {
                                        Lua = {
                                                format = {
                                                        defaultConfig = { indent_style = "tab", indent_size = "4" },
                                                },
                                        },
                                },
                        })
                        vim.lsp.enable({
                                "lua_ls", "pyright", "ts_ls", "clangd",
                                "bashls", "html", "cssls", "jsonls", "yamlls", "taplo", "tinymist",
                        })
                end,
        },

        {
                "mfussenegger/nvim-jdtls",
                dependencies = {
                        "williamboman/mason.nvim",
                        "neovim/nvim-lspconfig",
                        "hrsh7th/cmp-nvim-lsp",
                },
                ft = "java",
                config = function()
                        local jdtls = require("jdtls")
                        local mason = vim.fn.stdpath("data") .. "/mason"
                        local java_home = "/usr/lib/jvm/java-27-openjdk"

                        local root = vim.fs.root(0, { "Makefile", "pom.xml", "build.gradle", ".git" })
                                or vim.fn.getcwd()

                        local workspace = vim.fn.stdpath("cache")
                                .. "/jdtls/" .. vim.fn.fnamemodify(root, ":p:h:t")
                        local output = workspace .. "/target/classes"

                        local config_dirs = vim.fn.glob(mason .. "/packages/jdtls/config_*", false, true)

                        local project = vim.fn.filereadable(root .. "/Makefile") == 1
                                and { sourcePaths = { "src" }, outputPath = output }
                                or nil

                        jdtls.start_or_attach({
                                cmd = {
                                        "env",
                                        "JAVA_HOME=" .. java_home,
                                        vim.fn.expand(mason .. "/bin/jdtls"),
                                },
                                root_dir = root,
                                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                                settings = {
                                        java = {
                                                import  = { generatesMetadataFilesAtProjectRoot = false },
                                                project = project,
                                                saveActions = { organizeImports = false },
                                                format = { tabSize = 4, insertSpaces = false },
                                        },
                                },
                                init_options = {
                                        workspace = workspace,
                                        bundles = vim.split(vim.fn.glob(mason .. "/packages/jdtls/plugins/*.jar"), "\n"),
                                },
                                config_dir = config_dirs[1],
                        })
                end,
        },
}
