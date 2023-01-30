local config = {}

function config.nvim_bufferline()
  require('modules.ui.bufferline')
end

function config.nvim_tree()
  require('nvim-tree').setup({
    disable_netrw = false,
    hijack_cursor = true,
    hijack_netrw = true,
  })
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


return config
