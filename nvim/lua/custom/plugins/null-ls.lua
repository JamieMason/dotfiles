local present, null_ls = pcall(require, 'null-ls')

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt,
  b.formatting.prettier.with({
    filetypes = {
      'css',
      'graphql',
      'html',
      'javascript',
      'javascriptreact',
      'json',
      'less',
      'markdown',
      'scss',
      'typescript',
      'typescriptreact',
      'yaml',
    },
  }),

  -- Lua
  b.formatting.stylua,

  -- Shell
  b.formatting.shfmt,
  b.diagnostics.shellcheck.with({ diagnostics_format = '#{m} [#{c}]' }),

  -- cpp
  b.formatting.clang_format,
  b.formatting.rustfmt,

  -- Diagnostics  ---------------------
  b.diagnostics.eslint.with({
    prefer_local = 'node_modules/.bin',
  }),

  -- code actions ---------------------
  b.code_actions.gitsigns,
  b.code_actions.eslint.with({
    prefer_local = 'node_modules/.bin',
  }),
}

null_ls.setup({
  debug = true,
  sources = sources,
})
