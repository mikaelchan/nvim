local config = {}

function config.nvim_treesitter()
  require('modules.editor.treesitter')
end

function config.which_key()
  require('which-key').setup({
    plugins = {
      marks = true,
      registers = true,
      spelling = {
        enabled = true,
        suggestions = 20,
      },
      presets = {
        operators = false,
        motions = false,
        text_objects = false,
        windows = false,
        nav = false,
        z = true,
        g = true,
      },
    },
    icons = {
      breadcrumb = '»',
      separator = '·',
      group = '',
    },
    keys = {
      scroll_down = '<C-d>',
      scroll_up = '<C-u>',
    },
    win = {
      border = 'rounded',
      padding = { 2, 2, 2, 2 },
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = 'left',
    },
    -- hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' },
    show_help = true,
    show_keys = true,
    disable = {
      buftypes = { 'terminal' },
      filetypes = { 'TelescopePrompt' },
    },
  })
end

function config.gopher()
  require('gopher').setup({
    commands = {
      go = 'go',
      gomodifytags = 'gomodifytags',
      gotests = 'gotests',
      impl = 'impl',
      iferr = 'iferr',
    },
  })
end

function config.nvim_navic()
  require('modules.editor.winbar').setup()
end

function config.illuminate()
  require('illuminate').configure({
    providers = {
      'lsp',
      'treesitter',
      'regex',
    },
    delay = 120,
    filetype_overrides = {},
    filetypes_denylist = {
      'dirvish',
      'fugitive',
      'alpha',
      'NvimTree',
      'lazy',
      'neogitstatus',
      'Trouble',
      'lir',
      'Outline',
      'spectre_panel',
      'toggleterm',
      'DressingSelect',
      'TelescopePrompt',
    },
    filetypes_allowlist = {},
    modes_denylist = {},
    modes_allowlist = {},
    providers_regex_syntax_denylist = {},
    providers_regex_syntax_allowlist = {},
    under_cursor = true,
  })
end

function config.lsp_lines()
  require('lsp_lines').setup()
end

function config.lsp_inlayhints()
  require('lsp-inlayhints').setup()
end

function config.crates()
  require('crates').setup()
end

return config
