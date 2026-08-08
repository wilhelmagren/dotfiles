vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local MB = 1024 * 1024

vim.api.nvim_create_autocmd('VimEnter', {
  desc = 'Truncate oversized LSP log file',
  group = vim.api.nvim_create_augroup('lsp-log-rotation', { clear = true }),
  callback = function()
    local log_path = vim.lsp.log.get_filename()
    if not log_path then return end
    local ok, stat = pcall(vim.uv.fs_stat, log_path)
    if ok and stat and stat.size > 10 * MB then
      pcall(vim.uv.fs_unlink, log_path)
    end
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Restore cursor to file position in previous editing session',
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local lc = vim.api.nvim_buf_line_count(args.buf)

    if mark[1] > 0 and mark[1] <= lc then
      vim.api.nvim_win_set_cursor(0, mark)
      vim.schedule(function()
        vim.cmd('normal! zz')
      end)
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Open help in vertical split instead of horizontal',
  pattern = 'help',
  command = 'wincmd L',
})

vim.api.nvim_create_autocmd('VimResized', {
  desc = 'Auto resize splits to keep ratio when terminal is resized',
  command = 'wincmd =',
})

vim.api.nvim_create_autocmd('FileType', {
  desc = 'Auto resize splits to keep ratio when terminal is resized',
  group = vim.api.nvim_create_augroup('no-auto-comment', {}),
  callback = function()
    vim.opt_local.formatoptions:remove({ 'c', 'r', 'o' })
  end,
})

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
  desc = 'Show cursorline only in active window [ENABLE]',
  group = vim.api.nvim_create_augroup('active-cursorline', { clear = true }),
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave' }, {
  desc = 'Show cursorline only in active window [DISABLE]',
  group = 'active-cursorline',
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
