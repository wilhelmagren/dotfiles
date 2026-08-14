vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    local map = function(keys, fn, desc, mode)
      -- default to normal mode
      mode = mode or 'n'
      vim.keymap.set(mode, keys, fn, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
    map('grr', vim.lsp.buf.references, '[G]oto [R]eferences')
    map('gri', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    map('grd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    map('grt', vim.lsp.buf.type_definition, '[G]oto [T]type definition')
    map('K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, 'Hover')
    map('<leader>f', function() vim.lsp.buf.format({ async = true }) end, '[F]ormat')
  end,
})

-- Insert mode completion options.
--  See `:help completeopt`
vim.opt.completeopt = {
  'menu',
  'menuone',
  'noselect',
}

vim.lsp.enable({ 'lua_ls', 'ruff', 'pyrefly', 'metals', 'rust_analyzer' })
