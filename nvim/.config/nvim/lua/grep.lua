vim.opt.grepprg = 'rg --vimgrep --smart-case --hidden -g \'!.git\''
vim.opt.grepformat = '%f:%l:%c:%m'

vim.keymap.set('n', '<leader>sg', function()
  vim.ui.input({ prompt = 'grep: ' }, function(pattern)
    if pattern then
      vim.cmd('silent grep! ' .. vim.fn.fnameescape(pattern))
      vim.cmd('copen')
    end
  end)
end, { desc = '[S]earch by [G]rep' })
