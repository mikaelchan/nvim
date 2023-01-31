local notify = require('notify')
notify.setup({
  background_colour = '#000000',
  fps = 60,
  icons = {
    DEBUG = ' ',
    ERROR = ' ',
    INFO = '',
    TRACE = ' ',
    WARN = ' ',
  },
  level = vim.log.levels.ERROR,
  minimum_width = 50,
  render = 'compact',
  stages = 'slide',
  timeout = 1500,
  top_down = true,
})
local noice = require('noice')
local cursor_input_opts = {
  relative = 'cursor',
  size = { min_width = 20 },
  position = { row = 2, col = -2 },
}
local spinners = require('noice.util.spinners')
spinners.spinners['mine'] = {
  frames = {
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
    ' ',
  },
  interval = 80,
}
noice.setup({
  format = {
    spinner = {
      name = 'mine',
      hl = 'Constant',
    },
  },
  lsp = {
    progress = {
      format_done = {},
    },
    override = {
      ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
      ['vim.lsp.util.stylize_markdown'] = true,
      ['cmp.entry.get_documentation'] = true,
    },
  },
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    command_palette = false, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = true, -- add a border to hover docs and signature help
  },
  messages = {
    enabled = true,
    view_search = false,
  },
  history  = {view = 'popup'},
  cmdline = {
    format = {
      filter = { pattern = '^:%s*!', icon = '󰘳 ', ft = 'sh' },
      search_down = { icon = ' ' },
      search_up = { icon = ' ' },
      help = { icon = ' ' },
    },
  },
  views = {
    cmdline_popup = {
      position = {
        row = '20%',
        col = '50%',
      },
    },
    confirm = {
      position = {
        row = '80%',
        col = '50%',
      },
    },
    popup = {
      border = {
        style = 'rounded',
        text = {
          top = '  Noice ',
          top_align = 'center',
        },
      },
    },
    notify = {
      win_options = {
        winblend = 0,
      },
    },
    mini = {
      win_options = {
        winblend = 0,
      },
    },
  },
  popupmenu = {
    enabled = false,
  },
  routes = {
    {
      view = 'notify',
      filter = { event = 'msg_showmode' },
    },
    {
      filter = {
        event = 'msg_show',
        find = '%d+L, %d+B',
      },
      view = 'mini',
    },
    {
      view = 'cmdline_output',
      filter = { cmdline = '^:', min_height = 5 },
    },
    {
      filter = { event = 'msg_show', kind = 'search_count' },
      opts = { skip = true },
    },
    {
      filter = {
        event = 'msg_show',
        find = '; before #',
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = 'msg_show',
        find = '; after #',
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = 'msg_show',
        find = 'lines',
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = 'msg_show',
        find = 'go up one level',
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = 'msg_show',
        find = 'yanked',
      },
      opts = { skip = true },
    },
    {
      filter = { find = 'No active Snippet' },
      opts = { skip = true },
    },
    {
      filter = { find = 'waiting for cargo metadata' },
      opts = { skip = true },
    },
    {
        view = "popup",
        filter = {
          any = {
            { event = "msg_history_show" },
            { event = "msg_show", min_height = 10 },
          },
        },
      },
  },
})
