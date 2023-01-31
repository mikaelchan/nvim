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

package({
  'lewis6991/gitsigns.nvim',
  event = { 'BufRead', 'BufNewFile' },
  config = conf.gitsigns,
})

package({
  'sindrets/diffview.nvim',
  lazy = true,
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  config = conf.diffview,
  dependencies = { 'nvim-lua/plenary.nvim' },
})

package({ 'glepnir/dashboard-nvim', event = 'VimEnter', config = conf.dashboard })
package({
  'folke/noice.nvim',
  event = 'VeryLazy',
  config = conf.noice,
  dependencies = { 'rcarriga/nvim-notify', 'MunifTanjim/nui.nvim' },
})
