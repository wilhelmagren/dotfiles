-- Load `nvim-packer` and all plugins.
require('pacman')
require('colorscheme')
require('explorer')
require('lsp')
require('completions')
require('statusline')
require('telescope')
require('treesitter')

-- Enable relative line numbers combined with an
-- absolute line number on the current cursorline.
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Set the offset for when buffer starts moving.
vim.opt.scrolloff = 10

-- Enable mouse support for copy/paste.
vim.opt.mouse = 'a'

-- Indentation using spaces.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.textwidth = 90

vim.keymap.set('', '<M-e>', toggle_tree)
vim.keymap.set('i', 'jk', '<Esc>', { noremap = false })
