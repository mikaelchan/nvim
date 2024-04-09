local package = require('core.pack').package
local conf = require('modules.editor.config')

package({
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  run = ':TSUpdate',
  config = conf.nvim_treesitter,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
    'mrjones2014/nvim-ts-rainbow',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
})
package({
  'JoosepAlviste/nvim-ts-context-commentstring',
  event = 'VeryLazy',
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

package({ 'raimon49/requirements.txt.vim', event = 'VeryLazy' })

package({
  'saecki/crates.nvim',
  event = { 'BufRead Cargo.toml' },
  dependencies = { { 'nvim-lua/plenary.nvim' } },
  config = conf.crates,
})

package({
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
})
