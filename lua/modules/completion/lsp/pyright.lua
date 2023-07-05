local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mappings = {}
local opts = {
  mode = 'n',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}
mappings['df'] = { "<cmd>lua require('dap-python').test_class()<cr>", 'Test Class' }
mappings['dm'] = { "<cmd>lua require('dap-python').test_method()<cr>", 'Test Method' }
mappings['dS'] = { "<cmd>lua require('dap-python').debug_selection()<cr>", 'Debug Selection' }
mappings['P'] = {
  name = ' Python',
  i = { "<cmd>lua require('swenv.api').pick_venv()<cr>", 'Pick Env' },
  d = { "<cmd>lua require('swenv.api').get_current_venv()<cr>", 'Show Env' },
}

return {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    require('modules.completion.lsp').setup_codelens_refresh(client, bufnr)
    require('which-key').register(mappings, opts)
  end,
  root_dir = function(fname)
    local util = require('lspconfig.util')
    local root_files = {
      'pyproject.toml',
      'setup.py',
      'setup.cfg',
      'requirements.txt',
      'Pipfile',
      'manage.py',
      'pyrightconfig.json',
    }
    return util.root_pattern(unpack(root_files))(fname) or util.root_pattern('.git')(fname) or util.path.dirname(fname)
  end,
  settings = {
    pyright = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
    },
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
      },
    },
  },
  single_file_support = true,
}
