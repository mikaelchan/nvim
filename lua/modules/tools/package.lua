local package = require('core.pack').package
local conf = require('modules.tools.config')

package({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    { 'ahmedkhalf/project.nvim' },
  },
})
package({ 'benfowler/telescope-luasnip.nvim', module = 'telescope._extensions.luasnip' })
package({
  'akinsho/toggleterm.nvim',
  event = 'VeryLazy',
  config = conf.toggleterm,
})

package({
  'mfussenegger/nvim-dap',
})

package({
  'rcarriga/nvim-dap-ui',
})
package({
  'phaazon/hop.nvim',
  event = 'VeryLazy',
  cmd = { 'HopChar1CurrentLineAC', 'HopChar1CurrentLineBC', 'HopChar2MW', 'HopWordMW' },
  config = conf.hop,
})
