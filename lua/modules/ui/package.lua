local package = require('core.pack').package
local conf = require('modules.ui.config')

package({
  'catppuccin/nvim',
  name = 'catppuccin',
  config = conf.catppuccin,
})

package({
  'nvim-tree/nvim-tree.lua',
  cmd = 'NvimTreeToggle',
  config = conf.nvim_tree,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})

package({
  'akinsho/nvim-bufferline.lua',
  config = conf.nvim_bufferline,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})

package({
  'nvim-lualine/lualine.nvim',
  config = conf.lualine,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})
