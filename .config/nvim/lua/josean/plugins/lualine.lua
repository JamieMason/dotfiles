-- import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
  return
end

-- get lualine ayu_dark theme
local lualine_ayu_dark = require("lualine.themes.ayu_dark")

-- configure lualine with theme
lualine.setup({
  options = {
    theme = lualine_ayu_dark,
  },
})
