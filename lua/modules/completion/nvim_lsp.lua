local signs = {
  Error = ' ',
  Warn = ' ',
  Info = '',
  Hint = ' ',
}
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  signs = true,
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  virtual_text = false,
})

vim.lsp.handlers['workspace/diagnostic/refresh'] = function(_, _, ctx)
  local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
  local bufnr = vim.api.nvim_get_current_buf()
  vim.diagnostic.reset(ns, bufnr)
  return true
end

local found, noice_util = pcall(require, 'noice.util')
if found then
  vim.lsp.handlers['textDocument/signatureHelp'] = noice_util.protect(require('noice.lsp').signature)
end
-- LSP Configurations
local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local autoConfigServers = {
  'dockerls',
  'bashls',
  'golangci_lint_ls',
  'sqlls',
  'solidity_ls',
}

for _, server in ipairs(autoConfigServers) do
  lspconfig[server].setup({
    on_attach = function(client, bufnr)
      require('modules.completion.lsp').setup_codelens_refresh(client, bufnr)
    end,
    capabilities = capabilities,
  })
end

lspconfig.gopls.setup(require('modules.completion.lsp.gopls'))
lspconfig.lua_ls.setup(require('modules.completion.lsp.lua_ls'))
lspconfig.jsonls.setup(require('modules.completion.lsp.jsonls'))
lspconfig.rust_analyzer.setup(require('modules.completion.lsp.rust_analyzer'))
lspconfig.pyright.setup(require('modules.completion.lsp.pyright'))
lspconfig.taplo.setup(require('modules.completion.lsp.taplo'))
lspconfig.yamlls.setup(require('modules.completion.lsp.yamlls'))

require('lspconfig.ui.windows').default_options.border = 'rounded'
