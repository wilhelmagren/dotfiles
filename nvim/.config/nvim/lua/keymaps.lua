local map = vim.keymap.set

map('n', 'nh', '<CMD>nohlsearch<CR>', { desc = '[N]o [H]ighlight' })
map('i', 'jk', '<Esc>', { desc = 'Exit insert mode [J]ust [K]idding' })

map('n', '<leader>su', '<cmd>belowright split<CR>', { desc = '[S]plit [U]p' })
map('n', '<leader>sd', '<cmd>aboveleft split<CR>', { desc = '[S]plit [D]own' })
map('n', '<leader>sl', '<cmd>belowright vsplit<CR>', { desc = '[S]plit [L]eft' })
map('n', '<leader>sr', '<cmd>aboveleft vsplit<CR>', { desc = '[S]plit [R]ight' })

map('n', '<C-a>k', '<C-w>k', { desc = 'Navigate (split) up' })
map('n', '<C-a>j', '<C-w>j', { desc = 'Navigate (split) down' })
map('n', '<C-a>h', '<C-w>h', { desc = 'Navigate (split) left' })
map('n', '<C-a>l', '<C-w>l', { desc = 'Navigate (split) right' })

map('n', '<C-a>d', vim.diagnostic.open_float, { desc = 'Open [D]iagnostics float' })
map('n', '<leader>e', ':Lexplore<cr>', { silent = true, desc = '[E]explore' })

map('n', '<leader>q', '<cmd>cclose<CR>', { desc = 'Close quickfix' })
map('n', '<leader>sg', function()
  vim.ui.input({ prompt = 'grep: ' }, function(pattern)
    if pattern then
      vim.cmd('silent grep! ' .. vim.fn.fnameescape(pattern))
      vim.cmd('copen')
    end
  end)
end, { desc = '[S]earch by [G]rep' })
