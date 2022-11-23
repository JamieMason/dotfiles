-- MANUAL STEPS
-- :CocInstall coc-css coc-emmet coc-eslint coc-html coc-json coc-prettier coc-rust-analyzer coc-tsserver

-- Select autocomplete item on Enter
vim.cmd([[
  inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
]])

-- When no item is selected, select first item on Enter
vim.cmd([[
  inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
]])

-- GoTo code navigation.
vim.cmd([[
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
]])

-- Use K to show documentation in preview window.
