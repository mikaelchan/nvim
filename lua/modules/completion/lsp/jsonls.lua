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
mappings['ls'] = { "<cmd>lua require('package-info').show()<cr>", 'Show pkg info' }
mappings['lc'] = { "<cmd>lua require('package-info').hide()<cr>", 'Hide pkg info' }
mappings['lu'] = { "<cmd>lua require('package-info').update()<cr>", 'Update dependency' }
mappings['ld'] = { "<cmd>lua require('package-info').delete()<cr>", 'Delete dependency' }
mappings['lI'] = { "<cmd>lua require('package-info').install()<cr>", 'Install dependency' }
mappings['lC'] = { "<cmd>lua require('package-info').change_version()<cr>", 'Change Version' }

return {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    require('modules.completion.lsp').setup_codelens_refresh(client, bufnr)
    require('which-key').register(mappings, opts)
  end,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(),
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
        end,
      },
    },
  },
}
