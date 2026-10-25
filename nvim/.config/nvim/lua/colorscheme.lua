vim.pack.add({
  { src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
  { src = 'https://github.com/D0nw0r/dark2026.nvim', name = 'dark2026' },
})

require('rose-pine').setup({
  variant = 'moon',
  dark_variant = 'main',
  dim_inactive_windows = true,
  extend_background_behind_borders = true,
  styles = { transparency = false },
  enable = { legacy_highlights = false },
})

vim.cmd.colorscheme('dark2026')
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'FloatTitle', { bg = 'NONE' })
