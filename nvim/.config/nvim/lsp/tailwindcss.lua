return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = {
    'svelte',
    'html',
    'css',
    'scss',
    'javascriptreact',
    'typescriptreact',
  },
  root_markers = {
    'package.json',
    'vite.config.ts',
    'tailwind.config.js',
    '.git',
  },
}
