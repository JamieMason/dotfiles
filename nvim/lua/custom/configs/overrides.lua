local M = {}

M.treesitter = {
  ensure_installed = {
    'astro',
    'bash',
    'css',
    'gitcommit',
    'gitignore',
    'graphql',
    'html',
    'javascript',
    'jsdoc',
    'lua',
    'markdown',
    'markdown_inline',
    'rust',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    'lua-language-server',
    'stylua',

    -- web dev stuff
    'css-lsp',
    'deno',
    'graphql-language-service-cli',
    'html-lsp',
    'lua-language-server',
    'prettier',
    'stylua',
    'tailwindcss-language-server',
    'typescript-language-server',
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },
  view = {
    width = 40,
  },
  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
