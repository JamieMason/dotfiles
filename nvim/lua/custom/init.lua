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
opt.guifont = { 'FiraCode Nerd Font Mono Retina', ':h13' }

-- indentLine plugin
g.indentLine_char = '┆'
g.indentLine_leadingSpaceEnabled = 1

-- Neovide.app
if g.neovide then
  vim.o.guifont = 'FiraCode Nerd Font Mono:h13'
  vim.g.neovide_cursor_vfx_mode = 'railgun'
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_density = 7.0
end

