-- [[ LSP configuration for the ruff language server ]]
--
-- ruff is the fastest Python linter and formatter there is,
-- and it has super based default settings :)
--
-- https://astral.sh/ruff
-- uv tool install ruff
--

return {
  cmd = { 'ruff', 'server' },
  filetypes = { 'python' },
  root_markers = {
    'pyproject.toml',
    'ruff.toml',
    '.ruff.toml',
    '.git',
  },
}

