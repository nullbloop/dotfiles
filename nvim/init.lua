-- Make sure system binaries like curl, tar, and git are visible to Neovim
vim.env.PATH = "/usr/bin:/usr/local/bin:" .. vim.env.PATH

-- Silence "optional provider" warnings for languages we don't use as remote plugins
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- =========================================================================
-- 1. BOOTSTRAP LAZY.NVIM
-- =========================================================================
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

-- =========================================================================
-- 2. BASIC OPTIONS
-- =========================================================================
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true
opt.termguicolors = true
opt.clipboard = "unnamedplus"

-- Soft-wrap long lines at word boundaries
opt.wrap = true
opt.linebreak = true
opt.breakindent = true

-- =========================================================================
-- 3. PORTUGUESE LAYOUT REMAPS
-- =========================================================================
vim.keymap.set({ "n", "v", "o" }, "<A-j>", "}", { desc = "Next paragraph" })
vim.keymap.set({ "n", "v", "o" }, "<A-k>", "{", { desc = "Previous paragraph" })
vim.keymap.set("n", "<leader>m", "%", { desc = "Match bracket" })

-- Yank to system clipboard explicitly
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", '"+Y', { desc = "Yank line to system clipboard" })

-- =========================================================================
-- 4. PLUGINS
-- =========================================================================
require("lazy").setup({
  -- ----------------------------------------------------------------
  -- THEME: catppuccin
  -- ----------------------------------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
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
          notify = false,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- ----------------------------------------------------------------
  -- RAINBOW DELIMITERS
  -- ----------------------------------------------------------------
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
  },

  -- ----------------------------------------------------------------
  -- FILE EXPLORER
  -- ----------------------------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          follow_current_file = { enabled = true },
          use_libuv_file_watcher = true,
        },
      })
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })
      vim.keymap.set("n", "<leader>o", ":Neotree focus<CR>", { desc = "Focus file explorer" })
    end,
  },

  -- ----------------------------------------------------------------
  -- WHICH-KEY
  -- ----------------------------------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      require("which-key").setup({ preset = "helix" })
    end,
  },

  -- ----------------------------------------------------------------
  -- MASON
  -- ----------------------------------------------------------------
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Formatters
        "stylua",
        "black",
        "isort",
        "prettier",
        "goimports",
        "gofumpt",
        "clang-format",
        "shfmt",
        "taplo",
        "rustfmt",
        "google-java-format",
        "typstyle",
        -- Linters
        "eslint_d",
        "ruff",
        "cppcheck",
        "shellcheck",
        "luacheck",
        "markdownlint",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ts_ls",
          "gopls",
          "rust_analyzer",
          "clangd",
          "jdtls",
          "bashls",
          "html",
          "cssls",
          "jsonls",
          "yamlls",
          "taplo",
          "tinymist",
        },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function() end,
  },

  -- ----------------------------------------------------------------
  -- TREESITTER (main branch)
  -- ----------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    main = "nvim-treesitter.config",
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup()
      ts.install({ "all" })
    end,
  },

  -- ----------------------------------------------------------------
  -- TREESITTER CONTEXT
  -- ----------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("treesitter-context").setup({
        enable = true,
        max_lines = 0,
        min_window_height = 0,
        line_numbers = true,
        multiline_threshold = 20,
        trim_scope = "outer",
        mode = "cursor",
        zindex = 20,
        separator = nil,
        on_attach = nil,
      })
      vim.keymap.set("n", "<leader>tc", function()
        require("treesitter-context").toggle()
      end, { desc = "Toggle treesitter context" })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
    keys = {
      { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Toggle Markdown rendering" },
    },
  },
  -- ----------------------------------------------------------------
  -- UFO
  -- ----------------------------------------------------------------
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufReadPost",
    config = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Open folds except kinds" })
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Close folds with kind" })
      vim.keymap.set("n", "K", function()
        local winid = require("ufo").peekFoldedLinesUnderCursor()
        if not winid then
          vim.lsp.buf.hover()
        end
      end, { desc = "Peek fold / LSP hover" })

      require("ufo").setup({
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = ("  ⋯ %d "):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          table.insert(newVirtText, { suffix, "MoreMsg" })
          return newVirtText
        end,
      })
    end,
  },

  -- ----------------------------------------------------------------
  -- TROUBLE
  -- ----------------------------------------------------------------
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (workspace)" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Diagnostics (buffer)" },
      { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Symbols" },
      { "<leader>xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP references / defs" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix list" },
    },
    opts = {},
  },

  -- ----------------------------------------------------------------
  -- UNDOTREE
  -- ----------------------------------------------------------------
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle undotree" },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SplitWidth = 35
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },

  -- ----------------------------------------------------------------
  -- LINTING
  -- ----------------------------------------------------------------
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        markdown        = { "markdownlint" },
        javascript      = { "eslint_d" },
        typescript      = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        python          = { "ruff" },
        cpp             = { "cppcheck" },
        c               = { "cppcheck" },
        sh              = { "shellcheck" },
        bash            = { "shellcheck" },
        lua             = { "luacheck" },
      }

      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },

  -- ----------------------------------------------------------------
  -- FORMATTING
  -- ----------------------------------------------------------------
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>fm",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua             = { "stylua" },
        python          = { "isort", "black" },
        javascript      = { "prettier" },
        typescript      = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        go              = { "gofmt", "goimports" },
        rust            = { "rustfmt" },
        c               = { "clang-format" },
        cpp             = { "clang-format" },
        java            = { "google-java-format" },
        sh              = { "shfmt" },
        bash            = { "shfmt" },
        html            = { "prettier" },
        css             = { "prettier" },
        json            = { "prettier" },
        yaml            = { "prettier" },
        markdown        = { "prettier" },
        toml            = { "taplo" },
        typst           = { "typstyle" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- ----------------------------------------------------------------
  -- DISCORD RICH PRESENCE
  -- ----------------------------------------------------------------
  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    event = "VeryLazy",
  },

  -- ----------------------------------------------------------------
  -- AUTOCOMPLETION
  -- ----------------------------------------------------------------
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      cmp.setup({
        completion = { completeopt = "menu,menuone,noselect" },
        mapping = {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      })
    end,
  },

  -- ----------------------------------------------------------------
  -- AUTO-CLOSING BRACKETS
  -- ----------------------------------------------------------------
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({})
    end,
  },

  -- ----------------------------------------------------------------
  -- MINI.SURROUND
  -- ----------------------------------------------------------------
  {
    "echasnovski/mini.surround",
    version = false,
    config = function()
      require("mini.surround").setup({
        mappings = {
          add = "sa",
          delete = "sd",
          find = "sf",
          find_left = "sF",
          highlight = "sh",
          replace = "sr",
          update_n_lines = "sn",
        },
      })
    end,
  },

  -- ----------------------------------------------------------------
  -- INDENT GUIDES
  -- ----------------------------------------------------------------
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

  -- ----------------------------------------------------------------
  -- TODO COMMENTS
  -- ----------------------------------------------------------------
  {
    "folke/todo-comments.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("todo-comments").setup({})
      vim.keymap.set("n", "<leader>td", function()
        require("todo-comments").todo_comments_telescope()
      end, { desc = "List TODOs" })
    end,
  },

  -- ----------------------------------------------------------------
  -- TELESCOPE
  -- ----------------------------------------------------------------
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

  -- ----------------------------------------------------------------
  -- LIVE SHARE
  -- ----------------------------------------------------------------
  {
    "azratul/live-share.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "jbyuki/instant.nvim",
    },
    config = function()
      require("live-share").setup({
        username = "sillymamaco",
      })
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000, -- Load before other plugins
    config = function()
      require("tiny-inline-diagnostic").setup({
        preset = "modern", -- or "classic", "minimal", "powerline", etc.
      })
      -- Disable the default virtual text to prevent duplication
      vim.diagnostic.config({ virtual_text = false })
    end,
  },
  {
    "mikavilpas/yazi.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>-",  "<cmd>Yazi<cr>",        desc = "Open Yazi at current file" },
      { "<leader>cw", "<cmd>Yazi cwd<cr>",    desc = "Open Yazi in working directory" },
      { "<c-up>",     "<cmd>Yazi toggle<cr>", desc = "Resume last Yazi session" },
    },
    opts = {
      open_for_directories = false,
      keymaps = { show_help = "<f1>" },
    },
  },
  -- ----------------------------------------------------------------
  -- GIT SIGNS
  -- ----------------------------------------------------------------
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
        current_line_blame = false,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, desc)
            vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
          end
          map("n", "<C-j>", function()
            if vim.wo.diff then return "<C-j>" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, "Next git hunk")
          map("n", "<C-k>", function()
            if vim.wo.diff then return "<C-k>" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, "Previous git hunk")
          map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
          map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, "Stage hunk")
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, "Reset hunk")
          map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
          map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
          map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
          map("n", "<leader>hd", gs.diffthis, "Diff this")
          map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff this ~")
          map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle line blame")
        end,
      })
    end,
  },
}, {
  rocks = { enabled = false },
})
