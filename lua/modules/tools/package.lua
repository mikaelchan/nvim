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
  event = { 'BufRead', 'BufNew' },
  config = conf.dap,
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

package({
  'folke/persistence.nvim',
  event = 'BufReadPre',
  lazy = true,
  config = conf.persistence,
})

package({
  'windwp/nvim-spectre',
  lazy = true,
  config = conf.spectre,
})

package({ 'nvim-telescope/telescope-live-grep-args.nvim' })

package({
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  config = conf.autopairs,
})

package({
  'leoluz/nvim-dap-go',
  config = conf.dap_go,
  ft = { 'go', 'gomod' },
  event = { 'BufRead', 'BufNew' },
})

package({
  'AckslD/swenv.nvim',
  ft = 'python',
  event = { 'BufRead', 'BufNew' },
})

package({
  'mfussenegger/nvim-dap-python',
  config = conf.dap_python,
  ft = 'python',
  event = { 'BufRead', 'BufNew' },
})

package({
  'mxsdev/nvim-dap-vscode-js',
  ft = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx' },
  lazy = true,
  event = { 'BufReadPre', 'BufNew' },
  config = conf.dap_js,
})

package({
  'folke/todo-comments.nvim',
  dependencies = 'nvim-lua/plenary.nvim',
  config = conf.todo_comments,
})

package({
  'numToStr/Comment.nvim',
  event = 'BufRead',
  config = conf.comment,
})

package({
  'ThePrimeagen/harpoon',
  dependencies = { { 'nvim-lua/plenary.nvim' }, { 'nvim-lua/popup.nvim' } },
})
