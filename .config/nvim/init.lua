--[[ init.lua ]]

local g = vim.g

-- LEADER
--
-- These mappings allow you to set a prefix key that, when pressed, will
-- activate a set of mappings that you can use to quickly run certain commands
--
-- * `vim.g.mapleader` works across all files you edit in Neovim
-- * `vim.g.localleader` works for specific file types, like a .py or .sh
--
-- It's a good idea to set these leader keys before any other variables to
-- ensure that they're mapped correctly and are ready to work with any plugins
-- you install
vim.g.mapleader = ","
vim.g.localleader = "\\"

-- disable netrw at the very start of your init.lua (strongly advised)
-- (https://github.com/nvim-tree/nvim-tree.lua#setup)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- IMPORTS
-- Variables
require('vars')
-- Options
require('opts')
-- Keymaps
require('keys')
-- Plugins
require('plug')

-- Setup
require('Comment').setup()
require('nvim-web-devicons').setup()
require('plugins/coc/init')
require('plugins/hop/init')
require('plugins/lsp/cmp/init')
require('plugins/lsp/lspconfig/init')
require('plugins/lsp/lspsaga/init')
require('plugins/lsp/mason/init')
require('plugins/lsp/null-ls/init')
require('plugins/lualine/init')
require('plugins/neovim-ayu/init')
require('plugins/nvim-autopairs/init')
require('plugins/nvim-tree/init')
require('plugins/nvim-treesitter/init')
require('plugins/rust-tools/init')
require('plugins/telescope/init')
require('plugins/trouble/init')
