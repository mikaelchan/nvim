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
mappings['lA'] = { '<Cmd>RustHoverActions<CR>', 'Hover actions' }
mappings['lm'] = { '<Cmd>RustExpandMacro<CR>', 'Expand macro' }
mappings['lH'] = { '<Cmd>RustToggleInlayHints<CR>', 'Toggle inlay hints' }
mappings['le'] = { '<Cmd>RustRunnables<CR>', 'Runnables' }
mappings['lD'] = { '<cmd>RustDebuggables<Cr>', 'Debuggables' }
mappings['lP'] = { '<cmd>RustParentModule<Cr>', 'Parent module' }
mappings['lv'] = { '<cmd>RustViewCrateGraph<Cr>', 'View crate graph' }
mappings['lR'] = {
  "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
  'Reload workspace',
}
mappings['lc'] = { '<Cmd>RustOpenCargo<CR>', 'Open cargo' }
mappings['lo'] = { '<Cmd>RustOpenExternalDocs<CR>', 'Open external docs' }
mappings['lb'] = {
  "<cmd>lua require('modules.tools.terminal').exec_toggle({cmd='cargo build;read',count=2,direction='float'})<cr>",
  'Build',
}
return {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    require('modules.completion.lsp').setup_codelens_refresh(client, bufnr)
    require('which-key').register(mappings, opts)
  end,
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
}
