vim.pack.add({
  { src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
})

require('rose-pine').setup({
  variant = 'moon',
  dark_variant = 'main',
  dim_inactive_windows = true,
  extend_background_behind_borders = false,
  styles = { transparency = false },
  enable = { legacy_highlights = false },
})
vim.cmd.colorscheme('rose-pine')
