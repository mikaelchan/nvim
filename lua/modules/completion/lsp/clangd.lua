local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.offsetEncoding = { 'utf-16' }

return {
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
    -- '--offset-encoding=utf-16',
    '--ranking-model=heuristics',
    '--folding-ranges',
  },
  on_attach = function(client, bufnr)
    require('modules.completion.lsp').setup_codelens_refresh(client, bufnr)
    require('which-key').add({
      mode = { 'n' },
      {
        '<leader>lC',
        '<cmd>CMakeStop<CR>',
        desc = 'Stop CMake',
        nowait = true,
        remap = false,
      },
      {
        '<leader>lI',
        'cmd>CMakeInstall<cr>',
        desc = 'Install CMake Targets',
        nowait = true,
        remap = false,
      },
      {
        '<leader>lb',
        '<cmd>CMakeBuild<CR>',
        desc = 'Build CMake',
        nowait = true,
        remap = false,
      },
      {
        '<leader>lc',
        '<cmd>CMakeClose<CR>',
        desc = 'Close CMake Console',
        nowait = true,
        remap = false,
      },
      {
        '<leader>ld',
        '<cmd>CMakeDebug<CR>',
        desc = 'Debug CMake',
        nowait = true,
        remap = false,
      },
      {
        '<leader>lg',
        '<cmd>CMakeGenerate<CR>',
        desc = 'Generate CMake',
        nowait = true,
        remap = false,
      },
      {
        '<leader>lh',
        '<Cmd>ClangdSwitchSourceHeader<CR>',
        desc = 'Switch Header/Source',
        nowait = true,
        remap = false,
      },
      {
        '<leader>ll',
        '<cmd>CMakeSelectLaunchTarget<CR>',
        desc = 'Select Launch Target',
        nowait = true,
        remap = false,
      },
      {
        '<leader>lo',
        '<cmd>CMakeOpen<CR>',
        desc = 'Open CMake Console',
        nowait = true,
        remap = false,
      },
      {
        '<leader>lr',
        '<cmd>CMakeRun<CR>',
        desc = 'Run CMake',
        nowait = true,
        remap = false,
      },
      {
        '<leader>ls',
        '<cmd>CMakeSelectBuildType<CR>',
        desc = 'Select Build Type',
        nowait = true,
        remap = false,
      },
      {
        '<leader>lt',
        '<cmd>CMakeSelectBuildTarget<CR>',
        desc = 'Select Build Target',
        nowait = true,
        remap = false,
      },
      {
        '<leader>lx',
        '<cmd>CMakeClean<CR>',
        desc = 'Clean CMake Targets',
        nowait = true,
        remap = false,
      },
    })
  end,
  capabilities = capabilities,
}
