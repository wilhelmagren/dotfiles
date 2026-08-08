-- [[ Set up based options ]]
--  See `:help vim.o`
--  and `:help vim.opt`

-- Enable line numbers and make them relativ (except for the current line)
-- and also enable the cursorline (highlights the current line).
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Enable mouse mode for copy/paste or resizing splits.
vim.o.mouse = 'a'

-- Enable break indent (line will continue visually indented).
vim.o.breakindent = true

-- Save the undo history :)
vim.o.undofile = true

-- Case-insesitive searching UNLESS '\C' or one or more capital latters are used in the search term.
--  See `:help  ignorecase`
--  and `:help  smartcase`
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default.
--  See `:help  signcolumn`
vim.o.signcolumn = 'yes'

-- Decrease the update interval time (ms).
vim.o.updatetime = 250
-- Decrease time (ms) to wait for a mapped sequence to complete.
vim.o.timeoutlen = 300
-- Decrease time (ms) to wait for a key code sequence to complete.
vim.opt.ttimeoutlen = 10

-- Auto-select the best regex engine.
--  See `:help regexpengine`
vim.opt.regexpengine = 0

-- Preview substitutions live in another window as you type.
vim.o.inccommand = 'split'

-- If performing an operation that would fail due to unsaved changes in the buffer,
-- (like `:q`), instead raise a dialog asking if you wish to save the current file(s).
--  See `:help 'confirm'`
vim.o.confirm = true

-- Default indentation options, filetype specific options go under 'after/ftplugin'.
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.textwidth = 100

-- Turn on truecolor everywhere.
vim.opt.termguicolors = true

-- Only show statusline for the currently active split.
vim.o.laststatus = 3

-- Number of screen lines to use for the command line.
-- This setting is experimental, but works better with ui2 enabled.
vim.o.cmdheight = 0

vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden -g \'!.git\''
vim.opt.grepformat = '%f:%l:%c:%m'
