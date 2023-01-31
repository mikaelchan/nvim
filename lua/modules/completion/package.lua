local package = require('core.pack').package
local conf = require('modules.completion.config')

local enable_lsp_filetype = {
  'go',
  'lua',
  'sh',
  'rust',
  'c',
  'cpp',
  'zig',
  'typescript',
  'typescriptreact',
  'typescript.tsx',
  'javascript',
  'javascriptreact',
  'javascript.jsx',
  'json',
  'python',
  'solidity',
  'markdown',
}

package({
  'mfussenegger/nvim-jdtls',
  ft = 'java',
})

package({
  'jose-elias-alvarez/typescript.nvim',
  ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  lazy = true,
  config = conf.ts,
})

package({
  'ThePrimeagen/refactoring.nvim',
  lazy = true,
  ft = enable_lsp_filetype,
  event = 'BufReadPost',
  config = conf.refactoring,
})

package({
  'neovim/nvim-lspconfig',
  config = conf.nvim_lsp,
})

package({
  'glepnir/lspsaga.nvim',
  ft = enable_lsp_filetype,
  config = conf.lspsaga,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
})

package({
  'hrsh7th/nvim-cmp',
  event = {'InsertEnter', 'CmdlineEnter'},
  config = conf.nvim_cmp,
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-cmdline' },
  },
})
package({ 'hrsh7th/cmp-nvim-lsp', lazy = true })
package({ 'saadparwaiz1/cmp_luasnip', lazy = true })
package({ 'hrsh7th/cmp-buffer', lazy = true })
package({ 'hrsh7th/cmp-path', lazy = true })
package({ 'hrsh7th/cmp-cmdline', lazy = true })
package({
  'L3MON4D3/LuaSnip',
  event = 'InsertCharPre',
  config = conf.lua_snip,
  dependencies = {
    'friendly-snippets',
  },
})
package({ 'rafamadriz/friendly-snippets', lazy = true })
package({ 'jose-elias-alvarez/null-ls.nvim', config = conf.null_ls })

package({
  'zbirenbaum/copilot.lua',
  event = 'InsertEnter',
  dependencies = { 'zbirenbaum/copilot-cmp', 'nvim-cmp' },
  config = conf.copilot,
})

package({
  'zbirenbaum/copilot-cmp',
  after = { 'copilot.lua' },
  config = conf.copilot_cmp,
})

package({ 'b0o/schemastore.nvim', lazy = true })
