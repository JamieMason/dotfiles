require("mason").setup()

require("mason-lspconfig").setup({
  -- auto-install configured servers (with lspconfig)
  -- not the same as ensure_installed
  automatic_installation = true, 
  -- list of servers for mason to install
  ensure_installed = {
    -- https://astro.build
    'astro',
    -- Bash/Shell
    'bashls',
    -- https://github.com/vadimcn/vscode-lldb
    -- 'codelldb',
    -- CSS
    'cssls',
    -- https://emmet.io
    'emmet_ls',
    -- https://eslint.org
    'eslint',
    -- GraphQL
    'graphql',
    -- HTML
    'html',
    -- JSON
    'jsonls',
    -- https://prettier.io
    -- 'prettier',
    -- https://www.prisma.io/
    'prismals',
    -- Rust
    'rust_analyzer',
    -- Lua
    'sumneko_lua',
    -- https://tailwindcss.com
    'tailwindcss',
    -- https://toml.io
    'taplo',
    -- TypeScript
    'tsserver',
    -- Yaml
    'yamlls',
    -- Markdown
    'zk',
  }
})

require('mason-null-ls').setup({
  -- auto-install configured formatters & linters (with null-ls)
  automatic_installation = true,
  -- list of formatters & linters for mason to install
  ensure_installed = {
    "prettier", -- ts/js formatter
    "stylua", -- lua formatter
    "eslint_d", -- ts/js linter
  },
})
