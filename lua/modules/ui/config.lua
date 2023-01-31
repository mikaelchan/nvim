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
        indicator = string.format('%d%s', abs_r_idx, sfw ~= (r_idx > 1) and '' or '')
      elseif abs_r_idx == 1 then
        indicator = sfw ~= (r_idx == 1) and '' or ''
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

function config.colorozer()
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

function config.indent_blankline()
  require('indent_blankline').setup({
    enabled = true,
    bufname_exclude = { 'README.md' },
    buftype_exclude = { 'terminal', 'nofile' },
    filetype_exclude = {
      'alpha',
      'log',
      'gitcommit',
      'dapui_scopes',
      'dapui_stacks',
      'dapui_watches',
      'dapui_breakpoints',
      'dapui_hover',
      'LuaTree',
      'dbui',
      'UltestSummary',
      'UltestOutput',
      'vimwiki',
      'markdown',
      'json',
      'txt',
      'NvimTree',
      'git',
      'TelescopePrompt',
      'undotree',
      'flutterToolsOutline',
      'org',
      'orgagenda',
      'help',
      'startify',
      'dashboard',
      'lazy',
      'neogitstatus',
      'Outline',
      'Trouble',
      'lspinfo',
      '', -- for all buffers without a file type
    },
    -- char = "▏",
    char_list = { '', '┊', '┆', '¦', '|', '¦', '┆', '┊', '' },
    char_highlight_list = {
      'IndentBlanklineIndent1',
      'IndentBlanklineIndent2',
      'IndentBlanklineIndent3',
      'IndentBlanklineIndent4',
      'IndentBlanklineIndent5',
      'IndentBlanklineIndent6',
    },
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    space_char_blankline = ' ',
    use_treesitter = true,
    show_foldtext = false,
    show_current_context = true,
    show_current_context_start = false,
    context_patterns = {
      'class',
      'return',
      'function',
      'method',
      '^if',
      '^do',
      '^switch',
      '^while',
      'jsx_element',
      '^for',
      '^object',
      '^table',
      'block',
      'arguments',
      'if_statement',
      'else_clause',
      'jsx_element',
      'jsx_self_closing_element',
      'try_statement',
      'catch_clause',
      'import_statement',
      'operation_type',
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

return config
