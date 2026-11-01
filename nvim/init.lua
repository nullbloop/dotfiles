-- ENVIRONMENT & BOOTSTRAP

local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
vim.env.PATH = mason_bin .. ":/usr/bin:/usr/local/bin:" .. vim.env.PATH
for _, p in ipairs({ "node", "perl", "python3", "ruby" }) do
        vim.g["loaded_" .. p .. "_provider"] = 0
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
        vim.fn.system({
                "git", "clone", "--filter=blob:none",
                "https://github.com/folke/lazy.nvim.git",
                "--branch=stable", lazypath,
        })
end
vim.opt.rtp:prepend(lazypath)

-- LEADER KEYS --
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- CONFIG MODULES

require("config.options")
require("config.keymaps")
require("config.lsp-attach")

-- PLUGINS

require("lazy").setup("plugins")
