local nls = require('null-ls')
local sources = {
  nls.builtins.formatting.prettier.with({
    filetypes = { 'solidity' },
    timeout = 10000,
  }),
  nls.builtins.formatting.prettierd.with({
    condition = function(utils)
      return not utils.root_has_file({ '.eslintrc', '.eslintrc.js' })
    end,
    prefer_local = 'node_modules/.bin',
  }),
  nls.builtins.formatting.eslint_d.with({
    condition = function(utils)
      return utils.root_has_file({ '.eslintrc', '.eslintrc.js' })
    end,
    prefer_local = 'node_modules/.bin',
  }),
  nls.builtins.formatting.stylua,
  nls.builtins.formatting.goimports,
  nls.builtins.formatting.gofumpt,
  nls.builtins.formatting.cmake_format,
  nls.builtins.formatting.scalafmt,
  nls.builtins.formatting.sqlformat,
  nls.builtins.formatting.terraform_fmt,
  nls.builtins.formatting.rustfmt,
  nls.builtins.formatting.clang_format,
  -- Support for nix files
  nls.builtins.formatting.alejandra,
  nls.builtins.formatting.shfmt.with({ extra_args = { '-i', '2', '-ci' }, filetypes = { 'sh', 'zsh', 'bash' } }),
  nls.builtins.formatting.black.with({ extra_args = { '--fast' }, filetypes = { 'python' } }),
  nls.builtins.formatting.isort.with({ extra_args = { '--profile', 'black' }, filetypes = { 'python' } }),
  nls.builtins.diagnostics.ansiblelint.with({
    condition = function(utils)
      return utils.root_has_file('roles') and utils.root_has_file('inventories')
    end,
  }),
  nls.builtins.diagnostics.solhint.with({
    condition = function(utils)
      return utils.root_has_file('.solhint.json')
    end,
  }),
  nls.builtins.diagnostics.hadolint,
  nls.builtins.diagnostics.eslint_d.with({
    condition = function(utils)
      return utils.root_has_file({ '.eslintrc', '.eslintrc.js' })
    end,
    prefer_local = 'node_modules/.bin',
  }),
  nls.builtins.diagnostics.shellcheck,
  nls.builtins.diagnostics.luacheck,
  nls.builtins.diagnostics.vint,
  nls.builtins.diagnostics.chktex,
  -- Support for nix files
  nls.builtins.diagnostics.deadnix,
  nls.builtins.diagnostics.statix,
  nls.builtins.diagnostics.cpplint,
  nls.builtins.diagnostics.markdownlint_cli2.with({
    filetypes = { 'markdown' },
    extra_args = { '-r', '~MD013' },
  }),
  nls.builtins.diagnostics.revive.with({
    condition = function(utils)
      return utils.root_has_file('revive.toml')
    end,
  }),
  nls.builtins.code_actions.shellcheck,
  nls.builtins.code_actions.gomodifytags,
  nls.builtins.code_actions.eslint_d.with({
    condition = function(utils)
      return utils.root_has_file({ '.eslintrc', '.eslintrc.js' })
    end,
    prefer_local = 'node_modules/.bin',
  }),
  nls.builtins.formatting.google_java_format,
  nls.builtins.code_actions.proselint,
  nls.builtins.diagnostics.proselint,
  require('modules.completion.null_ls.go').gostructhelper,
  require('modules.completion.null_ls.markdown').dictionary,
  require('typescript.extensions.null-ls.code-actions'),
}

table.insert(
  sources,
  nls.builtins.code_actions.refactoring.with({
    filetypes = {
      'go',
      'lua',
      'sh',
      'rust',
      'c',
      'cpp',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'json',
      'python',
      'solidity',
    },
  })
)

nls.setup({
  debounce = 150,
  sources = sources,
  on_attach = function(client, bufnr)
    require('modules.completion.lsp').setup_codelens_refresh(client, bufnr)
  end,
})
