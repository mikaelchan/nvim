local colors = require('catppuccin.palettes').get_palette()

require('catppuccin').setup({
  flavour = 'mocha',
  background = { light = 'latte', dark = 'mocha' },
  transparent_background = true,
  term_colors = true,
  styles = {
    comments = { 'italic' },
    keywords = { 'italic' },
    types = { 'bold', 'italic' },
    properties = { 'italic' },
  },
  compile = {
    enabled = true, -- NOTE: make sure to run `:CatppuccinCompile`
    path = vim.fn.stdpath('cache') .. '/catppuccin',
  },
  dim_inactive = {
    enabled = false,
    shade = 'dark',
    percentage = 0.15,
  },
  integrations = {
    cmp = true,
    dashboard = true,
    fidget = true,
    lsp_trouble = true,
    lsp_saga = true,
    telescope = true,
    treesitter = true,
    treesitter_context = true,
    ts_rainbow = true,
    mason = false,
    neotest = true,
    noice = true,
    harpoon = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { 'italic' },
        hints = {},
        warnings = { 'italic' },
        information = {},
      },
      underlines = {
        errors = { 'undercurl' },
        hints = {},
        warnings = { 'undercurl' },
        information = {},
      },
    },
    dap = {
      enabled = true,
      enable_ui = true,
    },
    indent_blankline = {
      enabled = true,
      colored_indent_levels = true,
    },
    gitsigns = true,
    notify = true,
    nvimtree = true,
    neotree = false,
    overseer = true,
    illuminate = true,
    symbols_outline = false,
    which_key = true,
    leap = false,
    hop = true,
  },
  custom_highlights = {
    Comment = { fg = colors.overlay1 },
    LineNr = { fg = colors.overlay1 },
    CursorLine = { bg = 'NONE' },
    CursorLineNr = { fg = colors.lavender },
    DiagnosticVirtualTextError = { bg = 'NONE' },
    DiagnosticVirtualTextWarn = { bg = 'NONE' },
    DiagnosticVirtualTextInfo = { bg = 'NONE' },
    DiagnosticVirtualTextHint = { bg = 'NONE' },
    LspInlayHint = { fg = colors.surface0, bg = 'NONE' },
    CmpBorder = { fg = colors.teal },
    IndentBlanklineSpaceChar = { fg = colors.subtext0 },
  },
})

vim.cmd([[colorscheme catppuccin]])
