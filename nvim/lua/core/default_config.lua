-- Chadrc overrides this file

local M = {}

M.options = {
  nvChad = {
    update_url = 'https://github.com/NvChad/NvChad',
    update_branch = 'main',
  },
}

M.ui = {
  -- hl = highlights
  hl_add = {},
  hl_override = {},
  changed_themes = {},
  theme_toggle = { 'ayu-dark', 'ayu-light' },
  theme = 'ayu-dark', -- default theme
  transparency = false,
}

M.plugins = {}

-- check core.mappings for table structure
M.mappings = require('core.mappings')

return M
