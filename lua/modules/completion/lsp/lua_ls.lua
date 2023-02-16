local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

return {
  on_attach = function(client, bufnr)
    require('modules.completion.lsp').setup_codelens_refresh(client, bufnr)
    client.server_capabilities.semanticTokensProvider = nil
  end,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { 'vim' },
      },
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
        checkThirdParty = false,
      },
      completion = {
        callSnippet = 'Replace',
        keywordSnippet = 'Disable',
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
