local package = require('core.pack').package
local conf = require('modules.ui.config')

package({
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
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
  'nvimdev/galaxyline.nvim',
  config = conf.galaxyline,
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

package({
  'kevinhwang91/nvim-hlslens',
  config = conf.hlslens,
  event = 'BufReadPost',
})

package({
  'norcalli/nvim-colorizer.lua',
  config = conf.colorizer,
  event = 'BufReadPre',
})

package({
  'HiPhish/rainbow-delimiters.nvim',
  name = 'rainbow_delimiters',
})
package({
  'lukas-reineke/indent-blankline.nvim',
  config = conf.indent_blankline,
  dependencies = {},
})

package({
  'stevearc/dressing.nvim',
  lazy = true,
  config = conf.dressing,
  event = 'BufWinEnter',
})

package({ 'nvim-lua/popup.nvim' })

package({ 'mtdl9/vim-log-highlighting', ft = { 'text', 'log' } })

package({
  'm-demare/hlargs.nvim',
  lazy = true,
  event = 'VeryLazy',
  config = conf.hlargs,
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
})

package({
  'kristijanhusak/vim-dadbod-ui',
  cmd = { 'DBUIToggle', 'DBUIAddConnection', 'DBUI', 'DBUIFindBuffer', 'DBUIRenameBuffer' },
  init = conf.dadbod_ui,
  dependencies = { {
    'tpope/vim-dadbod',
    lazy = true,
  } },
  lazy = true,
})

package({
  'karb94/neoscroll.nvim',
  config = conf.neoscroll,
  event = 'BufRead',
})
