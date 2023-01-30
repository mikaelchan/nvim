local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mappings = {}
mappings['lA'] = { '<Cmd>TSLspImportAll<CR>', 'Import All' }
mappings['lR'] = { '<Cmd>TSLspRenameFile<CR>', 'Rename File' }
mappings['lO'] = { '<Cmd>TSLspOrganize<CR>', 'Organize Imports' }
mappings['lI'] = { '<cmd>TypescriptAddMissingImports<Cr>', 'AddMissingImports' }
mappings['lo'] = { '<cmd>TypescriptOrganizeImports<cr>', 'OrganizeImports' }
mappings['lu'] = { '<cmd>TypescriptRemoveUnused<Cr>', 'RemoveUnused' }
mappings['lF'] = { '<cmd>TypescriptFixAll<Cr>', 'FixAll' }
mappings['lg'] = { '<cmd>TypescriptGoToSourceDefinition<Cr>', 'GoToSourceDefinition' }
local opts = {
  mode = 'n',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

local function on_attach(client, bufnr)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  require('which-key').register(mappings, opts)
end

return {
  disable_commands = false, -- prevent the plugin from creating Vim commands
  disable_formatting = false, -- disable tsserver's formatting capabilities
  debug = false, -- enable debug logging for commands
  server = { -- pass options to lspconfig's setup method
    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
    on_attach = on_attach,
    capabilities = capabilities,
  },
}
