local mappings = {}
local opts = {
  mode = 'n',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}
mappings['lA'] = { '<Cmd>RustHoverActions<CR>', 'Hover actions' }
mappings['lm'] = { '<Cmd>RustExpandMacro<CR>', 'Expand macro' }
mappings['lH'] = { '<Cmd>RustToggleInlayHints<CR>', 'Toggle inlay hints' }
mappings['le'] = { '<Cmd>RustRunnables<CR>', 'Runnables' }
mappings['lD'] = { '<cmd>RustDebuggables<Cr>', 'Debuggables' }
mappings['lP'] = { '<cmd>RustParentModule<Cr>', 'Parent module' }
mappings['lv'] = { '<cmd>RustViewCrateGraph<Cr>', 'View crate graph' }
mappings['lR'] = {
  "<cmd>lua require('rust-tools/workspace_refresh')._reload_workspace_from_cargo_toml()<Cr>",
  'Reload workspace',
}
mappings['lc'] = { '<Cmd>RustOpenCargo<CR>', 'Open cargo' }
mappings['lo'] = { '<Cmd>RustOpenExternalDocs<CR>', 'Open external docs' }
mappings['lb'] = {
  "<cmd>lua require('modules.tools.terminal').exec_toggle({cmd='cargo build;read',count=2,direction='float'})<cr>",
  'Build',
}
require('which-key').register(mappings, opts)
