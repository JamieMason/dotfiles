-- require('nvim-treesitter.configs').setup({
-- 	ensure_installed = { 'lua', 'rust', 'toml', 'astro', 'css', 'html', 'javascript', 'json', 'typescript' },
-- 	auto_install = true,
-- 	highlight = {
-- 		enable = true,
-- 		additional_vim_regex_highlighting = false,
-- 	},
-- 	ident = { enable = true },
-- 	rainbow = {
-- 		enable = true,
-- 		extended_mode = true,
-- 		max_file_lines = nil,
-- 	},
-- })

-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, 'nvim-treesitter.configs')
if not status then
  return
end

-- configure treesitter
treesitter.setup({
  -- enable syntax highlighting
  highlight = {
    enable = true,
  },
  -- enable indentation
  indent = { enable = true },
  -- enable autotagging (w/ nvim-ts-autotag plugin)
  autotag = { enable = true },
  -- ensure these language parsers are installed
  ensure_installed = {
    'astro',
    'bash',
    'css',
    'dockerfile',
    'gitignore',
    'graphql',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'rust',
    'svelte',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'yaml',
  },
  -- auto install above language parsers
  auto_install = true,
})
