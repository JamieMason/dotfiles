local present, null_ls = pcall(require, 'null-ls')

if not present then
  return
end

local b = null_ls.builtins

local sources = {
  b.formatting.prettier.with({
    filetypes = {
      'astro',
      'css',
      'graphql',
      'html',
      'javascript',
      'javascriptreact',
      'json',
      'markdown',
      'typescript',
      'typescriptreact',
      'yaml',
    },
  }), -- so prettier works only on these filetypes
  -- Lua
  b.formatting.stylua,
}

null_ls.setup({
  debug = true,
  sources = sources,
})
