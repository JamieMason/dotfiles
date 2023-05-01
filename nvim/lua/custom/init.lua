-- local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

local g = vim.g
local opt = vim.opt

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- line wrapping
opt.wrap = false -- disable line wrapping
opt.colorcolumn = '80' -- Show col for max line length

-- whitespace
opt.endofline = true
opt.fixeol = true

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance
opt.guifont = { 'FiraCode Nerd Font Mono Regular', ':h14' }

-- indentLine plugin
g.indentLine_char = '┆'
g.indentLine_leadingSpaceEnabled = 1

