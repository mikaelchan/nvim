local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
return {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    require('modules.completion.lsp').setup_codelens_refresh(client, bufnr)
  end,
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
      schemaStore = {
        enable = true,
        url = 'https://www.schemastore.org/api/json/catalog.json',
      },
      schemas = {
        kubernetes = {
          'daemon.{yml,yaml}',
          'manager.{yml,yaml}',
          'restapi.{yml,yaml}',
          'kubectl-edit*.yaml',
        },
        ['https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master/configmap.json'] = '*onfigma*.{yml,yaml}',
        ['https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master/deployment.json'] = '*eployment*.{yml,yaml}',
        ['https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master/service.json'] = '*ervic*.{yml,yaml}',
        ['https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master/ingress.json'] = '*ngres*.{yml,yaml}',
        ['https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master/secret.json'] = '*ecre*.{yml,yaml}',
      },
    },
  },
}
