--[[ plug.lua ]]

-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

return require('packer').startup(function(use)
  --[[ Base ]]
  -- Packer can manage itself
  use('wbthomason/packer.nvim')
  -- used by many other plugins
  use('nvim-lua/plenary.nvim')
  -- used by coc.nvim
  use({
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  })
  -- load extensions like VSCode and host language servers
  use({ 'neoclide/coc.nvim', branch = 'release' })

  --[[ Language Server Protocol ]]
  use({
    -- install and manage LSP servers, debuggers and linters.
    'williamboman/mason.nvim',
    -- complement mason with other goodies.
    'williamboman/mason-lspconfig.nvim',
    -- a collection of LSP configs
    'neovim/nvim-lspconfig',
    -- "Use Neovim as a language server to inject LSP diagnostics,
    -- code actions, and more via Lua"
    'jose-elias-alvarez/null-ls.nvim',
    'jayp0521/mason-null-ls.nvim',
  })
  -- tools to automatically set up lspconfig for rust-analyzer
  use('simrat39/rust-tools.nvim')
  -- Completion framework:
  use('hrsh7th/nvim-cmp')
  -- LSP completion source
  use('hrsh7th/cmp-nvim-lsp')
  -- Useful completion sources:
  use('hrsh7th/cmp-buffer')
  use('hrsh7th/cmp-nvim-lsp-signature-help')
  use('hrsh7th/cmp-nvim-lua')
  use('hrsh7th/cmp-path')
  use('hrsh7th/cmp-vsnip')
  use('hrsh7th/vim-vsnip')
  -- ui improvements for lsp
  use({
    'glepnir/lspsaga.nvim',
    branch = 'main',
  })
  -- ts enhancements eg. rename file and update its imports
  use('jose-elias-alvarez/typescript.nvim')

  --[[ theme ]]
  -- start screen
  use({ 'mhinz/vim-startify' })
  -- a custom status line at the bottom of the editor
  use({
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true,
    },
  })
  -- colour theme
  use({ 'shatur/neovim-ayu' })
  -- highlight other instances of word under cursor
  use({ 'rrethy/vim-illuminate' })
  -- icons
  use('kyazdani42/nvim-web-devicons')

  --[[ Editing ]]
  -- multiple cursors
  use({ 'mg979/vim-visual-multi', branch = 'master' })
  -- plugin for splitting/joining blocks of code
  use({
    'Wansmer/treesj',
    requires = { 'nvim-treesitter' },
  })
  -- ys+motion == wrap words with ',',[ etc
  -- ds+motion == remove characters surrounding
  -- ysaW' == surround word with single quotes
  -- dsaW' == remove double quotes from around word
  use('tpope/vim-surround')
  -- MixedCase (crm)
  -- Title Case (crt)
  -- UPPER_CASE (cru)
  -- camelCase (crc)
  -- dash-case (cr-)
  -- dot.case (cr.)
  -- snake_case (crs)
  -- snake_case (crs)
  -- space case (cr<space>)
  use('tpope/vim-abolish')
  -- toggle comments with gc+motion
  use('numToStr/Comment.nvim')
  -- autocomplete closing parens etc
  use({
    'windwp/nvim-autopairs',
  })
  -- autocomplete closing HTML tags
  use('windwp/nvim-ts-autotag')
  -- trim trailing whitespace
  use('cappyzawa/trim.nvim')

  --[[ UI ]]
  -- add icons to autocomplete window
  use('onsails/lspkind.nvim')
  -- show git line modifications on left hand side
  use('lewis6991/gitsigns.nvim')
  -- cursor jump
  use({ 'DanilaMihailov/beacon.nvim' })
  -- make indentation characters visible
  use({ 'Yggdroot/indentLine' })
  -- navigate symbols within a file (vars, functions etc)
  use({ 'majutsushi/tagbar' })
  -- show errors and warnings
  use({
    'folke/trouble.nvim',
    requires = 'kyazdani42/nvim-web-devicons',
  })

  --[[ Navigation ]]
  -- maximise a split pane to be full size
  use('szw/vim-maximizer')
  -- use ctrl+[h,j,k,l] to switch split panes
  use('christoomey/vim-tmux-navigator')
  -- nvim-tree is like NERDTree but written in Lua
  use({
    'kyazdani42/nvim-tree.lua',
    -- icons for nvim-tree
    requires = 'kyazdani42/nvim-web-devicons',
  })
  -- easily hop around files
  use({
    'phaazon/hop.nvim',
    branch = 'v2',
  })
  -- fuzzy finder
  use({
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' } },
  })
  use({
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make',
  })
end)
