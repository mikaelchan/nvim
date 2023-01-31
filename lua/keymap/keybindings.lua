local keymap = require('core.keymap')
local nmap, omap, map = keymap.nmap, keymap.omap, keymap.map
local silent, noremap  = keymap.silent, keymap.noremap
local opts = keymap.new_opts(silent, noremap)
local cmd = keymap.cmd

-- set hop keybindings
nmap({
  { 's', cmd('HopChar2MW'), opts },
  { 'S', cmd('HopWordMW'), opts },
  {
    'f',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })"
    ),
  },
  {
    'F',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })"
    ),
  },
})
omap({
  {
    'f',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })"
    ),
  },
  {
    'F',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })"
    ),
  },
})
map({
  {
    't',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })"
    ),
  },
  {
    'T',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = -1 })"
    ),
  },
})

-- set hlslens keybindings
nmap({
  { 'n', cmd("execute('normal! ' . v:count1 . 'n')") .. cmd("lua require('hlslens').start()"), opts },
  { 'N', cmd("execute('normal! ' . v:count1 . 'N')") .. cmd("lua require('hlslens').start()"), opts },
  { '*', '*' .. cmd("lua require('hlslens').start()"), opts },
  { '#', '#' .. cmd("lua require('hlslens').start()"), opts },
  { 'g*', 'g*' .. cmd("lua require('hlslens').start()"), opts },
  { 'g#', 'g#' .. cmd("lua require('hlslens').start()"), opts },
})

-- set lspsaga keybindings
nmap({
  { ']e', cmd('Lspsaga diagnostic_jump_next') },
  { '[e', cmd('Lspsaga diagnostic_jump_prev') },
  { '[c', cmd('Lspsaga show_cursor_diagnostics') },
  { 'K', cmd('Lspsaga hover_doc') },
  { 'ga', cmd('Lspsaga code_action') },
  { 'gd', cmd('Lspsaga peek_definition') },
  { 'gD', cmd('Lspsaga goto_definition') },
  { 'gr', cmd('Lspsaga rename ++project')},
  { 'gh', cmd('Lspsaga lsp_finder') },
})
