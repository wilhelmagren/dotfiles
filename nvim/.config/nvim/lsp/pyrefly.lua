-- [[ LSP configuration for the pyrefly language server ]]
--
-- This is used for fast type checking, I would have liked to use
-- astral-sh/ty instead but they still have not made a 0.1.x release...
--
-- https://pyrefly.org/
-- uv tool install pyrefly
--

return {
  cmd = { 'pyrefly', 'lsp' },
  filetypes = { 'python' },
  root_markers = {
    'pyrefly.toml',
    'pyproject.toml',
    '.git',
  },
}
