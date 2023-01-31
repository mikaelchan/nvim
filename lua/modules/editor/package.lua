local package = require('core.pack').package
local conf = require('modules.editor.config')

package({
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  run = ':TSUpdate',
  config = conf.nvim_treesitter,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
})

package({
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = conf.which_key,
})

package({
  'olexsmir/gopher.nvim',
  config = conf.gopher,
  ft = { 'go', 'gomod' },
  event = { 'BufRead', 'BufNew' },
})

package({
  'RRethy/vim-illuminate',
  config = conf.illuminate,
  event = 'VeryLazy',
})

package({
  url = 'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  lazy = true,
  config = conf.lsp_lines,
})

package({
  'lvimuser/lsp-inlayhints.nvim',
  event = 'LspAttach',
  config = conf.lsp_inlayhints,
})
