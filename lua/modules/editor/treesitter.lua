local languages = vim.tbl_flatten({
  { 'bash', 'c', 'c_sharp', 'cmake', 'comment', 'cpp', 'css', 'd', 'dart' },
  { 'dockerfile', 'elixir', 'elm', 'erlang', 'fennel', 'fish', 'go', 'gomod' },
  { 'gomod', 'graphql', 'hcl', 'html', 'java', 'javascript', 'jsdoc' },
  { 'json', 'jsonc', 'julia', 'kotlin', 'ledger', 'lua', 'make' },
  { 'markdown', 'nix', 'ocaml', 'perl', 'php', 'python', 'query', 'r' },
  { 'regex', 'rego', 'ruby', 'rust', 'scala', 'scss', 'solidity' },
  { 'toml', 'tsx', 'typescript', 'vim', 'vue', 'yaml', 'zig' },
})
require('ts_context_commentstring').setup({
  enable = true,
  enable_autocmd = false,
  config = {
    -- Languages that have a single comment style
    typescript = '// %s',
    css = '/* %s */',
    scss = '/* %s */',
    html = '<!-- %s -->',
    svelte = '<!-- %s -->',
    vue = '<!-- %s -->',
    json = '',
  },
})
require('nvim-treesitter.configs').setup({
  ensure_installed = languages,
  ignore_install = {},
  parser_install_dir = nil,
  sync_install = false,
  auto_install = true,
  matchup = {
    enable = true,
  },
  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
    disable = function(lang, buf)
      if vim.tbl_contains({ 'latex' }, lang) then
        return true
      end

      local status_ok, big_file_detected = pcall(vim.api.nvim_buf_get_var, buf, 'bigfile_disable_treesitter')
      return status_ok and big_file_detected
    end,
  },
  indent = { enable = true, disable = { 'yaml', 'python' } },
  autotag = { enable = false },
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aA'] = '@attribute.outer',
        ['iA'] = '@attribute.inner',
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
        ['ac'] = '@call.outer',
        ['ic'] = '@call.inner',
        ['at'] = '@class.outer',
        ['it'] = '@class.inner',
        ['a/'] = '@comment.outer',
        ['i/'] = '@comment.inner',
        ['ai'] = '@conditional.outer',
        ['ii'] = '@conditional.inner',
        ['aF'] = '@frame.outer',
        ['iF'] = '@frame.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['is'] = '@scopename.inner',
        ['as'] = '@statement.outer',
        ['av'] = '@variable.outer',
        ['iv'] = '@variable.inner',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader><M-a>'] = '@parameter.inner',
        ['<leader><M-f>'] = '@function.outer',
        ['<leader><M-e>'] = '@element',
      },
      swap_previous = {
        ['<leader><M-A>'] = '@parameter.inner',
        ['<leader><M-F>'] = '@function.outer',
        ['<leader><M-E>'] = '@element',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']p'] = '@parameter.inner',
        [']f'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[p'] = '@parameter.inner',
        ['[f'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
  textsubjects = {
    enable = false,
    keymaps = { ['.'] = 'textsubjects-smart', [';'] = 'textsubjects-big' },
  },
  playground = {
    enable = false,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<C-n>',
      node_incremental = '<C-n>',
      scope_incremental = '<C-s>',
      node_decremental = '<C-r>',
    },
  },
  query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { 'BufWrite', 'CursorHold' },
  },
  rainbow = {
    enable = true,
    extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
    max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
  },
})
