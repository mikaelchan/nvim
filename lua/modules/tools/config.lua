local config = {}

function config.telescope()
  require('modules.tools.telescope')
end

function config.toggleterm()
  require('toggleterm').setup({
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = false,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = 'curved',
      winblend = 0,
      highlights = {
        border = 'Normal',
        background = 'Normal',
      },
    },
  })
end

function config.dap()
  require('modules.tools.dap')
end

function config.hop()
  require('hop').setup({})
end

function config.persistence()
  require('persistence').setup({
    dir = vim.fn.stdpath('state') .. '/sessions/',
    options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
  })
end

function config.spectre()
  require('modules.tools.spectre')
end

function config.autopairs()
  require('nvim-autopairs').setup({
    map_char = {
      all = '(',
      tex = '{',
    },
    ---@usage check bracket in same line
    enable_check_bracket_line = false,
    ---@usage check treesitter
    check_ts = true,
    ts_config = {
      lua = { 'string', 'source' },
      javascript = { 'string', 'template_string' },
      java = false,
    },
    disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
    ignored_next_char = string.gsub([[ [%w%%%'%[%"%.] ]], '%s+', ''),
    enable_moveright = true,
    ---@usage disable when recording or executing a macro
    disable_in_macro = false,
    ---@usage add bracket pairs after quote
    enable_afterquote = true,
    ---@usage map the <BS> key
    map_bs = true,
    ---@usage map <c-w> to delete a pair if possible
    map_c_w = false,
    ---@usage disable when insert after visual block mode
    disable_in_visualblock = false,
    ---@usage  change default fast_wrap
    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
      offset = 0, -- Offset from pattern match
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      highlight = 'Search',
      highlight_grey = 'Comment',
    },
  })
end

function config.dap_go()
  require('dap-go').setup()
end

function config.dap_python()
  require('dap-python').setup('~/Workspace/.virtualenvs/debugpy/bin/python')
  require('dap-python').test_runner = 'pytest'
end

function config.dap_js()
  require('dap-vscode-js').setup({
    debugger_path = '~/Workspace/vscode-js-debug',
    debugger_cmd = { 'js-debug-adapter' },
    adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' },
  })
end

function config.todo_comments()
  local icons = {
    FIX = '律',
    TODO = '璘',
    HACK = ' ',
    WARN = '裂',
    PERF = '龍',
    NOTE = ' ',
    ERROR = ' ',
    REFS = '',
    SHIELD = '',
  }
  require('todo-comments').setup({
    keywords = {
      FIX = { icon = icons.FIX },
      TODO = { icon = icons.TODO, alt = { 'WIP' } },
      HACK = { icon = icons.HACK, color = 'hack' },
      WARN = { icon = icons.WARN },
      PERF = { icon = icons.PERF },
      NOTE = { icon = icons.NOTE, alt = { 'INFO', 'NB' } },
      ERROR = { icon = icons.ERROR, color = 'error', alt = { 'ERR' } },
      REFS = { icon = icons.REFS },
      SAFETY = { icon = icons.SHIELD, color = 'hint' },
    },
    highlight = { max_line_len = 120 },
    colors = {
      error = { 'DiagnosticError' },
      warning = { 'DiagnosticWarn' },
      info = { 'DiagnosticInfo' },
      hint = { 'DiagnosticHint' },
      hack = { 'Function' },
      ref = { 'FloatBorder' },
      default = { 'Identifier' },
    },
  })
end

function config.comment()
  require('modules.tools.comment')
end

function config.neotest()
  require('modules.tools.neotest')
end

function config.neoclip()
  require('neoclip').setup({
    history = 50,
    enable_persistent_history = true,
    db_path = vim.fn.stdpath('data') .. '/neoclip.sqlite3',
    keys = {
      telescope = {
        i = { select = '<c-p>', paste = '<CR>', paste_behind = '<c-k>' },
        n = { select = 'p', paste = '<CR>', paste_behind = 'P' },
      },
    },
  })
end

function config.cheat()
  vim.g.cheat_default_window_layout = 'vertical_split'
end

function config.overseer()
  require('modules.tools.overseer')
end

function config.remember()
  require('remember').setup({})
end

return config
