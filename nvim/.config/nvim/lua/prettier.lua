local M = {}

function M.format()
  local bufnr = vim.api.nvim_get_current_buf()
  local filename = vim.api.nvim_buf_get_name(bufnr)

  if filename == '' then
    return
  end

  local package = vim.fs.find('package.json', {
    upward = true,
    path = vim.fs.dirname(filename),
  })[1]

  if not package then
    vim.notify('No package.json found', vim.log.levels.WARN)
    return
  end

  local root = vim.fs.dirname(package)
  local prettier = root .. '/node_modules/.bin/prettier'

  if vim.fn.executable(prettier) == 0 then
    vim.notify('Prettier is not installed in this project', vim.log.levels.WARN)
    return
  end

  local tick = vim.api.nvim_buf_get_changedtick(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local input = table.concat(lines, '\n')

  if vim.bo[bufnr].endofline then
    input = input .. '\n'
  end

  vim.system({
    prettier,
    '--stdin-filepath',
    filename,
  }, {
    cwd = root,
    stdin = input,
    text = true,
  }, function(result)
    vim.schedule(function()
      if result.code ~= 0 then
        vim.notify(result.stderr or 'Prettier failed', vim.log.levels.ERROR)
        return
      end

      if not vim.api.nvim_buf_is_valid(bufnr)
          or vim.api.nvim_buf_get_changedtick(bufnr) ~= tick
          or not vim.bo[bufnr].modifiable then
        return
      end

      local output = result.stdout or ''
      local formatted = vim.split(output, '\n', { plain = true })

      if formatted[#formatted] == '' then
        table.remove(formatted)
      end

      if output ~= input then
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, formatted)
        vim.bo[bufnr].endofline = output:sub(-1) == '\n'
      end
    end)
  end)
end

return M
