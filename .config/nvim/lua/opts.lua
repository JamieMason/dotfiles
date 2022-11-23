-- [[ opts.lua ]]

local g = vim.g
local opt = vim.opt
local cmd = vim.api.nvim_command

-- [[ Context ]]
-- str: Show col for max line length
opt.colorcolumn = '80'
-- bool: Show line numbers
opt.number = true
-- bool: Show relative line numbers
opt.relativenumber = true
-- int: Min num lines of context
opt.scrolloff = 4
-- str: Show the sign column
opt.signcolumn = "yes"

-- [[ Filetypes ]]
-- str: String encoding to use
opt.encoding = 'utf8'
-- str: File encoding to use
opt.fileencoding = 'utf8'

-- [[ Theme ]]
-- str: Allow syntax highlighting
opt.syntax = "ON"
-- bool: If term supports ui color then enable
opt.termguicolors = true
-- Set the colour scheme
cmd('colorscheme ayu')

-- [[ Clipboard ]]
-- Allow copying from Neovim and pasting in another app
opt.clipboard = 'unnamed'

-- [[ Windows ]]
opt.splitright = true
opt.splitbelow = true

-- [[ Search ]]
-- bool: Ignore case in search patterns
opt.ignorecase = true
-- bool: Override ignorecase if search contains capitals
opt.smartcase = true
-- bool: Use incremental search
opt.incsearch = true
-- bool: Highlight search matches
opt.hlsearch = false

-- [[ Whitespace ]]
-- bool: ensure that spaces are used for indenting
--       lines, even when you press the 'Tab' key
opt.expandtab = true
-- bool: when you press Enter to go to the next line,
--       apply indentation automatically
opt.autoindent = true
-- num: Number of spaces when you use the '>>' or
--      '<<' operators to add or remove indentation
--      to an already existing line/block of code
opt.shiftwidth = 2
-- num: Number of spaces tabs count for in insert mode
opt.softtabstop = 2
-- num: Insert 2 spaces for a line indent
opt.tabstop = 2
-- bool: disable wrapping
opt.wrap = false
-- bool: fix missing empty line at end of file
opt.endofline = true
opt.fixeol = true
-- [[ Splits ]]
-- bool: Place new window to right of current one
opt.splitright = true
-- bool: Place new window below the current one
opt.splitbelow = true

-- [[ IndentLine Plugin ]]
g.indentLine_char = '┆'
g.indentLine_leadingSpaceEnabled = 1

-- [[ TagBar Plugin ]]
g.tagbar_ctags_bin = '/usr/local/bin/ctags'

-- [[ Auto Complete ]]
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
-- opt.completeopt = {'menuone', 'noselect', 'noinsert'}
-- opt.shortmess = vim.opt.shortmess + {c = true}
-- vim.api.nvim_set_option('updatetime', 300)
opt.completeopt = 'menu,menuone,noselect'

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
 set signcolumn=yes
 autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- [[ Input Delay ]]
-- how long to wait before submitting a key sequence
opt.timeoutlen = 500

