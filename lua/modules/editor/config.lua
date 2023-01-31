local config = {}

function config.nvim_treesitter()
  vim.api.nvim_command('set foldmethod=expr')
  vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  require('nvim-treesitter.configs').setup({
    ensure_installed = 'all',
    ignore_install = { 'phpdoc' },
    highlight = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
    },
  })
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
        g = false,
      },
    },
    operators = {},
    key_labels = {},
    icons = {
      breadcrumb = '»',
      separator = '·',
      group = '',
    },
    popup_mappings = {
      scroll_down = '<C-d>',
      scroll_up = '<C-u>',
    },
    window = {
      border = 'rounded',
      position = 'bottom',
      margin = { 1, 0, 1, 0 },
      padding = { 2, 2, 2, 2 },
      winblend = 0,
    },
    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 3,
      align = 'left',
    },
    ignore_missing = true,
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' },
    show_help = true,
    show_keys = true,
    triggers = 'auto',
    triggers_blacklist = {
      i = { 'j', 'k' },
      v = { 'j', 'k' },
    },
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

return config
