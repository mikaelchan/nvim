local file_icons = {
  Brown = { '' },
  Aqua = { '' },
  LightBlue = { '', '' },
  Blue = { '', '', '', '', '', '', '', '', '', '', '', '', '' },
  DarkBlue = { '', '' },
  Purple = { '', '', '', '', '' },
  Red = { '', '', '', '', '', '' },
  Beige = { '', '', '' },
  Yellow = { '', '', 'λ', '', '' },
  peach = { '', '' },
  Darkpeach = { '', '', '', '', '' },
  Pink = { '', '' },
  Salmon = { '' },
  Green = { '', '', '', '', '', '' },
  LightGreen = { '', '', '', '﵂' },
  White = { '', '', '', '', '', '' },
}
local numbers = {
  ' ',
  ' ',
  ' ',
  ' ',
  ' ',
  ' ',
  ' ',
  ' ',
  ' ',
  ' ',
}
local function env_cleanup(venv)
  if string.find(venv, '/') then
    local final_venv = venv
    for w in venv:gmatch('([^/]+)') do
      final_venv = w
    end
    venv = final_venv
  end
  return venv
end

local function clock()
  return ' ' .. os.date('%H:%M')
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed,
    }
  end
end

local function testing()
  if vim.g.testing_status == 'running' then
    return ' '
  end
  if vim.g.testing_status == 'fail' then
    return ''
  end
  if vim.g.testing_status == 'pass' then
    return ' '
  end
  return nil
end

local mode = function()
  local mod = vim.fn.mode()
  if mod == 'n' or mod == 'no' or mod == 'nov' then
    return '  '
  elseif mod == 'i' or mod == 'ic' or mod == 'ix' then
    return '  '
  elseif mod == 'V' or mod == 'v' or mod == 'vs' or mod == 'Vs' or mod == 'cv' then
    return '  '
  elseif mod == 'c' or mod == 'ce' then
    return '  '
  elseif mod == 'r' or mod == 'rm' or mod == 'r?' or mod == 'R' or mod == 'Rc' or mod == 'Rv' or mod == 'Rv' then
    return '  '
  end
  return '  '
end

local file_icon_colors = {
  Brown = '#905532',
  Aqua = '#3AFFDB',
  Blue = '#689FB6',
  DarkBlue = '#44788E',
  Purple = '#834F79',
  Red = '#AE403F',
  Beige = '#F5C06F',
  Yellow = '#F09F17',
  peach = '#D4843E',
  Darkpeach = '#F16529',
  Pink = '#CB6F6F',
  Salmon = '#EE6E73',
  Green = '#8FAA54',
  LightGreen = '#31B53E',
  White = '#FFFFFF',
  LightBlue = '#5fd7ff',
}

local function get_file_info()
  return vim.fn.expand('%:t'), vim.fn.expand('%:e')
end

local function get_file_icon()
  local devicons = require('nvim-web-devicons')

  local f_name, f_extension = get_file_info()
  local icon = devicons.get_icon(f_name, f_extension)
  if icon then
    return icon
  end

  return ' '
end

local function get_file_icon_color()
  local f_name, f_ext = get_file_info()
  local devicons = require('nvim-web-devicons')
  local icon, iconhl = devicons.get_icon(f_name, f_ext)
  if icon then
    return vim.fn.synIDattr(vim.fn.hlID(iconhl), 'fg')
  end

  icon = get_file_icon():match('%S+')
  for k, _ in pairs(file_icons) do
    if vim.fn.index(file_icons[k], icon) ~= -1 then
      return file_icon_colors[k]
    end
  end
end

local colors = require('catppuccin.palettes').get_palette()

-- Color table for highlights
local mode_color = {
  n = colors.red,
  i = colors.green,
  v = colors.yellow,
  [''] = colors.blue,
  V = colors.yellow,
  c = colors.teal,
  no = colors.mauve,
  s = colors.peach,
  S = colors.peach,
  [''] = colors.peach,
  ic = colors.yellow,
  R = colors.mauve,
  Rv = colors.mauve,
  cv = colors.red,
  ce = colors.red,
  r = colors.teal,
  rm = colors.teal,
  ['r?'] = colors.teal,
  ['!'] = colors.red,
  t = colors.red,
}
local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.o.columns > 80
  end,
  hide_small = function()
    return vim.o.columns > 140
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    icons_enabled = true,
    -- Disable sections and component separators
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    theme = 'catppuccin',
    disabled_filetypes = {
      'dashboard',
      'NvimTree',
      'Outline',
      'alpha',
      'TelescopePrompt',
    },
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},

    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_v = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {
      {
        function()
          return '  '
        end,
        color = function()
          return { fg = mode_color[vim.fn.mode()], bg = colors.base }
        end,
        padding = { left = 1, right = 0 },
      },
      {
        'filename',
        cond = conditions.buffer_not_empty and conditions.hide_in_width,
        color = { fg = colors.blue, gui = 'bold' },
      },
    },
    lualine_x = {},
  },
}

