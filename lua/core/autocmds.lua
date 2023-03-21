local api = vim.api
local my_group = api.nvim_create_augroup('KonomichaelGroup', {})

api.nvim_create_autocmd('BufWritePre', {
  group = my_group,
  pattern = { '/tmp/*', 'COMMIT_EDITMSG', 'MERGE_MSG', '*.tmp', '*.bak' },
  callback = function()
    vim.opt_local.undofile = false
  end,
})

api.nvim_create_autocmd('BufWritePre', {
  group = my_group,
  pattern = '*.c,*.cpp,*.lua,*.go,*.rs,*.py,*.ts,*.tsx',
  callback = function()
    require('modules.tools.formatter').format()
  end,
})

api.nvim_create_autocmd('BufRead', {
  group = my_group,
  pattern = '*.conf',
  callback = function()
    api.nvim_buf_set_option(0, 'filetype', 'conf')
  end,
})

api.nvim_create_autocmd('TextYankPost', {
  group = my_group,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({ higroup = 'Search', timeout = 100 })
  end,
})

api.nvim_create_autocmd('FileType', {
  group = my_group,
  pattern = '*.c,*.cpp,*.lua,*.go,*.rs,*.py,*.ts,*.tsx',
  callback = function()
    vim.cmd('syntax off')
  end,
})

api.nvim_create_autocmd('FileType', {
  group = my_group,
  pattern = 'dap-repl',
  command = 'set nobuflisted',
})

api.nvim_create_autocmd('FileType', {
  group = my_group,
  pattern = { 'lua' },
  callback = function()
    -- credit: https://github.com/sam4llis/nvim-lua-gf
    vim.opt_local.include = [[\v<((do|load)file|require|reload)[^''"]*[''"]\zs[^''"]+]]
    vim.opt_local.includeexpr = "substitute(v:fname,'\\.','/','g')"
    vim.opt_local.suffixesadd:prepend('.lua')
    vim.opt_local.suffixesadd:prepend('init.lua')

    for _, path in pairs(vim.api.nvim_list_runtime_paths()) do
      vim.opt_local.path:append(path .. '/lua')
    end
  end,
})

api.nvim_create_autocmd('FileType', {
  group = my_group,
  pattern = {
    'qf',
    'help',
    'man',
    'floaterm',
    'lspinfo',
    'lir',
    'lsp-installer',
    'null-ls-info',
    'tsplayground',
    'DressingSelect',
    'Jaq',
  },
  callback = function()
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = true })
    vim.opt_local.buflisted = false
  end,
})

api.nvim_create_autocmd('VimResized', {
  group = my_group,
  pattern = '*',
  command = 'tabdo wincmd =',
})

api.nvim_create_autocmd('FileType', {
  group = my_group,
  pattern = 'alpha',
  callback = function()
    vim.cmd([[
          nnoremap <silent> <buffer> q :qa<CR>
          nnoremap <silent> <buffer> <esc> :qa<CR>
          set nobuflisted
        ]])
  end,
})

api.nvim_create_autocmd('ColorScheme', {
  group = my_group,
  callback = function()
    local statusline_hl = vim.api.nvim_get_hl_by_name('StatusLine', true)
    local cursorline_hl = vim.api.nvim_get_hl_by_name('CursorLine', true)
    local normal_hl = vim.api.nvim_get_hl_by_name('Normal', true)
    api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
    api.nvim_set_hl(0, 'CmpItemKindCrate', { fg = '#F64D00' })
    api.nvim_set_hl(0, 'CmpItemKindEmoji', { fg = '#FDE030' })
    api.nvim_set_hl(0, 'SLCopilot', { fg = '#6CC644', bg = statusline_hl.background })
    api.nvim_set_hl(0, 'SLGitIcon', { fg = '#E8AB53', bg = cursorline_hl.background })
    api.nvim_set_hl(0, 'SLBranchName', { fg = normal_hl.foreground, bg = cursorline_hl.background })
    api.nvim_set_hl(0, 'SLSeparator', { fg = cursorline_hl.background, bg = statusline_hl.background })
  end,
})

api.nvim_create_autocmd('BufWinEnter', {
  group = my_group,
  pattern = '*.md',
  desc = 'beautify markdown',
  callback = function()
    vim.cmd([[set syntax=markdown]])
    require('modules.tools.markdown_syn').set_syntax()
  end,
})

api.nvim_create_autocmd('LspAttach', {
  group = my_group,
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end

    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    require('lsp-inlayhints').on_attach(client, bufnr)
  end,
})
api.nvim_create_autocmd('FileType', {
  group = my_group,
  pattern = { 'sql', 'mysql', 'plsql' },
  command = "lua require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }",
})

api.nvim_create_autocmd('FileType', {
  group = my_group,
  pattern = 'toml',
  command = "lua require('cmp').setup.buffer { sources = { { name = 'crates' } } }",
})
