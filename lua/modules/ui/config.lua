local config = {}

function config.nvim_bufferline()
  require('modules.ui.bufferline')
end

function config.nvim_tree()
  require('modules.ui.nvim_tree')
end

function config.catppuccin()
  require('modules.ui.catppuccin')
end

function config.lualine()
  require('modules.ui.lualine')
end

function config.gitsigns()
  require('modules.ui.gitsigns')
end

function config.diffview()
  require('diffview').setup({
    default_args = {
      DiffviewFileHistory = { '%' },
    },
    hooks = {
      diff_buf_read = function()
        vim.wo.wrap = false
        vim.wo.list = false
        vim.wo.colorcolumn = ''
      end,
    },
    enhanced_diff_hl = true,
    keymaps = {
      view = { q = '<Cmd>DiffviewClose<CR>' },
      file_panel = { q = '<Cmd>DiffviewClose<CR>' },
      file_history_panel = { q = '<Cmd>DiffviewClose<CR>' },
    },
  })
end

function config.dashboard()
  require('modules.ui.dashboard')
end

function config.noice()
  require('modules.ui.noice')
end

return config
