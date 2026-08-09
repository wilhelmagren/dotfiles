-- This is all done using netrw.
--  See `:help netrw`

-- tree view as default listing style
vim.g.netrw_liststyle = 3
-- hide the ugly top banner
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.g.netrw_browse_split = 0
vim.g.netrw_altfile = 1

vim.keymap.set('n', '<leader>e', ':Lexplore<cr>', { silent = true, desc = '[E]explore' })

-- netrw's built-in `%` opens new files in the netrw windows intead of
-- respecting `netrw_browse_split`, we override it to open in the prev window
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'netrw',
  callback = function()
    vim.keymap.set('n', '%', function()
      local fname = vim.fn.input('Enter filename: ')
      if fname == "" then
        return
      end

      local dir = vim.b.netrw_curdir or vim.fn.getcwd()
      local path = dir .. "/" .. fname

      if vim.fn.filereadable(path) == 1 or vim.fn.isdirectory(path) == 1 then
        vim.notify('Already exists: ' .. fname, vim.log.levels.WARN)
        return
      end

      if fname:match('/$') then
        vim.fn.mkdir(path, 'p')
        vim.cmd('edit')
      else
        local f = io.open(path, 'w')
        if not f then
          vim.notify('Failed to create: ' .. fname, vim.log.levels.ERROR)
          return
        end
        f:close()

        local escaped = vim.fn.fnameescape(path)
        if vim.fn.winnr('#') == 0 then
          vim.cmd('edit ' .. escaped)
        else
          vim.cmd('wincmd p')
          vim.cmd('edit ' .. escaped)
        end
      end
    end, { buffer = true, silent = true, noremap = true, desc = 'Create file in previous window' })
  end,
})
