function _G._native_find(text, _)
  local cmd = { 'rg', '--files', '--hidden' }
  local files = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    return {}
  end

  return vim.fn.matchfuzzy(files, text)
end

vim.opt.findfunc = 'v:lua._native_find'
vim.keymap.set('n', '<leader>sf', ':find ', { silent = false, desc = '[S]earch [F]iles' })
