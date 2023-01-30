require('keymap.keybindings')
require('keymap.which-keybindings')
local keymap = require('core.keymap')
local nmap, imap, xmap, tmap, vmap = keymap.nmap, keymap.imap, keymap.xmap, keymap.tmap, keymap.vmap
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts(silent, noremap)
local cmd, esc_cmd = keymap.cmd, keymap.esc_cmd

imap({
  -- Move current line / block with Alt-j/k
  { '<A-j>', esc_cmd('move .+1') .. '==gi', opts },
  { '<A-k>', esc_cmd('move .-2') .. '==gi', opts },
  -- Navigation
  { '<A-Up>', '<C-\\><C-N><C-w>k', opts },
  { '<A-Down>', '<C-\\><C-N><C-w>j', opts },
  { '<A-Left>', '<C-\\><C-N><C-w>h', opts },
  { '<A-Right>', '<C-\\><C-N><C-w>l', opts },
  -- Escape
  { 'jk', '<Esc>', opts },
  -- Select all
  { '<C-a>', '<Esc>ggVG', opts },
})

nmap({
  -- Move current line / block with Alt-j/k
  { '<A-j>', cmd('move .+1') .. '==', opts },
  { '<A-k>', cmd('move .-2') .. '==', opts },
  -- Window movement
  { '<C-h>', '<C-w>h', opts },
  { '<C-j>', '<C-w>j', opts },
  { '<C-k>', '<C-w>k', opts },
  { '<C-l>', '<C-w>l', opts },
  -- Resize with arrows
  { '<A-Up>', cmd('resize -2'), opts },
  { '<A-Down>', cmd('resize +2'), opts },
  { '<A-Left>', cmd('vertical resize -2'), opts },
  { '<A-Right>', cmd('vertical resize +2'), opts },
  -- Buffer movement
  { '<S-l>', cmd('BufferLineCycleNext'), opts },
  { '<S-h>', cmd('BufferLineCyclePrev'), opts },
  { '[b', cmd('BufferLineMoveNext'), opts },
  { ']b', cmd('BufferLineMovePrev'), opts },
  -- No hlsearch
  { '<Esc><Esc>', cmd('nohlsearch'), opts },
  -- Yank
  { 'Y', 'y$', opts },
})

tmap({
  { '<Esc>', '<C-\\><C-n>', opts },
  -- Terminal window navigation
  { '<C-h>', '<C-\\><C-N><C-w>h', opts },
  { '<C-j>', '<C-\\><C-N><C-w>j', opts },
  { '<C-k>', '<C-\\><C-N><C-w>k', opts },
  { '<C-l>', '<C-\\><C-N><C-w>l', opts },
})

vmap({
  -- Indentation
  { '<', '<gv', opts },
  { '>', '>gv', opts },
})

xmap({
  -- Move current line / block with Alt-j/k
  { '<A-j>', cmd("move '>+1") .. 'gv-gv', opts },
  { '<A-k>', cmd("move '<-2") .. 'gv-gv', opts },
})
