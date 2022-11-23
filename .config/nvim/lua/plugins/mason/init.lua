require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    -- https://astro.build
    'astro-language-server',
    -- Bash/Shell
    'bashls',
    -- https://github.com/vadimcn/vscode-lldb
    'codelldb',
    -- CSS
    'cssls',
    -- https://emmet.io
    'emmet_ls',
    -- https://eslint.org
    'eslint',
    -- GraphQL
    'graphql-language-service-cli',
    -- HTML
    'html',
    -- JSON
    'jsonls',
    -- https://prettier.io
    'prettier',
    -- https://www.prisma.io/
    'prisma-language-server',
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
