local ignore_patterns = {
  '%.git/',
  '%.cache/',
  '__pycache__/',
  '^dist/',
  '^build/',
  '%.tmp$',
  '%.log$',
}

function _G._native_find(text, _)
  local files = vim.fn.systemlist({ 'rg', '--files', '--hidden' })

  if vim.v.shell_error ~= 0 then
    return {}
  end

  local filtered = vim.tbl_filter(function(f)
    for _, pat in ipairs(ignore_patterns) do
      if f:match(pat) then
        return false
      end
    end
    return true
  end, files)

  return vim.fn.matchfuzzy(filtered, text)
end

vim.opt.findfunc = 'v:lua._native_find'
vim.keymap.set( 'n', '<leader>sf', ':find ', { silent = false, desc = '[S]earch [F]iles' })
