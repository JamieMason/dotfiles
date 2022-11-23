require('telescope').setup({
  defaults = {
    file_ignore_patterns = {
      '%.avif',
      '%.gif',
      '%.jpeg',
      '%.jpg',
      '%.otf',
      '%.png',
      '%.ttf',
      '%.webp',
      '%.woff',
      '%.woff2',
    },
  },
})

require('telescope').load_extension('fzf')
