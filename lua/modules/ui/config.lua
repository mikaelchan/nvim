local config = {}

function config.nvim_bufferline()
  require('modules.ui.bufferline')
end

function config.nvim_tree()
  require('modules.ui.nvim_tree')
end

function config.catppuccin()
  require('catppuccin').setup({
    flavour = 'mocha', -- latte, frappe, macchiato, mocha
    background = { -- :h background
      light = 'latte',
      dark = 'mocha',
    },
    transparent_background = true, -- disables setting the background color.
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { 'italic' }, -- Change the style of comments
      conditionals = { 'italic' },
      loops = {},
      functions = { 'italic' },
      keywords = { 'italic' },
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = { 'italic' },
      operators = {},
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = true,
      mini = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = true,
      },
      dashboard = true,
      harpoon = true,
      hop = true,
      lsp_saga = true,
      markdown = true,
      mason = true,
      noice = true,
      overseer = true,
      rainbow_delimiters = true,
      which_key = true,
    },
  })

  -- setup must be called before loading
  vim.cmd.colorscheme('catppuccin')
end

function config.galaxyline()
  require('modules.ui.eviline')
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

function config.hlslens()
  require('hlslens').setup({
    auto_enable = true,
    calm_down = true,
    enable_incsearch = false,
    nearest_only = false,
    override_lens = function(render, plist, nearest, idx, r_idx)
      local sfw = vim.v.searchforward == 1
      local indicator, text, chunks
      local abs_r_idx = math.abs(r_idx)
      if abs_r_idx > 1 then
        indicator = string.format('%d%s', abs_r_idx, sfw ~= (r_idx > 1) and '' or '')
      elseif abs_r_idx == 1 then
        indicator = sfw ~= (r_idx == 1) and '' or ''
      else
        indicator = ''
      end

      local lnum, col = unpack(plist[idx])
      if nearest then
        local cnt = #plist
        if indicator ~= '' then
          text = string.format('[%s %d/%d]', indicator, idx, cnt)
        else
          text = string.format('[%d/%d]', idx, cnt)
        end
        chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
      else
        text = string.format('[%s %d]', indicator, idx)
        chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
      end
      render.set_virt(0, lnum - 1, col - 1, chunks, nearest)
    end,
  })
end

function config.colorizer()
  require('colorizer').setup({ '*' }, {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
  })
end

function config.rainbow_delimiters()
  local rainbow_delimiters = require('rainbow-delimiters')

  vim.g.rainbow_delimiters = {
    strategy = {
      [''] = rainbow_delimiters.strategy['global'],
      vim = rainbow_delimiters.strategy['local'],
    },
    query = {
      [''] = 'rainbow-delimiters',
      lua = 'rainbow-blocks',
    },
    highlight = {
      'RainbowDelimiterRed',
      'RainbowDelimiterYellow',
      'RainbowDelimiterBlue',
      'RainbowDelimiterOrange',
      'RainbowDelimiterGreen',
      'RainbowDelimiterViolet',
      'RainbowDelimiterCyan',
    },
  }
end

function config.indent_blankline()
  local highlight = {
    'RainbowRed',
    'RainbowYellow',
    'RainbowBlue',
    'RainbowOrange',
    'RainbowGreen',
    'RainbowViolet',
    'RainbowCyan',
  }
  require('ibl').setup({
    indent = { highlight = highlight },
    exclude = {
      filetypes = {
        'lspinfo',
        'packer',
        'checkhealth',
        'help',
        'man',
        'gitcommit',
        'TelescopePrompt',
        'TelescopeResults',
        'dashboard',
      },
    },
  })
end

function config.dressing()
  require('dressing').setup({
    input = {
      get_config = function()
        return { enabled = false }
      end,
    },
    select = {
      format_item_override = {
        codeaction = function(action_tuple)
          local title = action_tuple[2].title:gsub('\r\n', '\\r\\n')
          local client = vim.lsp.get_client_by_id(action_tuple[1])
          return string.format('%s\t[%s]', title:gsub('\n', '\\n'), client.name)
        end,
      },
    },
  })
end

function config.hlargs()
  require('hlargs').setup()
end

function config.dadbod_ui()
  vim.g.db_ui_use_nerd_fonts = 1
  vim.g.db_ui_show_database_icon = 1
end

function config.neoscroll()
  require('neoscroll').setup({
    easing_function = 'quadratic',
    hide_cursor = true,
  })
end

function config.zen_mode()
  require('modules.ui.zen_mode')
end

return config
