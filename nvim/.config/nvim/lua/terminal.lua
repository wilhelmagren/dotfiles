local state = { buf = nil, win = nil }

local function start_terminal()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
    state.win = nil
    return
  end

  if not (state.buf and vim.api.nvim_buf_is_valid(state.buf)) then
    state.buf = vim.api.nvim_create_buf(false, true)
  end

  local width = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines * 0.7)

  state.win = vim.api.nvim_open_win(state.buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    border = 'rounded',
    style = 'minimal',
  })

  if vim.bo[state.buf].buftype ~= 'terminal' then
    vim.cmd.terminal()
  end

  vim.cmd.startinsert()
end

local map = vim.keymap.set

map('n', '<leader>st', start_terminal, { desc = '[S]tart floating [T]erminal' })
map('t', '<Esc><Esc>', function()
  vim.cmd('stopinsert')
  vim.schedule(function()
    vim.cmd('close')
  end)
end, { desc = ' ' })
