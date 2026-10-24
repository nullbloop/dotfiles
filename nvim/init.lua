-- ===============================================
-- ENVIRONMENT & BOOTSTRAP
-- ===============================================
vim.env.PATH = "/usr/bin:/usr/local/bin:" .. vim.env.PATH
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- ===============================================
-- OPTIONS & CLIPBOARD
-- ===============================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.expandtab = false
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.termguicolors = true
opt.clipboard = "unnamedplus"
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- Global Diagnostics Config
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- OSC 52 Clipboard Support (fixes for copying when sshing)
vim.g.clipboard = {
	name = "OSC 52",
	copy = {
		["+"] = require("vim.ui.clipboard.osc52").copy("+"),
		["*"] = require("vim.ui.clipboard.osc52").copy("*"),
	},
	paste = {
		["+"] = require("vim.ui.clipboard.osc52").paste("+"),
		["*"] = require("vim.ui.clipboard.osc52").paste("*"),
	},
}

-- ===============================================
-- GLOBAL KEYMAPS & LSP ATTACH
-- ===============================================
vim.keymap.set({ "n", "v", "o" }, "<A-j>", "}", { desc = "Next paragraph" })
vim.keymap.set({ "n", "v", "o" }, "<A-k>", "{", { desc = "Previous paragraph" })
vim.keymap.set("n", "<leader>m", "%", { desc = "Match bracket" })
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, remap = false }
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	end,
})

