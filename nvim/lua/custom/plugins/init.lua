local overrides = require('custom.plugins.overrides')

return {
  -- enable dashboard
  ["goolord/alpha-nvim"] = { disable = false }

  -- Override plugin definition options
  ['neovim/nvim-lspconfig'] = {
    config = function()
      require('plugins.configs.lspconfig')
      require('custom.plugins.lspconfig')
    end,
  },

  -- overrde plugin configs
  ['nvim-treesitter/nvim-treesitter'] = {
    override_options = overrides.treesitter,
  },

  ['williamboman/mason.nvim'] = {
    override_options = overrides.mason,
  },

  ['kyazdani42/nvim-tree.lua'] = {
    override_options = overrides.nvimtree,
  },

  -- code formatting, linting etc
  ['jose-elias-alvarez/null-ls.nvim'] = {
    after = 'nvim-lspconfig',
    config = function()
      require('custom.plugins.null-ls')
    end,
  },

  -- List errors/warnings
  ['folke/trouble.nvim'] = {
    requires = 'kyazdani42/nvim-web-devicons',
  },

  -- show indentation characters
  ['Yggdroot/indentLine'] = {},

  -- add, delete, change surrounding text "" [] '' {}
  ['tpope/vim-surround'] = {},

  -- maximizes and restores current window
  ['szw/vim-maximizer'] = {},

  -- tools to automatically set up lspconfig for rust-analyzer
  ['simrat39/rust-tools.nvim'] = {},

  -- remove plugin
  -- ["hrsh7th/cmp-path"] = false,
}
