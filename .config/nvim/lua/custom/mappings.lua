local M = {}

M.windowManagement = {
  n = {
    ['<leader>sv'] = { '<C-w>v', 'split window vertically' },
    ['<leader>sh'] = { '<C-w>s', 'split window horizontally' },
    ['<leader>se'] = { '<C-w>=', 'make split windows equal width & height' },
    ['<leader>sx'] = { ':close<CR>', 'close current split window' },
    ['<leader>sm'] = { ':MaximizerToggle<CR>', 'toggle split window maximization' },
  },
}

M.disabled = {
  n = {
    -- conflicts with trouble mappings, remap to <leader>X
    ['<leader>x'] = '',
  },
}

M.trouble = {
  n = {
    ['<leader>xx'] = { '<cmd>Trouble<cr>', 'Trouble: Toggle' },
    ['<leader>xw'] = { '<cmd>Trouble workspace_diagnostics<cr>', 'Trouble: Workspace Diagnostics' },
    ['<leader>xd'] = { '<cmd>Trouble document_diagnostics<cr>', 'Trouble: Document Diagnostics' },
    ['<leader>xl'] = { '<cmd>Trouble loclist<cr>', 'Trouble: Location List' },
    ['<leader>xq'] = { '<cmd>Trouble quickfix<cr>', 'Trouble: Quick Fix' },
    ['gR'] = { '<cmd>Trouble lsp_references<cr>', 'Trouble: LSP References' },
  },
}

M.tabufline = {
  n = {
    -- close buffer + hide terminal buffer
    ['<leader>X'] = {
      function()
        require('nvchad_ui.tabufline').close_buffer()
      end,
      'close buffer',
    },
  },
}

return M
