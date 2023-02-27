local M = {}

M.treesitter = {
  ensure_installed = {
    'css',
    'graphql',
    'html',
    'javascript',
    'json',
    'lua',
    'rust',
    'typescript',
    'vim',
  },
}

M.mason = {
  ensure_installed = {
    'deno',
    "astro-language-server",
    "bash-language-server",
    "codelldb",
    "css-lsp",
    "emmet-ls",
    "eslint_d",
    "eslint-lsp",
    "graphql-language-service-cli",
    "html-lsp",
    "json-lsp",
    "lua-language-server",
    "prettier",
    "prisma-language-server",
    "rust-analyzer",
    "stylua",
    "tailwindcss-language-server",
    "taplo",
    "typescript-language-server",
    "yaml-language-server",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
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
