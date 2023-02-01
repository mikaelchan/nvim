local STATUS = require('overseer.constants').STATUS
local overseer = require('overseer')
overseer.setup {
    log = {
      {
        type = "echo",
        level = vim.log.levels.WARN,
      },
      {
        type = "file",
        filename = "overseer.log",
        level = vim.log.levels.DEBUG,
      },
    },
    task_win = {
      win_opts = {
        winblend = 0,
      },
    },
    confirm = {
      win_opts = {
        winblend = 0,
      },
    },
    form = {
      win_opts = {
        winblend = 0,
      },
    },
    component_aliases = {
      default = {
        "on_output_summarize",
        "on_exit_set_status",
        { "on_complete_notify", system = "unfocused" },
        "on_complete_dispose",
      },
      default_neotest = {
        { "on_complete_notify", system = "unfocused", on_change = true },
        "default",
      },
    },
    actions = {
      ["keep runnning"] = {
        desc = "restart the task even if it succeeds",
        run = function(task)
          task:add_components { { "on_complete_restart", statuses = { STATUS.FAILURE, STATUS.SUCCESS } } }
          if task.status == STATUS.FAILURE or task.status == STATUS.SUCCESS then
            task:restart()
          end
        end,
      },
      ["don't dispose"] = {
        desc = "keep the task until manually disposed",
        run = function(task)
          task:remove_components { "on_complete_dispose" }
        end,
      },
    },
  }
