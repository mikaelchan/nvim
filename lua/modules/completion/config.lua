local config = {}

function config.nvim_lsp()
  require('modules.completion.nvim_lsp')
end

function config.lspsaga()
  require('lspsaga').setup({
    ui = {
      border = 'rounded',
      code_action = ' ',
      diagnostic = ' ',
      kind = {
        -- Boolean = ' ',
        -- Class = ' ',
        -- Constant = ' ',
        -- Constructor = ' ',
        -- Enum = '練',
        -- EnumMember = ' ',
        -- Event = ' ',
        -- Field = 'ﰠ ',
        -- File = ' ',
        -- Folder = ' ',
        -- Function = ' ',
        -- Interface = ' ',
        -- Key = ' ',
        -- Method = ' ',
        -- Operator = ' ',
        -- Snippet = ' ',
        -- Struct = 'פּ ',
        -- Text = ' ',
        -- Unit = '塞',
        -- Value = ' ',
      },
    },
    lightbulb = {
      virtual_text = false,
    },
  })
end

function config.nvim_cmp()
  require('modules.completion.cmp')
end

function config.lua_snip()
  local ls = require('luasnip')
  local types = require('luasnip.util.types')
  local helper = require('core.helper')
  local paths = {
    helper.path_join(vim.fn.stdpath('data'), 'site', 'pack', 'lazy', 'opt', 'friendly-snippets'),
    helper.path_join(vim.fn.stdpath('config'), 'snippets'),
  }

  ls.config.set_config({
    history = true,
    enable_autosnippets = true,
    updateevents = 'TextChanged,TextChangedI',
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '<- choiceNode', 'Comment' } },
        },
      },
    },
  })
  require('luasnip.loaders.from_lua').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = paths,
  })
  require('luasnip.loaders.from_snipmate').lazy_load()
end

function config.null_ls()
  require('modules.completion.null_ls')
end

function config.ts()
  require('typescript').setup(require('modules.completion.lsp.ts'))
end

function config.refactoring()
  require('refactoring').setup({})
end

function config.copilot()
  require('copilot').setup({
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = false,
    },
    filetypes = {
      yaml = true,
      markdown = true,
    },
  })
end

function config.copilot_cmp()
  require('copilot_cmp').setup({})
end

function config.package_info()
  require('package-info').setup()
end

return config