-- ===============================================
-- PLUGINS
-- ===============================================
require("lazy").setup({
	-- Catppuccin Theme
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
					cmp = true,
					gitsigns = true,
					neotree = true,
					treesitter = true,
					telescope = { enabled = true },
					which_key = true,
					indent_blankline = { enabled = true },
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

	-- Rainbow Delimiters
	{ "HiPhish/rainbow-delimiters.nvim", event = "VeryLazy" },

	-- Indent Blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("ibl").setup({
				indent = { char = "│" },
				scope = { enabled = true, show_start = false, show_end = false },
			})
		end,
	},

	-- Which-Key
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("which-key").setup({ preset = "helix" })
		end,
	},

	-- Treesitter Context
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

	-- Render Markdown
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown" },
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {
			heading = {
				enabled = true,
				sign = false,
				icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
				position = "inline",
			},
			link = { enabled = true, image = "🖼 ", email = "✉ ", hyperlink = "🌐 " },
			checkbox = { enabled = true, unchecked = { icon = "󰄱 " }, checked = { icon = "󰱒 " } },
			bullet = { enabled = true, icons = { "●", "○", "◆", "◇" } },
			code = { sign = false, width = "block", right_pad = 1, border = "thin" },
			indent = { enabled = true, per_level = 2 },
			html = { enabled = true },
		},
		keys = {
			{ "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Toggle Markdown" },
		},
	},

	-- Markdown Preview in Browser
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			require("lazy").load({ plugins = { "markdown-preview.nvim" } })
			vim.fn["mkdp#util#install"]()
		end,
		keys = {
			{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", ft = "markdown", desc = "Markdown Preview (Browser)" },
		},
	},

	-- Neo-tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "MunifTanjim/nui.nvim" },
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				filesystem = {
					follow_current_file = { enabled = true },
					use_libuv_file_watcher = true,
					filtered_items = { visible = true, hide_dotfiles = false, hide_gitignored = true },
				},
			})
			vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })
			vim.keymap.set("n", "<leader>o", ":Neotree focus<CR>", { desc = "Focus file explorer" })
		end,
	},

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "List buffers" })
			vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Find files" })
			vim.keymap.set("n", "<leader>g", builtin.live_grep, { desc = "Live grep" })
		end,
	},

	-- Typst Preview
	{
		"chomosuke/typst-preview.nvim",
		ft = "typst",
		version = "1.*",
		opts = {},
		keys = {
			{ "<leader>tp", "<cmd>TypstPreviewToggle<cr>",     desc = "Toggle Typst Preview" },
			{ "<leader>ts", "<cmd>TypstPreviewSyncCursor<cr>", desc = "Sync Typst Preview" },
		},
	},

	-- Yazi
	{
		"mikavilpas/yazi.nvim",
		version = "*",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>-",  "<cmd>Yazi<cr>",        desc = "Open Yazi at current file" },
			{ "<leader>cw", "<cmd>Yazi cwd<cr>",    desc = "Open Yazi in working directory" },
			{ "<c-up>",     "<cmd>Yazi toggle<cr>", desc = "Resume Yazi" },
		},
		opts = { open_for_directories = false, keymaps = { show_help = "<f1>" } },
	},

	-- Mason
	{ "williamboman/mason.nvim",         opts = {} },

	-- Mason-LSPConfig
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls", "pyright", "ts_ls", "rust_analyzer", "clangd", "jdtls",
					"bashls", "html", "cssls", "jsonls", "yamlls", "taplo", "tinymist",
				},
				automatic_installation = false,
				automatic_enable = false,
			})
		end,
	},

	-- Mason Tool Installer
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {},
				run_on_start = true,
			})
		end,
	},

	-- LSPConfig
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = function()
			vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						format = {
							defaultConfig = {
								indent_style = "tab",
								indent_size = "4",
							},
						},
					},
				},
			})

			vim.lsp.enable({
				"lua_ls", "pyright", "ts_ls", "rust_analyzer", "clangd",
				"bashls", "html", "cssls", "jsonls", "yamlls", "taplo", "tinymist",
			})
		end,
	},

	-- Nvim-JDTLS
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
			local mason_path = vim.fn.stdpath("data") .. "/mason"
			local java_home = "/usr/lib/jvm/java-27-openjdk"

			-- Detect project root using the Makefile
			local root_dir = vim.fs.root(0, { "Makefile", "pom.xml", "build.gradle", ".git" })
			if not root_dir then
				root_dir = vim.fn.getcwd()
			end

			-- Hidden workspace directory inside Neovim's cache
			local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

			-- Tell JDTLS to put compiled .class files HERE instead of a local "bin" folder
			local output_dir = workspace_dir .. "/target/classes"

			jdtls.start_or_attach({
				cmd = {
					"env",
					"JAVA_HOME=" .. java_home,
					vim.fn.expand(mason_path .. "/bin/jdtls"),
				},
				root_dir = root_dir,
				capabilities = require("cmp_nvim_lsp").default_capabilities(),
				settings = {
					java = {
						import = {
							-- Prevents .classpath and .project from being created
							generatesMetadataFilesAtProjectRoot = false,
						},
						project = {
							-- Tells JDTLS that 'src' is the root for your packages
							sourcePaths = { "src" },
							-- Tells JDTLS to put compiled classes in the cache, NOT your folder
							outputPath = output_dir,
						},
						saveActions = {
							organizeImports = false,
						},
						format = {
							tabSize = 4,
							insertSpaces = false,
						},
					},
				},
				init_options = {
					workspace = workspace_dir,
					bundles = vim.split(vim.fn.glob(mason_path .. "/packages/jdtls/plugins/*.jar"), "\n"),
				},
				configuration = vim.fn.glob(mason_path .. "/packages/jdtls/config_*"),
			})
		end,
	},

	-- Treesitter
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
				"rust", "go", "c", "cpp", "java", "markdown", "markdown_inline", "html",
				"bash", "yaml", "toml",
			})
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "*",
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},

	-- UFO
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async", "nvim-treesitter/nvim-treesitter" },
		event = "BufReadPost",
		config = function()
			vim.o.foldcolumn = "1"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
			vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
			require("ufo").setup({ provider_selector = function() return { "treesitter", "indent" } end })
		end,
	},

	-- nvim-lint
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = {
				markdown = { "markdownlint" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				python = { "ruff" },
				cpp = { "cppcheck" },
				c = { "cppcheck" },
				sh = { "shellcheck" },
				bash = { "shellcheck" },
				lua = { "luacheck" },
			}
			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
				callback = function() require("lint").try_lint(nil, { ignore_errors = true }) end,
			})
		end,
	},

	-- Conform (Formatting with Tabs enforced)
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		keys = {
			{
				"<leader>fm",
				function()
					require("conform").format({ async = true, lsp_format = "fallback", timeout_ms = 3000 })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				go = { "gofmt", "goimports" },
				rust = { "rustfmt" },
				c = { "clang-format" },
				cpp = { "clang-format" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				html = { "prettierd" },
				css = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				toml = { "taplo" },
				typst = { "typstyle" },
			},
			format_on_save = { timeout_ms = 3000, lsp_format = "fallback" },
			formatters = {
				stylua = { prepend_args = { "--indent-type", "Tabs", "--indent-width", "4" } },
				prettierd = { prepend_args = { "--use-tabs" } },
				rustfmt = { prepend_args = { "--config", "hard_tabs=true,tab_spaces=4" } },
				["clang-format"] = {
					prepend_args = { "-style={BasedOnStyle: Google, UseTab: Always, IndentWidth: 4, TabWidth: 4}" },
				},
			},
		},
	},

	-- Trouble
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Trouble",
		opts = {},
		keys = {
			{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics" },
			{ "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Buffer Diagnostics" },
			{ "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols" },
			{ "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP References" },
			{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix List" },
		},
	},

	-- Tiny Inline Diagnostic
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		config = function()
			require("tiny-inline-diagnostic").setup({ preset = "modern" })
		end,
	},

	-- nvim-cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "L3MON4D3/LuaSnip" },
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				completion = { completeopt = "menu,menuone,noselect" },
				mapping = cmp.mapping.preset.insert({
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),
				sources = { { name = "nvim_lsp" }, { name = "buffer" }, { name = "path" } },
			})
		end,
	},

	-- Autopairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function() require("nvim-autopairs").setup({}) end,
	},

	-- Mini.Surround
	{
		"echasnovski/mini.surround",
		version = false,
		config = function()
			require("mini.surround").setup({
				mappings = { add = "sa", delete = "sd", find = "sf", find_left = "sF", highlight = "sh", replace = "sr", update_n_lines = "sn" },
			})
		end,
	},

	-- Gitsigns
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns
					local function map(mode, l, r, desc) vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc }) end
					map("n", "<C-j>", gs.next_hunk, "Next git hunk")
					map("n", "<C-k>", gs.prev_hunk, "Previous git hunk")
					map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
					map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
					map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
					map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
				end,
			})
		end,
	},

	-- Undotree
	{
		"mbbill/undotree",
		keys = { { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle undotree" } },
		config = function() vim.g.undotree_WindowLayout = 2 end,
	},

	-- Todo Comments
	{ "folke/todo-comments.nvim", event = { "BufReadPre", "BufNewFile" }, opts = {} },

	-- Cord
	{ "vyfor/cord.nvim",          build = ":Cord update",                 event = "VeryLazy" },

	-- Live Share
	{
		"azratul/live-share.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "jbyuki/instant.nvim" },
		config = function() require("live-share").setup({ username = "sillymamaco" }) end,
	},
}, { rocks = { enabled = false } })

-- ===============================================
-- AUTO-RELOAD INIT.LUA & RESTART LSPS
-- ===============================================
vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = "init.lua",
	callback = function()
		-- 1. Stop all LSPs
		for _, client in ipairs(vim.lsp.get_clients()) do
			client:stop(true)
		end

		-- 2. Reload config and wake the LSPs back up
		vim.defer_fn(function()
			vim.cmd("source $MYVIMRC")
			vim.notify("init.lua reloaded & LSPs restarted!", vim.log.levels.INFO)
			vim.cmd("doautocmd FileType")
		end, 500)
	end,
})
