local status_ok_which_key, which_key = pcall(require, 'which-key')
if not status_ok_which_key then
  return
end

local keymap = require('core.keymap')
local cmd, esc_cmd = keymap.cmd, keymap.esc_cmd

local vmappings = {
  ['/'] = { esc_cmd("lua require('Comment.api').toggle.linewise(vim.fn.visualmode())"), '󱆿 Comment' },
}

local mappings = {
  ['/'] = { cmd("lua require('Comment.api').toggle.linewise.current()"), '󱆿 Comment' },
  [';'] = { cmd('Dashboard'), ' Dashboard' },
  ['<leader>'] = { cmd("lua require('harpoon.ui').toggle_quick_menu()"), ' Harpoon' },
  ['1'] = { cmd("lua require('harpoon.ui').nav_file(1)"), '󰎤 goto1' },
  ['2'] = { cmd("lua require('harpoon.ui').nav_file(2)"), '󰎧 goto2' },
  ['3'] = { cmd("lua require('harpoon.ui').nav_file(3)"), '󰎪 goto3' },
  ['4'] = { cmd("lua require('harpoon.ui').nav_file(4)"), '󰎭 goto4' },
  a = { cmd("lua require('harpoon.mark').add_file()"), '󰃁 Add mark' },
  w = { cmd('w!'), ' Save' },
  q = { cmd('confirm q'), '󰗼 Quit' },
  c = { cmd("lua require('modules.tools.buffer').kill()"), ' Close buffer' },
  i = { cmd("lua require('lsp-inlayhints').toggle()"), '󰭴 Inlay hints' },
  e = { cmd('NvimTreeToggle'), ' Explorer' },
  o = { cmd('Lspsaga outline'), ' Symbol outline' },
  v = { cmd("lua require('lsp_lines').toggle()"), '󱖫 LSP lines' },
  y = { cmd("lua require('telescope').extensions.neoclip.default()"), ' Yank history' },
  h = { cmd('Cheat'), '󱚟 Cheat' },
  b = {
    name = ' Buffers',
    ['1'] = { cmd('BufferLineGoToBuffer 1'), 'Goto 1' },
    ['2'] = { cmd('BufferLineGoToBuffer 2'), 'Goto 2' },
    ['3'] = { cmd('BufferLineGoToBuffer 3'), 'Goto 3' },
    ['4'] = { cmd('BufferLineGoToBuffer 4'), 'Goto 4' },
    ['5'] = { cmd('BufferLineGoToBuffer 5'), 'Goto 5' },
    ['6'] = { cmd('BufferLineGoToBuffer 6'), 'Goto 6' },
    ['7'] = { cmd('BufferLineGoToBuffer 7'), 'Goto 7' },
    ['8'] = { cmd('BufferLineGoToBuffer 8'), 'Goto 8' },
    ['9'] = { cmd('BufferLineGoToBuffer 9'), 'Goto 9' },
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
    name = ' Search',
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
    p = { cmd('Telescope luasnip'), 'Snippets' },
    s = { cmd("lua require('telescope').extensions.live_grep_args.live_grep_args()"), 'String' },
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
  r = {
    name = ' Replace',
    f = { cmd("lua require('spectre').open_file_search()"), 'Current Buffer' },
    p = { cmd("lua require('spectre').open()"), 'Project' },
    w = { cmd("lua require('spectre').open_visual({select_word=true})"), 'Word' },
  },
  s = {
    name = ' Session',
    s = { cmd("lua require('persistence').load()"), 'Restore for current dir' },
    l = { cmd("lua require('persistence').load({last=true})"), 'Restore last session' },
    d = { cmd("lua require('presistence').stop()"), 'Stop persistence' },
  },
  t = {
    name = ' Tasks',
    l = { cmd('OverseerLoadBundle'), 'Load bundle' },
    s = { cmd('OverseerSaveBundle'), 'Save bundle' },
    n = { cmd('OverseerBuild'), 'New task' },
    q = { cmd('OverseerQuickAction'), 'Quick action' },
    f = { cmd('OverseerTaskAction'), 'Task Action' },
    t = { cmd('OverseerToggle'), 'Toggle Output' },
    r = { cmd('OverseerRun'), 'Run' },
    p = { cmd('OverseerRunCmd'), 'Run with Cmd' },
  },
}

which_key.add({
  mode = { 'n' },
  {
    '<leader>/',
    "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
    desc = '󱆿 Comment',
    nowait = false,
    remap = false,
  },
  { '<leader>1', "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", desc = '󰎤 goto1', nowait = false, remap = false },
  { '<leader>2', "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", desc = '󰎧 goto2', nowait = false, remap = false },
  { '<leader>3', "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", desc = '󰎪 goto3', nowait = false, remap = false },
  { '<leader>4', "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", desc = '󰎭 goto4', nowait = false, remap = false },
  { '<leader>;', '<cmd>Dashboard<CR>', desc = ' Dashboard', nowait = false, remap = false },
  {
    '<leader><leader>',
    "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
    desc = ' Harpoon',
    nowait = false,
    remap = false,
  },
  {
    '<leader>a',
    "<cmd>lua require('harpoon.mark').add_file()<CR>",
    desc = '󰃁 Add mark',
    nowait = false,
    remap = false,
  },
  { '<leader>b', group = ' Buffers', nowait = false, remap = false },
  { '<leader>b1', '<cmd>BufferLineGoToBuffer 1<CR>', desc = 'Goto 1', nowait = false, remap = false },
  { '<leader>b2', '<cmd>BufferLineGoToBuffer 2<CR>', desc = 'Goto 2', nowait = false, remap = false },
  { '<leader>b3', '<cmd>BufferLineGoToBuffer 3<CR>', desc = 'Goto 3', nowait = false, remap = false },
  { '<leader>b4', '<cmd>BufferLineGoToBuffer 4<CR>', desc = 'Goto 4', nowait = false, remap = false },
  { '<leader>b5', '<cmd>BufferLineGoToBuffer 5<CR>', desc = 'Goto 5', nowait = false, remap = false },
  { '<leader>b6', '<cmd>BufferLineGoToBuffer 6<CR>', desc = 'Goto 6', nowait = false, remap = false },
  { '<leader>b7', '<cmd>BufferLineGoToBuffer 7<CR>', desc = 'Goto 7', nowait = false, remap = false },
  { '<leader>b8', '<cmd>BufferLineGoToBuffer 8<CR>', desc = 'Goto 8', nowait = false, remap = false },
  { '<leader>b9', '<cmd>BufferLineGoToBuffer 9<CR>', desc = 'Goto 9', nowait = false, remap = false },
  { '<leader>bD', '<cmd>BufferLineSortByDirectory<CR>', desc = 'Sort by directory', nowait = false, remap = false },
  { '<leader>bL', '<cmd>BufferLineSortByExtension<CR>', desc = 'Sort by language', nowait = false, remap = false },
  { '<leader>bb', '<cmd>BufferLineCycleNext<CR>', desc = 'Next buffer', nowait = false, remap = false },
  { '<leader>bc', '<cmd>BufferLinePickClose<CR>', desc = 'Close buffer', nowait = false, remap = false },
  { '<leader>bf', '<cmd>Telescope buffers<CR>', desc = 'Find buffer', nowait = false, remap = false },
  {
    '<leader>bg',
    '<cmd>BufferLineGroupToggle pinned<CR>',
    desc = 'Toggle pinned group',
    nowait = false,
    remap = false,
  },
  { '<leader>bh', '<cmd>BufferLineCloseLeft<CR>', desc = 'Close all to the left', nowait = false, remap = false },
  { '<leader>bj', '<cmd>BufferLinePick<CR>', desc = 'Jump buffer', nowait = false, remap = false },
  { '<leader>bl', '<cmd>BufferLineCloseRight<CR>', desc = 'Close all to the right', nowait = false, remap = false },
  { '<leader>bn', '<cmd>BufferLineCyclePrev<CR>', desc = 'Previous buffer', nowait = false, remap = false },
  { '<leader>bp', '<cmd>BufferLineTogglePin<CR>', desc = 'Toggle pin', nowait = false, remap = false },
  {
    '<leader>c',
    "<cmd>lua require('modules.tools.buffer').kill()<CR>",
    desc = ' Close buffer',
    nowait = false,
    remap = false,
  },
  { '<leader>d', group = ' Debug', nowait = false, remap = false },
  {
    '<leader>dC',
    "<cmd>lua require('dap').run_to_cursor()<CR>",
    desc = 'Run to cursor',
    nowait = false,
    remap = false,
  },
  { '<leader>dU', "<cmd>lua require('dapui').toggle()<CR>", desc = 'UI toggle', nowait = false, remap = false },
  { '<leader>db', "<cmd>lua require('dap').step_back()<CR>", desc = 'Step back', nowait = false, remap = false },
  { '<leader>dc', "<cmd>lua require('dap').continue()<CR>", desc = 'Continue', nowait = false, remap = false },
  { '<leader>dd', "<cmd>lua require('dap').disconnect()<CR>", desc = 'Disconnect', nowait = false, remap = false },
  { '<leader>de', "<cmd>lua require('dapui').eval()<CR>", desc = 'Eval', nowait = false, remap = false },
  { '<leader>dg', "<cmd>lua require('dap').session()<CR>", desc = 'Get session', nowait = false, remap = false },
  { '<leader>di', "<cmd>lua require('dap').step_into()<CR>", desc = 'Step into', nowait = false, remap = false },
  { '<leader>do', "<cmd>lua require('dap').step_over()<CR>", desc = 'Step over', nowait = false, remap = false },
  { '<leader>dp', "<cmd>lua require('dap').pause()<CR>", desc = 'Pause', nowait = false, remap = false },
  { '<leader>dq', "<cmd>lua require('dap').close()<CR>", desc = 'Close', nowait = false, remap = false },
  { '<leader>dr', "<cmd>lua require('dap').repl.open()<CR>", desc = 'Open repl', nowait = false, remap = false },
  { '<leader>ds', "<cmd>lua require('dap').continue()<CR>", desc = 'Start', nowait = false, remap = false },
  {
    '<leader>dt',
    "<cmd>lua require('dap').toggle_breakpoint()<CR>",
    desc = 'Toggle breakpoint',
    nowait = false,
    remap = false,
  },
  { '<leader>du', "<cmd>lua require('dap').step_out()<CR>", desc = 'Step out', nowait = false, remap = false },
  { '<leader>e', '<cmd>NvimTreeToggle<CR>', desc = ' Explorer', nowait = false, remap = false },
  { '<leader>f', group = ' Search', nowait = false, remap = false },
  { '<leader>fc', '<cmd>Telescope commands<CR>', desc = 'Commands', nowait = false, remap = false },
  { '<leader>fd', '<cmd>Telescope dotfiles<CR>', desc = 'Dotfiles', nowait = false, remap = false },
  { '<leader>fe', '<cmd>Telescope file_browser<CR>', desc = 'Browser', nowait = false, remap = false },
  { '<leader>ff', '<cmd>Telescope find_files<CR>', desc = 'File', nowait = false, remap = false },
  { '<leader>fh', '<cmd>Telescope help_tags<CR>', desc = 'Help', nowait = false, remap = false },
  { '<leader>fk', '<cmd>Telescope keymaps<CR>', desc = 'Keymaps', nowait = false, remap = false },
  { '<leader>fm', '<cmd>Telescope man_pages<CR>', desc = 'Man Pages', nowait = false, remap = false },
  { '<leader>fo', '<cmd>Telescope oldfiles<CR>', desc = 'Recent File', nowait = false, remap = false },
  { '<leader>fp', '<cmd>Telescope luasnip<CR>', desc = 'Snippets', nowait = false, remap = false },
  { '<leader>fr', '<cmd>Telescope registers<CR>', desc = 'Registers', nowait = false, remap = false },
  {
    '<leader>fs',
    "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
    desc = 'String',
    nowait = false,
    remap = false,
  },
  { '<leader>ft', '<cmd>Telescope live_grep<CR>', desc = 'Text', nowait = false, remap = false },
  { '<leader>g', group = ' Git', nowait = false, remap = false },
  {
    '<leader>gR',
    "<cmd>lua require 'gitsigns'.reset_buffer()<CR>",
    desc = 'Reset Buffer',
    nowait = false,
    remap = false,
  },
  { '<leader>gb', '<cmd>Telescope git_branches<CR>', desc = 'Checkout Branch', nowait = false, remap = false },
  { '<leader>gc', '<cmd>Telescope git_commits<CR>', desc = 'Checkout Commit', nowait = false, remap = false },
  { '<leader>gd', '<cmd>DiffviewOpen<CR>', desc = 'Diffview', nowait = false, remap = false },
  {
    '<leader>gg',
    "<cmd>lua require 'modules.tools.lazygit'.toggle()<CR>",
    desc = 'LazyGit',
    nowait = false,
    remap = false,
  },
  {
    '<leader>gh',
    '<cmd>DiffviewFileHistory<CR>',
    desc = 'File History',
    nowait = false,
    remap = false,
  },
  {
    '<leader>gj',
    "<cmd>lua require 'gitsigns'.next_hunk({navigation_message = false})<CR>",
    desc = 'Next Hunk',
    nowait = false,
    remap = false,
  },
  {
    '<leader>gk',
    "<cmd>lua require 'gitsigns'.prev_hunk({navigation_message = false})<CR>",
    desc = 'Prev Hunk',
    nowait = false,
    remap = false,
  },
  {
    '<leader>gl',
    "<cmd>lua require 'gitsigns'.blame_line()<CR>",
    desc = 'Blame',
    nowait = false,
    remap = false,
  },
  {
    '<leader>go',
    '<cmd>Telescope git_status<CR>',
    desc = 'Open Changed File',
    nowait = false,
    remap = false,
  },
  {
    '<leader>gp',
    "<cmd>lua require 'gitsigns'.preview_hunk()<CR>",
    desc = 'Preview Hunk',
    nowait = false,
    remap = false,
  },
  { '<leader>gr', "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", desc = 'Reset Hunk', nowait = false, remap = false },
  { '<leader>gs', "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", desc = 'Stage Hunk', nowait = false, remap = false },
  {
    '<leader>gu',
    "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>",
    desc = 'Undo Stage Hunk',
    nowait = false,
    remap = false,
  },
  { '<leader>h', '<cmd>Cheat<CR>', desc = '󱚟 Cheat', nowait = false, remap = false },
  {
    '<leader>i',
    "<cmd>lua require('lsp-inlayhints').toggle()<CR>",
    desc = '󰭴 Inlay hints',
    nowait = false,
    remap = false,
  },
  { '<leader>l', group = ' LSP', nowait = false, remap = false },
  { '<leader>lK', '<cmd>Lspsaga outgoing_calls<CR>', desc = 'Outgoing calls', nowait = false, remap = false },
  {
    '<leader>lf',
    "<cmd>lua require('modules.tools.formatter').format()<CR>",
    desc = 'Format',
    nowait = false,
    remap = false,
  },
  { '<leader>li', '<cmd>LspInfo<CR>', desc = 'Info', nowait = false, remap = false },
  { '<leader>lk', '<cmd>Lspsaga incoming_calls<CR>', desc = 'Incoming calls', nowait = false, remap = false },
  { '<leader>o', '<cmd>Lspsaga outline<CR>', desc = ' Symbol outline', nowait = false, remap = false },
  { '<leader>p', group = ' Plugins', nowait = false, remap = false },
  { '<leader>pc', '<cmd>Lazy check<CR>', desc = 'Check', nowait = false, remap = false },
  { '<leader>ph', '<cmd>Lazy home<CR>', desc = 'Home', nowait = false, remap = false },
  { '<leader>pi', '<cmd>Lazy install<CR>', desc = 'Install', nowait = false, remap = false },
  { '<leader>pl', '<cmd>Lazy log<CR>', desc = 'Log', nowait = false, remap = false },
  { '<leader>pp', '<cmd>Lazy profile<CR>', desc = 'Profile', nowait = false, remap = false },
  { '<leader>ps', '<cmd>Lazy sync<CR>', desc = 'Sync', nowait = false, remap = false },
  { '<leader>pu', '<cmd>Lazy update<CR>', desc = 'Update', nowait = false, remap = false },
  { '<leader>px', '<cmd>Lazy clean<CR>', desc = 'Clean', nowait = false, remap = false },
  { '<leader>q', '<cmd>confirm q<CR>', desc = '󰗼 Quit', nowait = false, remap = false },
  { '<leader>r', group = ' Replace', nowait = false, remap = false },
  {
    '<leader>rf',
    "<cmd>lua require('spectre').open_file_search()<CR>",
    desc = 'Current Buffer',
    nowait = false,
    remap = false,
  },
  { '<leader>rp', "<cmd>lua require('spectre').open()<CR>", desc = 'Project', nowait = false, remap = false },
  {
    '<leader>rw',
    "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
    desc = 'Word',
    nowait = false,
    remap = false,
  },
  { '<leader>s', group = ' Session', nowait = false, remap = false },
  {
    '<leader>sd',
    "<cmd>lua require('presistence').stop()<CR>",
    desc = 'Stop persistence',
    nowait = false,
    remap = false,
  },
  {
    '<leader>sl',
    "<cmd>lua require('persistence').load({last=true})<CR>",
    desc = 'Restore last session',
    nowait = false,
    remap = false,
  },
  {
    '<leader>ss',
    "<cmd>lua require('persistence').load()<CR>",
    desc = 'Restore for current dir',
    nowait = false,
    remap = false,
  },
  { '<leader>t', group = ' Tasks', nowait = false, remap = false },
  { '<leader>tf', '<cmd>OverseerTaskAction<CR>', desc = 'Task Action', nowait = false, remap = false },
  { '<leader>tl', '<cmd>OverseerLoadBundle<CR>', desc = 'Load bundle', nowait = false, remap = false },
  { '<leader>tn', '<cmd>OverseerBuild<CR>', desc = 'New task', nowait = false, remap = false },
  { '<leader>tp', '<cmd>OverseerRunCmd<CR>', desc = 'Run with Cmd', nowait = false, remap = false },
  { '<leader>tq', '<cmd>OverseerQuickAction<CR>', desc = 'Quick action', nowait = false, remap = false },
  { '<leader>tr', '<cmd>OverseerRun<CR>', desc = 'Run', nowait = false, remap = false },
  { '<leader>ts', '<cmd>OverseerSaveBundle<CR>', desc = 'Save bundle', nowait = false, remap = false },
  { '<leader>tt', '<cmd>OverseerToggle<CR>', desc = 'Toggle Output', nowait = false, remap = false },
  { '<leader>v', "<cmd>lua require('lsp_lines').toggle()<CR>", desc = '󱖫 LSP lines', nowait = false, remap = false },
  { '<leader>w', '<cmd>w!<CR>', desc = ' Save', nowait = false, remap = false },
  {
    '<leader>y',
    "<cmd>lua require('telescope').extensions.neoclip.default()<CR>",
    desc = ' Yank history',
    nowait = false,
    remap = false,
  },
})
which_key.add({
  mode = { 'v' },
  {
    {
      '<leader>/',
      "<Esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
      desc = '󱆿 Comment',
      mode = 'v',
      nowait = false,
      remap = false,
    },
  },
})
