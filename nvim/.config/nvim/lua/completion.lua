vim.pack.add({
  { src = 'https://www.github.com/saghen/blink.lib', name = 'blink-lib' },
  { src = 'https://www.github.com/saghen/blink.cmp', branch = 'v1', name = 'blink-cmp' },
  { src = 'https://www.github.com/rafamadriz/friendly-snippets', name = 'friendly-snippets' },
})

local blink = require('blink-cmp')
blink.build():pwait()

blink.setup({
  keymap = { preset = 'default' },
  cmdline = { enabled = false },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
    }
  },
  signature = { enabled = true },
  sources = {
    default = {
      'lsp',
      'path',
      'snippets',
      'buffer',
    },
  },
})
