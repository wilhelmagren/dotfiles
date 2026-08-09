-- Set <space> as the leader key before loading anything else.
--  See `:help mapleader`
--  and `:help localleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Nerd font availability flag (used by plugins).
vim.g.have_nerd_font = true

require('options')
require('colorscheme')
require('lsp')
require('statusline')
require('autocommands')
require('diagnostics')
require('explorer')
require('keymaps')
require('find')
require('grep')
require('terminal')
require('completion')
require('treesitter')

-- this is experimental
require('vim._core.ui2')
