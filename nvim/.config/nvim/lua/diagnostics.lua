vim.pack.add({
  { src = "https://github.com/rachartier/tiny-inline-diagnostic.nvim", name = "tiny-inline-diagnostic" },
})

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = true,
  -- this is managed by the tiny-inline-diagnotics plugin
  virtual_text = false,
  signs = vim.g.have_nerd_font and {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or true,
})

require('tiny-inline-diagnostic').setup({
  preset = 'amongus',
  transparent_bg = false,
  transparent_cursorline = true,
  options = {
    -- multilines = { enabled = true },
    overflow = { mode = 'wrap' },
  },
})

vim.keymap.set("n", "<leader>d", function()
  vim.diagnostic.setqflist()
  vim.cmd("copen")
end, { silent = true, desc = 'Open [D]iagnostics' })
