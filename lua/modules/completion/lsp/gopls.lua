local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mappings = {}
mappings['lI'] = { '<cmd>GoInstallDeps<cr>', 'Install Dependencies' }
mappings['lT'] = { '<cmd>GoMod tidy<cr>', 'Tidy' }
mappings['lt'] = { '<cmd>GoTestAdd<cr>', 'Add Test' }
mappings['tA'] = { '<cmd>GoTestsAll<cr>', 'Add All Tests' }
mappings['le'] = { '<cmd>GoTestsExp<cr>', 'Add Exported Tests' }
mappings['lg'] = { '<cmd>GoGenerate<cr>', 'Generate' }
mappings['lF'] = { '<cmd>GoGenerate %<cr>', 'Generate File' }
mappings['lc'] = { '<cmd>GoCmt<cr>', 'Comment' }
mappings['dT'] = { "<cmd>lua require('dap-go').debug_test()<cr>", 'Debug Test' }
local opts = {
  mode = 'n',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

return {
  cmd = { 'gopls', 'serve' },
  capabilities = capabilities,
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  },
  settings = {
    gopls = {
      gofumpt = true, -- A stricter gofmt
      codelenses = {
        gc_details = true, -- Toggle the calculation of gc annotations
        generate = true, -- Runs go generate for a given directory
        regenerate_cgo = true, -- Regenerates cgo definitions
        test = true,
        tidy = true, -- Runs go mod tidy for a module
        upgrade_dependency = true, -- Upgrades a dependency in the go.mod file for a module
        vendor = true, -- Runs go mod vendor for a module
      },
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        functionTypeParameters = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      diagnosticsDelay = '300ms',
      symbolMatcher = 'fuzzy',
      completeUnimported = true,
      staticcheck = true,
      matcher = 'Fuzzy',
      usePlaceholders = true, -- enables placeholders for function parameters or struct fields in completion responses
      analyses = {
        fieldalignment = true, -- find structs that would use less memory if their fields were sorted
        nilness = true, -- check for redundant or impossible nil comparisons
        shadow = true, -- check for possible unintended shadowing of variables
        unusedparams = true, -- check for unused parameters of functions
        unusedwrite = true, -- checks for unused writes, an instances of writes to struct fields and arrays that are never read
      },
    },
  },
  on_attach = function(client, bufnr)
    require('modules.completion.lsp').setup_codelens_refresh(client, bufnr)
    require('which-key').register(mappings, opts)
  end,
}
