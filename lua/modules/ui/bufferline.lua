local bufferline_groups = require('bufferline.groups')

require('bufferline').setup({
  options = {
    navigation = { mode = 'uncentered' },
    diagnostics = 'nvim_lsp',
    diagnostics_indicator = function(_, _, diagnostics)
      local result = {}
      local symbols = { error = ' ', warning = ' ', info = '' }
      for name, count in pairs(diagnostics) do
        if symbols[name] and count > 0 then
          table.insert(result, symbols[name] .. count)
        end
      end
      local res = table.concat(result, ' ')
      return #res > 0 and res or ''
    end,
    mode = 'buffers',
    sort_by = 'insert_after_current',
    always_show_bufferline = false,
    groups = {
      options = {
        toggle_hidden_on_enter = true,
      },
      items = {
        ---@diagnostic disable-next-line: redundant-parameter
        bufferline_groups.builtin.pinned:with({ icon = ' ' }),
        bufferline_groups.builtin.ungrouped,
        {
          name = 'Dependencies',
          icon = ' ',
          highlight = { fg = '#ECBE7B' },
          matcher = function(buf)
            return vim.startswith(buf.path, string.format('%s/site/pack/lazy', vim.fn.stdpath('data')))
              or vim.startswith(buf.path, vim.fn.expand('$VIMRUNTIME'))
          end,
        },
        {
          highlight = { sp = '#51AFEF' },
          name = 'tests',
          icon = ' ',
          matcher = function(buf)
            local name = buf.filename
            return name:match('_spec') or name:match('_test') or name:match('test_')
          end,
        },
        {
          name = 'Terraform',
          matcher = function(buf)
            return buf.name:match('%.tf') ~= nil
          end,
        },
        {
          name = 'SQL',
          matcher = function(buf)
            return buf.filename:match('%.sql$')
          end,
        },
        {
          name = 'view models',
          highlight = { sp = '#03589C' },
          matcher = function(buf)
            return buf.filename:match('view_model%.dart')
          end,
        },
        {
          name = 'screens',
          icon = '冷',
          matcher = function(buf)
            return buf.path:match('screen')
          end,
        },
        {
          highlight = { sp = '#C678DD' },
          name = 'docs',
          matcher = function(buf)
            for _, ext in ipairs({ 'md', 'txt', 'org', 'norg', 'wiki' }) do
              if ext == vim.fn.fnamemodify(buf.path, ':e') then
                return true
              end
            end
          end,
        },
        {
          highlight = { sp = '#F6A878' },
          name = 'config',
          matcher = function(buf)
            local filename = buf.filename
            if filename == nil then
              return false
            end
            return filename:match('go.mod')
              or filename:match('go.sum')
              or filename:match('Cargo.toml')
              or filename:match('manage.py')
              or filename:match('Makefile')
          end,
        },
      },
    },
    hover = { enabled = true, reveal = { 'close' } },
    offsets = {
      {
        text = ' EXPLORER',
        filetype = 'NvimTree',
        highlight = 'PanelHeading',
        text_align = 'left',
        separator = true,
      },
      {
        text = ' FLUTTER OUTLINE',
        filetype = 'flutterToolsOutline',
        highlight = 'PanelHeading',
        separator = true,
      },
      {
        text = ' UNDOTREE',
        filetype = 'undotree',
        highlight = 'PanelHeading',
        separator = true,
      },
      {
        text = ' LAZY',
        filetype = 'lazy',
        highlight = 'PanelHeading',
        separator = true,
      },
      {
        text = ' DATABASE VIEWER',
        filetype = 'dbui',
        highlight = 'PanelHeading',
        separator = true,
      },
      {
        text = ' DIFF VIEW',
        filetype = 'DiffviewFiles',
        highlight = 'PanelHeading',
        separator = true,
      },
    },
    separator_style = 'thin',
    right_mouse_command = 'vert sbuffer %d',
    show_close_icon = false,
    -- indicator = { style = "bold" },
    indicator = {
      icon = '▎', -- this should be omitted if indicator style is not 'icon'
      style = 'icon', -- can also be 'underline'|'none',
    },
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    truncate_names = true, -- whether or not tab names should be truncated
    numbers= 'ordinal',
    tab_size = 18,
    color_icons = true,
    show_buffer_close_icons = false,
    diagnostics_update_in_insert = false,
  },
  highlights = {
    background = { italic = true },
    buffer_selected = { bold = true },
  },
})
