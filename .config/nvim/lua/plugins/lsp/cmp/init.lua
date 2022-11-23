-- Completion Plugin Setup
local cmp = require('cmp')

cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },

  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- show completion suggestions
    ['<C-Space>'] = cmp.mapping.complete(),
    -- close completion window
    ['<C-e>'] = cmp.mapping.close(),
    -- choose suggestion on enter
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },

  -- Installed sources:
  sources = {
    { name = 'path' }, -- file paths
    { name = 'nvim_lsp', keyword_length = 3 }, -- from language server
    { name = 'nvim_lsp_signature_help' }, -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 }, -- source current buffer
    { name = 'vsnip', keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
    { name = 'calc' }, -- source for math calculation
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  -- configure lspkind for vs-code like icons
  formatting = {
    format = require('lspkind').cmp_format({
      maxwidth = 50,
      ellipsis_char = '...',
    }),
  },
})
