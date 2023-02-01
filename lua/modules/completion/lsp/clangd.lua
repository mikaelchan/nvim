local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local mappings = {}
local opts = {
  mode = 'n',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = true,
}

mappings['lh'] = { '<Cmd>ClangdSwitchSourceHeader<CR>', 'Switch Header/Source' }
mappings['lg'] = { '<cmd>CMakeGenerate<CR>', 'Generate CMake' }
mappings['lr'] = { '<cmd>CMakeRun<CR>', 'Run CMake' }
mappings['lb'] = { '<cmd>CMakeBuild<CR>', 'Build CMake' }
mappings['ld'] = { '<cmd>CMakeDebug<CR>', 'Debug CMake' }
mappings['ls'] = { '<cmd>CMakeSelectBuildType<CR>', 'Select Build Type' }
mappings['lt'] = { '<cmd>CMakeSelectBuildTarget<CR>', 'Select Build Target' }
mappings['ll'] = { '<cmd>CMakeSelectLaunchTarget<CR>', 'Select Launch Target' }
mappings['lo'] = { '<cmd>CMakeOpen<CR>', 'Open CMake Console' }
mappings['lc'] = { '<cmd>CMakeClose<CR>', 'Close CMake Console' }
mappings['lI'] = { 'cmd>CMakeInstall<cr>', 'Install CMake Targets' }
mappings['lx'] = { '<cmd>CMakeClean<CR>', 'Clean CMake Targets' }
mappings['lC'] = { '<cmd>CMakeStop<CR>', 'Stop CMake' }

return {
  server = {
    cmd = {
      'clangd',
      '--fallback-style=google',
      '--background-index',
      '-j=12',
      '--all-scopes-completion',
      '--pch-storage=disk',
      '--clang-tidy',
      '--log=error',
      '--completion-style=detailed',
      '--header-insertion=iwyu',
      '--header-insertion-decorators',
      '--enable-config',
      '--offset-encoding=utf-16',
      '--ranking-model=heuristics',
      '--folding-ranges',
    },
    on_attach = function(client, bufnr)
      require('modules.completion.lsp').setup_codelens_refresh(client, bufnr)
      require('which-key').register(mappings, opts)
    end,
    capabilities = capabilities,
  },
  extensions = {
    autoSetHints = false,
  },
}
