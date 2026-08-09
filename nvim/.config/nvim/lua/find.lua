local ignore_patterns = {
  '%.git',
  '%.cache',
  '__pycache__',
  'dist',
  'build',
  '%.tmp',
  '%.log',
}

function _G._native_find(text, _)
  local cmd = { 'rg', '--files', '--hidden' }
  local result = {}
  for _, f in ipairs(vim.fn.systemlist(cmd)) do
    if vim.fn.isdirectory(f) == 0 then
      local skip = false
      for _, pat in ipairs(ignore_patterns) do
        if f:match(pat) then
          skip = true
          break
        end
      end
      if not skip then
        result[#result + 1] = f
      end
    end
  end
  if vim.v.shell_error ~= 0 then
    return {}
  end

  return vim.fn.matchfuzzy(result, text)
end

vim.opt.findfunc = 'v:lua._native_find'
vim.keymap.set('n', '<leader>sf', ':find ', { silent = false, desc = '[S]earch [F]iles' })
