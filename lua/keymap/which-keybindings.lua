local status_ok_which_key, which_key = pcall(require, 'which-key')
if not status_ok_which_key then
  return
end

local keymap = require('core.keymap')
local cmd, esc_cmd = keymap.cmd, keymap.esc_cmd

local opts = {
  mode = 'n',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}
local vopts = {
  mode = 'v',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local vmappings = {
  ['/'] = { esc_cmd("lua require('Comment.api').toggle.linewise(vim.fn.visualmode())"), ' Comment' },
  f = {
    name = ' Search',
    s = { cmd("lua require('telescope').extensions.live_grep_args.live_grep_args()"), 'String' },
  },
}

local mappings = {
  ['/'] = { cmd("lua require('Comment.api').toggle.linewise.current()"), ' Comment' },
  [';'] = { cmd('Dashboard'), ' Dashboard' },
  ['<leader>'] = { cmd("lua require('harpoon.ui').toggle_quick_menu()"), ' Harpoon' },
  ['1'] = { cmd("lua require('harpoon.ui').nav_file(1)"), ' goto1' },
  ['2'] = { cmd("lua require('harpoon.ui').nav_file(2)"), ' goto2' },
  ['3'] = { cmd("lua require('harpoon.ui').nav_file(3)"), ' goto3' },
  ['4'] = { cmd("lua require('harpoon.ui').nav_file(4)"), ' goto4' },
  a = { cmd("lua require('harpoon.mark').add_file()"), ' Add Mark' },
  w = { cmd('w!'), ' Save' },
  q = { cmd('confirm q'), ' Quit' },
  c = { cmd("lua require('modules.tools.buffer').kill()"), ' Close Buffer' },
  h = { cmd('nohlsearch'), ' No Highlight' },
  i = { cmd("lua require('lsp-inlayhints').toggle()"), 'ﳟ Inlay Hints' },
  e = { cmd('NvimTreeToggle'), ' Explorer' },
  o = { cmd('Lspsaga outline'), ' Symbol Outline' },
  v = { cmd("lua require('lsp_lines').toggle()"), '識LSP Lines' },
  b = {
    name = '﩯Buffers',
    ['1'] = { cmd('BufferLineGotToBuffer 1'), 'Goto 1' },
    ['2'] = { cmd('BufferLineGotToBuffer 2'), 'Goto 2' },
    ['3'] = { cmd('BufferLineGotToBuffer 3'), 'Goto 3' },
    ['4'] = { cmd('BufferLineGotToBuffer 4'), 'Goto 4' },
    ['5'] = { cmd('BufferLineGotToBuffer 5'), 'Goto 5' },
    ['6'] = { cmd('BufferLineGotToBuffer 6'), 'Goto 6' },
    ['7'] = { cmd('BufferLineGotToBuffer 7'), 'Goto 7' },
    ['8'] = { cmd('BufferLineGotToBuffer 8'), 'Goto 8' },
    ['9'] = { cmd('BufferLineGotToBuffer 9'), 'Goto 9' },
    c = { cmd('BufferLinePickClose'), 'Close buffer' },
    p = { cmd('BufferLineTogglePin'), 'Toggle pin' },
    j = { cmd('BufferLinePick'), 'Jump buffer' },
    f = { cmd('Telescope buffers'), 'Find buffer' },
    h = { cmd('BufferLineCloseLeft'), 'Close all to the left' },
    l = { cmd('BufferLineCloseRight'), 'Close all to the right' },
    D = { cmd('BufferLineSortByDirectory'), 'Sort by directory' },
    L = { cmd('BufferLineSortByExtension'), 'Sort by language' },
    b = { cmd('BufferLineCycleNext'), 'Next buffer' },
    n = { cmd('BufferLineCyclePrev'), 'Previous buffer' },
    g = { cmd('BufferLineGroupToggle pinned'), 'Toggle pinned group' },
  },
  d = {
    name = ' Debug',
    t = { cmd("lua require('dap').toggle_breakpoint()"), 'Toggle breakpoint' },
    b = { cmd("lua require('dap').step_back()"), 'Step back' },
    s = { cmd("lua require('dap').continue()"), 'Start' },
    c = { cmd("lua require('dap').continue()"), 'Continue' },
    C = { cmd("lua require('dap').run_to_cursor()"), 'Run to cursor' },
    d = { cmd("lua require('dap').disconnect()"), 'Disconnect' },
    g = { cmd("lua require('dap').session()"), 'Get session' },
    i = { cmd("lua require('dap').step_into()"), 'Step into' },
    o = { cmd("lua require('dap').step_over()"), 'Step over' },
    u = { cmd("lua require('dap').step_out()"), 'Step out' },
    e = { cmd("lua require('dapui').eval()"), 'Eval' },
    p = { cmd("lua require('dap').pause()"), 'Pause' },
    r = { cmd("lua require('dap').repl.open()"), 'Open repl' },
    q = { cmd("lua require('dap').close()"), 'Close' },
    U = { cmd("lua require('dapui').toggle()"), 'UI toggle' },
  },
  f = {
    name = ' Search',
    f = { cmd('Telescope find_files'), 'File' },
    h = { cmd('Telescope help_tags'), 'Help' },
    m = { cmd('Telescope man_pages'), 'Man Pages' },
    o = { cmd('Telescope oldfiles'), 'Recent File' },
    r = { cmd('Telescope registers'), 'Registers' },
    t = { cmd('Telescope live_grep'), 'Text' },
    k = { cmd('Telescope keymaps'), 'Keymaps' },
    c = { cmd('Telescope commands'), 'Commands' },
    e = { cmd('Telescope file_browser'), 'Browser' },
    d = { cmd('Telescope dotfiles'), 'Dotfiles' },
    s = { cmd('Telescope luasnip'), 'Snippets' },
  },
  g = {
    name = ' Git',
    g = { cmd("lua require 'modules.tools.lazygit'.toggle()"), 'LazyGit' },
    j = { cmd("lua require 'gitsigns'.next_hunk({navigation_message = false})"), 'Next Hunk' },
    k = { cmd("lua require 'gitsigns'.prev_hunk({navigation_message = false})"), 'Prev Hunk' },
    l = { cmd("lua require 'gitsigns'.blame_line()"), 'Blame' },
    p = { cmd("lua require 'gitsigns'.preview_hunk()"), 'Preview Hunk' },
    r = { cmd("lua require 'gitsigns'.reset_hunk()"), 'Reset Hunk' },
    R = { cmd("lua require 'gitsigns'.reset_buffer()"), 'Reset Buffer' },
    s = { cmd("lua require 'gitsigns'.stage_hunk()"), 'Stage Hunk' },
    u = {
      cmd("lua require 'gitsigns'.undo_stage_hunk()"),
      'Undo Stage Hunk',
    },
    o = { cmd('Telescope git_status'), 'Open Changed File' },
    b = { cmd('Telescope git_branches'), 'Checkout Branch' },
    c = { cmd('Telescope git_commits'), 'Checkout Commit' },
    d = { cmd('DiffviewOpen'), 'Diffview' },
    h = { cmd('DiffviewFileHistory'), 'File History' },
  },
  l = {
    name = ' LSP',
    i = { cmd('LspInfo'), 'Info' },
    q = { cmd('Telescope quickfix'), 'Quickfix' },
    f = { cmd("lua require('modules.tools.formatter').format()"), 'Format' },
    k = { cmd('Lspsaga incoming_calls'), 'Incoming calls' },
    K = { cmd('Lspsaga outgoing_calls'), 'Outgoing calls' },
  },
  p = {
    name = ' Plugins',
    h = { cmd('Lazy home'), 'Home' },
    i = { cmd('Lazy install'), 'Install' },
    s = { cmd('Lazy sync'), 'Sync' },
    u = { cmd('Lazy update'), 'Update' },
    x = { cmd('Lazy clean'), 'Clean' },
    l = { cmd('Lazy log'), 'Log' },
    p = { cmd('Lazy profile'), 'Profile' },
    c = { cmd('Lazy check'), 'Check' },
  },
}

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
