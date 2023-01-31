local telescope = require('telescope')
local actions = require('telescope.actions')
local fb_actions = require('telescope').extensions.file_browser.actions
telescope.setup({
  defaults = {
    prompt_prefix = ' ',
    selection_caret = ' ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = nil,
    layout_config = {},
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
      '--glob=!.git/',
    },
    mappings = {
      i = {
      ["<c-c>"] = actions.close,
      ["<c-y>"] = actions.which_key,
      ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
      ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
      ["<c-j>"] = actions.move_selection_next,
      ["<c-k>"] = actions.move_selection_previous,
      ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
    },
    n = {
      ["<esc>"] = actions.close,
      ["<tab>"] = actions.toggle_selection + actions.move_selection_next,
      ["<s-tab>"] = actions.toggle_selection + actions.move_selection_previous,
      ["<c-j>"] = actions.move_selection_next,
      ["<c-k>"] = actions.move_selection_previous,
      ["<c-n>"] = actions.cycle_history_next,
      ["<c-p>"] = actions.cycle_history_prev,
      ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      ["dd"] = actions.delete_buffer,
    },
    },
    file_ignore_patterns = {},
    path_display = { 'smart' },
    winblend = 0,
    border = {},
    borderchars = nil,
    color_devicons = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    live_grep = {
      only_sort_text = true,
    },
    grep_string = {
      only_sort_text = true,
    },
    buffers = {
      initial_mode = 'normal',
      mappings = {
        i = {
          ['<C-d>'] = actions.delete_buffer,
        },
        n = {
          ['dd'] = actions.delete_buffer,
        },
      },
    },
    planets = {
      show_pluto = true,
      show_moon = true,
    },
    git_files = {
      hidden = true,
      show_untracked = true,
    },
    colorscheme = {
      enable_preview = true,
    },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    },
    file_browser = {
      mappings = {
        ['n'] = {
          ['c'] = fb_actions.create,
          ['r'] = fb_actions.rename,
          ['d'] = fb_actions.remove,
          ['o'] = fb_actions.open,
          ['u'] = fb_actions.goto_parent_dir,
        },
      },
    },
  },
})

telescope.load_extension('fzy_native')
telescope.load_extension('projects')
telescope.load_extension('file_browser')
telescope.load_extension('luasnip')
telescope.load_extension('dotfiles')
telescope.load_extension('gosource')
telescope.load_extension('app')
