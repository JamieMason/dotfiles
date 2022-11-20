--[[ plug.lua ]]

return require('packer').startup(function(use)

  --[[ Base ]]
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- used by many other plugins
  use 'nvim-lua/plenary.nvim'
  -- used by coc.nvim
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  -- load extensions like VSCode and host language servers
  use {'neoclide/coc.nvim', branch = 'release'}
  use {
    -- install and manage LSP servers, debuggers and linters.
    'williamboman/mason.nvim',
    -- complement mason with other goodies.
    'williamboman/mason-lspconfig.nvim',
    -- a collection of LSP configs
    'neovim/nvim-lspconfig',
  }
  -- tools to automatically set up lspconfig for rust-analyzer
  use 'simrat39/rust-tools.nvim'
  -- Completion framework:
  use 'hrsh7th/nvim-cmp'
  -- LSP completion source
  use 'hrsh7th/cmp-nvim-lsp'
  -- Useful completion sources:
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/vim-vsnip'

  --[[ Theme ]]
  -- start screen
  use { 'mhinz/vim-startify' }
  -- cursor jump
  use { 'DanilaMihailov/beacon.nvim' }
  -- a custom status line at the bottom of the editor
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true
    }
  }
  -- colour theme
  use { 'Shatur/neovim-ayu' }
  -- Highlight other instances of word under cursor
  use { 'RRethy/vim-illuminate' }
  -- icons
  use 'kyazdani42/nvim-web-devicons'
  --[[ Dev ]]
  -- ys+motion == wrap words with ',",[ etc
  -- ds+motion == remove characters surrounding
  -- ysaW' == surround word with single quotes
  -- dsaW" == remove double quotes from around word
  use 'tpope/vim-surround'
  -- toggle comments with gc+motion
  use 'numToStr/Comment.nvim'
  -- navigate symbols within a file (vars, functions etc)
  use { 'majutsushi/tagbar' }
  -- make indentation characters visible
  use { 'Yggdroot/indentLine' }
  -- autocomplete closing parens etc
  use {
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup {} end
  }
  -- show errors and warnings
  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons"
  }
  -- trim trailing whitespace
  use 'cappyzawa/trim.nvim'
  --[[ Navigation ]]
  -- maximise a split pane to be full size
  use 'szw/vim-maximizer'
  -- use ctrl+[h,j,k,l] to switch split panes
  use 'christoomey/vim-tmux-navigator'
  -- nvim-tree is like NERDTree but written in Lua
  use {
    'kyazdani42/nvim-tree.lua',
    -- icons for nvim-tree
    requires = 'kyazdani42/nvim-web-devicons'
  }
  -- easily hop around files
  use {
    'phaazon/hop.nvim',
    branch = 'v2'
  }
  -- fuzzy finder
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

end)
