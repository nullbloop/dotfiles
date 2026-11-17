return {
	{ "williamboman/mason.nvim", opts = {} },

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		opts = {
			ensure_installed = {
				-- Exclude lua_ls and jdtls so Mason doesn't install FHS binaries
				"pyright", "ts_ls", "clangd",
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
				cmd = { "lua-language-server" },
			})

			vim.lsp.enable({
				"lua_ls", "nixd", "pyright", "ts_ls", "clangd",
				"bashls", "html", "cssls", "jsonls", "yamlls", "taplo", "tinymist",
			})
		end,
	},

	{
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"neovim/nvim-lspconfig",
			"hrsh7th/cmp-nvim-lsp",
		},
		ft = "java",
		config = function()
			local function start_jdtls()
				local jdtls = require("jdtls")
				local root = vim.fs.root(0, { ".git", "Makefile" }) or vim.fn.getcwd()
				local project_name = vim.fn.fnamemodify(root, ":p:h:t")

				local cache_dir = vim.fn.stdpath("cache") .. "/jdtls"
				local config_dir = cache_dir .. "/config"
				local workspace_dir = cache_dir .. "/workspace/" .. project_name

				-- Find ALL jars in your projects folder + system po-uilib.jar
				local jars = vim.fn.glob(vim.fn.expand("~/projects/**/*.jar"), false, true)
				local po_uilib = vim.fn.glob(vim.fn.expand("~/projects/src/po-uilib-*/po-uilib.jar"), false, true)
				vim.list_extend(jars, po_uilib)
				if vim.fn.filereadable("/usr/share/java/po-uilib.jar") == 1 then
					table.insert(jars, "/usr/share/java/po-uilib.jar")
				end

				local project = vim.fn.filereadable(root .. "/Makefile") == 1
					and {
						sourcePaths = { "erp-app/src", "erp-core/src" },
						outputPath = workspace_dir .. "/target/classes",
						referencedLibraries = { include = jars },
					}
					or nil

				jdtls.start_or_attach({
					cmd = {
						"/run/current-system/sw/bin/jdtls",
						"-configuration", config_dir,
						"-data", workspace_dir,
					},
					root_dir = root,
					capabilities = require("cmp_nvim_lsp").default_capabilities(),

					-- Disable Eclipse formatting so conform/clang-format takes over
					on_attach = function(client, _bufnr)
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentRangeFormattingProvider = false
					end,

					settings = {
						java = {
							import = { generatesMetadataFilesAtProjectRoot = false },
							project = project,
							saveActions = { organizeImports = false },
						},
					},
				})
			end

			-- Attach on the initial Java buffer and every subsequent Java buffer
			start_jdtls()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "java",
				callback = start_jdtls,
			})
		end,
	},
}
