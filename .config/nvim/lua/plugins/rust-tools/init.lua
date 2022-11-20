local rt = require("rust-tools")

-- setup Neovim so that it can interact with rust-analyzer.
-- We can use the code provided in the example config recommended by the 
-- rust-tools.vim plugin
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

