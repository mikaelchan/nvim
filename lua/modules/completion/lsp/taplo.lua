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
mappings['lt'] = { "<Cmd>lua require('crates').toggle()<CR>", 'Toggle Crate' }
mappings['lu'] = { "<Cmd>lua require('crates').update_crate()<CR>", 'Update Crate' }
mappings['lU'] = { "<Cmd>lua require('crates').upgrade_crate()<CR>", 'Upgrade Crate' }
mappings['lg'] = { "<Cmd>lua require('crates').update_all_crates()<CR>", 'Update All' }
mappings['lG'] = { "<Cmd>lua require('crates').upgrade_all_crates()<CR>", 'Upgrade All' }
mappings['lh'] = { "<Cmd>lua require('crates').open_homepage()<CR>", 'Open HomePage' }
mappings['ld'] = { "<Cmd>lua require('crates').open_documentation()<CR>", 'Open Documentation' }
mappings['lr'] = { "<Cmd>lua require('crates').open_repository()<CR>", 'Open Repository' }
mappings['lv'] = { "<Cmd>lua require('crates').show_versions_popup()<CR>", 'Show Versions' }
mappings['lF'] = { "<Cmd>lua require('crates').show_features_popup()<CR>", 'Show Features' }
mappings['lD'] = { "<Cmd>lua require('crates').show_dependencies_popup()<CR>", 'Show Dependencies' }

return {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    require('modules.completion.lsp').setup_codelens_refresh(client, bufnr)
    require('which-key').register(mappings, opts)
  end,
}