config.options.disabled_filetypes = { 'dashboard' }

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

table.insert(config.sections.lualine_a, {
  function()
    return mode()
  end,
  color = function()
    return { bg = mode_color[vim.fn.mode()], fg = colors.surface1 }
  end,
})
table.insert(config.sections.lualine_b, {
  'b:gitsigns_head',
  icon = ' ',
  cond = conditions.check_git_workspace and conditions.hide_in_width,
  color = { fg = colors.blue, bg = colors.surface1 },
  padding = 0,
})

ins_left({
  function()
    local filename = vim.fn.expand('%:t')
    local kube_env = vim.env.KUBECONFIG
    local kube_filename = 'kubectl-edit'
    if (vim.bo.filetype == 'yaml') and (string.sub(filename, 1, kube_filename:len()) == kube_filename) then
      return string.format('⎈  (%s)', env_cleanup(kube_env))
    end
    return ''
  end,
  color = { fg = colors.teal, bg = colors.surface1 },
  cond = conditions.hide_small,
})

ins_left({
  function()
    vim.api.nvim_command(
      'hi! LualineFileIconColor guifg=' .. get_file_icon_color() .. ' guibg=' .. colors.surface1 .. ' gui=bold'
    )
    local fname = vim.fn.expand('%:p')
    if string.find(fname, 'term://') ~= nil then
      return ' '
    end
    local winnr = vim.api.nvim_win_get_number(vim.api.nvim_get_current_win())
    if winnr > 10 then
      winnr = 10
    end
    local win = numbers[winnr]
    return win .. ' ' .. get_file_icon()
  end,
  padding = { left = 2, right = 0 },
  cond = conditions.buffer_not_empty and conditions.hide_small,
  color = 'LualineFileIconColor',
})

ins_left({
  function()
    local fname = vim.fn.expand('%:p')
    local filename = vim.fn.expand('%:t')
    local kube_filename = 'kubectl-edit'
    local ftype = vim.bo.filetype
    local cwd = vim.api.nvim_call_function('getcwd', {})
    if (vim.bo.filetype == 'yaml') and (string.sub(filename, 1, kube_filename:len()) == kube_filename) then
      return 'kubernetes'
    end
    if (vim.fn.has('linux') == 1) or (vim.fn.has('mac') == 1) then
      if string.find(fname, 'zsh;#toggleterm') ~= nil then
        return cwd
      elseif string.find(fname, 'lazygit;#toggleterm') ~= nil then
        local git_repo_cmd = io.popen('git remote get-url origin | tr -d "\n"')
        local git_repo = git_repo_cmd:read('*a')
        git_repo_cmd:close()
        local git_branch_cmd = io.popen('git branch --show-current | tr -d "\n"')
        local git_branch = git_branch_cmd:read('*a')
        git_branch_cmd:close()
        return git_repo .. '~' .. git_branch
      elseif #ftype < 1 and string.find(fname, 'term') ~= nil then
        return cwd
      end
    end
    local show_name = vim.fn.expand('%:t')
    if #cwd > 0 and #ftype > 0 then
      show_name = fname:sub(#cwd + 2)
    end
    local readonly = ''
    local modified = ''
    if vim.bo.readonly then
      readonly = '  '
    end
    if vim.bo.modified then
      modified = '  '
    end
    return show_name .. readonly .. modified
  end,
  cond = conditions.buffer_not_empty and conditions.hide_small,
  padding = { left = 1, right = 1 },
  color = { fg = colors.text, gui = 'bold', bg = colors.surface1 },
})

ins_left({
  'diff',
  source = diff_source,
  symbols = { added = '  ', modified = '柳', removed = ' ' },
  diff_color = {
    added = { fg = colors.green, bg = colors.surface1 },
    modified = { fg = colors.blue, bg = colors.surface1 },
    removed = { fg = colors.red, bg = colors.surface1 },
  },
  color = {},
  cond = nil,
})

ins_left({
  function()
    if vim.bo.filetype == 'python' then
      local venv = vim.env.CONDA_DEFAULT_ENV
      if venv then
        return string.format('  (%s)', env_cleanup(venv))
      end
      venv = vim.env.VIRTUAL_ENV
      if venv then
        return string.format('  (%s)', env_cleanup(venv))
      end
      return ''
    end
    return ''
  end,
  color = { fg = colors.green },
  cond = conditions.hide_in_width,
})

ins_left({
  provider = function()
    return testing()
  end,
  enabled = function()
    return testing() ~= nil
  end,
  hl = {
    fg = colors.text,
  },
  left_sep = ' ',
  right_sep = {
    str = ' |',
    hl = { fg = colors.text },
  },
})


ins_right({
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = '', hint = ' ' },
  cond = conditions.hide_in_width,
  color = { fg = colors.text, bg = colors.surface1 },
})

