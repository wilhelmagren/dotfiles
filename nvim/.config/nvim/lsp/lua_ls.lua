-- [[ LSP configuration for the Lua language server ]]
--
-- Neovim 0.11+ uses `vim.lsp.enable()` which automatically
-- picks up files inside the `lsp/` directory. This file is
-- returned as a Lua table and Neovim passes it straight
-- to the active LSP client.
--
-- Requirements: lua-language-server must be on your $PATH
-- Be based and build it from source: https://luals.github.io/wiki/build/
--

return {
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        -- tell the LSP server about Neovim's Lua API so `vim` is not a missing symbol :)
        library = { vim.env.VIMRUNTIME },
        checkThirdParty = false,
      },
    },
  },
}
