local M = {}

M.exec_toggle = function(opts)
  local Terminal = require('toggleterm.terminal').Terminal
  local term = Terminal:new({ cmd = opts.cmd, count = opts.count, direction = opts.direction })
  term:toggle(opts.size, opts.direction)
end
return M
