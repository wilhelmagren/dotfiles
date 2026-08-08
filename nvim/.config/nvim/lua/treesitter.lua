vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', name = 'nvim-treesitter' }
})

require('nvim-treesitter').setup({
  install_dir = vim.fn.stdpath('data') .. '/site'
})

require('nvim-treesitter').install({
  'bash',
  'c',
  'cpp',
  'java',
  'lua',
  'markdown',
  'markdown_inline',
  'python',
  'rust',
  'scala',
  'sql',
})
