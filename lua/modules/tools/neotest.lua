local M = {}
local namespace = vim.api.nvim_create_namespace('neotest')
local neotest = require('neotest')
M.setup = function()
  vim.diagnostic.config({
    virtual_text = {
      format = function(diagnostic)
        return diagnostic.message:gsub('\n', ' '):gsub('\t', ' '):gsub('%s+', ' '):gsub('^%s+', '')
      end,
    },
  }, namespace)

  neotest.setup({
    running = {
      concurrent = false,
    },
    status = {
      virtual_text = true,
      signs = false,
    },
    strategies = {
      integrated = {
        width = 180,
      },
    },
    discovery = {
      enabled = true,
    },
    diagnostic = {
      enabled = true,
    },
    icons = {
      running = ' ',
    },
    floating = {
      border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
    },
    adapters = {
      require('neotest-rust'),
      require('neotest-go')({
        experimental = {
          test_table = true,
        },
      }),
      require('neotest-python')({
        dap = {
          justMyCode = false,
          console = 'integratedTerminal',
        },
      }),
      require('neotest-plenary'),
    },
    consumers = {
      overseer = require('neotest.consumers.overseer'),
    },
    overseer = {
      enabled = true,
      force_default = true,
    },
  })
end

M.get_env = function()
  local env = {}
  for _, file in ipairs({ '.env' }) do
    if vim.fn.empty(vim.fn.glob(file)) ~= 0 then
      break
    end

    for _, line in ipairs(vim.fn.readfile(file)) do
      for name, value in string.gmatch(line, '(.+)=[\'"]?(.*)[\'"]?') do
        local str_end = string.sub(value, -1, -1)
        if str_end == "'" or str_end == '"' then
          value = string.sub(value, 1, -2)
        end

        env[name] = value
      end
    end
  end
  return env
end

M.run_all = function()
  neotest.run.run(vim.fn.expand('%'))
end

M.cancel = function()
  neotest.run.stop({
    interactive = true,
  })
end

M.run_file_sync = function()
  neotest.run.run({
    vim.fn.expand('%'),
    concurrent = false,
  })
end
return M
