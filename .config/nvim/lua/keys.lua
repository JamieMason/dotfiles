--[[ keys.lua ]]

local hop = require('hop')
local directions = require('hop.hint').HintDirection
local map = vim.api.nvim_set_keymap

-- [[ Source ]]
-- toggle single/multi-line wrapping of blocks of code
map('n', '<leader>w', ':TSJToggle<CR>', {})
-- increment number
map('n', '<leader>+', '<C-a>', {})
-- decrement number
map('n', '<leader>-', '<C-x>', {})

-- [[ Windows ]]
-- split window vertically
map('n', '<leader>sv', '<C-w>v', {})
-- split window horizontally
map('n', '<leader>sh', '<C-w>s', {})
-- equal size of split windows
map('n', '<leader>se', '<C-w>=', {})
-- close current split window
map('n', '<leader>sx', ':close<CR>', {})
-- maximise current split window
map('n', '<leader>sm', ':MaximizerToggle<CR>', {})

-- [[ Tabs ]]
-- open new tab
map('n', '<leader>to', ':tabnew<CR>', {})
-- close current tab
map('n', '<leader>tx', ':tabclose<CR>', {})
-- go to next tab
map('n', '<leader>tn', ':tabn<CR>', {})
-- go to previous tab
map('n', '<leader>tp', ':tabp<CR>', {})

-- [[ nvim-tree ]]
map('n', '<leader>b', ':NvimTreeToggle<CR>', {})

-- [[ Tagbar ]]
map('n', '<leader>tt', ':TagbarToggle<CR>', {})

-- [[ Hop ]]
-- jump to any word in the file
map('n', '<leader>hw', ':HopWord<CR>', {})
-- f, but with Hop
vim.keymap.set('', '<leader>hf', function()
  hop.hint_char1({
    direction = directions.AFTER_CURSOR,
    current_line_only = true,
  })
end, { remap = true })
-- F, but with Hop
vim.keymap.set('', '<leader>hF', function()
  hop.hint_char1({
    direction = directions.BEFORE_CURSOR,
    current_line_only = true,
  })
end, { remap = true })

-- [[ Telescope ]]
local builtin = require('telescope.builtin')
-- search for files in the project
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- search file contents in the project
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- search contents in open files
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
-- search text within help
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