ins_right({
  function()
    return ''
  end,
  color = function()
    local buf = vim.api.nvim_get_current_buf()
    local ts = vim.treesitter.highlighter.active[buf]
    return { fg = ts and not vim.tbl_isempty(ts) and colors.green or colors.red, bg = colors.surface1 }
  end,
  cond = conditions.hide_in_width,
})
ins_right({
  function(msg)
    msg = msg or '轢LS Inactive'
    local buf_clients = vim.lsp.buf_get_clients()
    if next(buf_clients) == nil then
      if type(msg) == 'boolean' or #msg == 0 then
        return '轢LS Inactive'
      end
      return msg
    end
    local buf_ft = vim.bo.filetype
    local buf_client_names = {}
    local only_lsp = ''
    local lsp_icon = '歷'
    for _, client in pairs(buf_clients) do
      if client.name ~= 'null-ls' then
        local _added_client = client.name
        only_lsp = only_lsp .. _added_client
        _added_client = string.sub(client.name, 1, 7)
        if client.name == 'copilot' then
          lsp_icon = ' '
        else
          table.insert(buf_client_names, _added_client)
        end
      end
    end

    -- add formatter
    local supported_formatters = require('null-ls.sources').get_supported(buf_ft, 'formatting')
    table.sort(supported_formatters)
    for _, fmt in pairs(supported_formatters) do
      table.insert(buf_client_names, string.sub(fmt, 1, 4))
    end

    -- add linter
    local supported_linters = require('null-ls.sources').get_supported(buf_ft, 'diagnostics')
    table.sort(supported_linters)
    for _, lnt in pairs(supported_linters) do
      table.insert(buf_client_names, string.sub(lnt, 1, 4))
    end

    if conditions.hide_small() then
      return lsp_icon .. table.concat(buf_client_names, ', ')
    elseif conditions.hide_in_width() then
      return only_lsp
    else
      return string.sub(only_lsp, 1, 5)
    end
  end,
  color = { fg = colors.text, bg = colors.surface1 },
  cond = conditions.hide_in_width,
})

ins_right({
  'location',
  padding = 0,
  color = { fg = colors.peach, bg = colors.surface1 },
})

ins_right({
  function()
    local function format_file_size(file)
      local size = vim.fn.getfsize(file)
      if size <= 0 then
        return ''
      end
      local sufixes = { 'b', 'k', 'm', 'g' }
      local i = 1
      while size > 1024 do
        size = size / 1024
        i = i + 1
      end
      return string.format('%.1f%s', size, sufixes[i])
    end

    local file = vim.fn.expand('%:p')
    if string.len(file) == 0 then
      return ''
    end
    return format_file_size(file)
  end,
  color = { fg = colors.rosewater, bg = colors.surface1 },
  cond = conditions.buffer_not_empty and conditions.hide_small,
})
table.insert(config.sections.lualine_y, {
  'fileformat',
  fmt = string.upper,
  icons_enabled = true,
  color = { fg = colors.green, bg = colors.surface1, gui = 'bold' },
  cond = conditions.hide_small,
})

table.insert(config.sections.lualine_y, {
  clock,
  cond = conditions.hide_small,
  color = { fg = colors.blue, bg = colors.surface1 },
})

table.insert(config.sections.lualine_z, {
  function()
    local current_line = vim.fn.line('.')
    local total_lines = vim.fn.line('$')
    local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end,
  padding = 0,
  color = { fg = colors.yellow, bg = colors.surface1 },
  cond = nil,
})

require('lualine').setup(config)
