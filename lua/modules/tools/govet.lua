local M = {}
M.toggle = function()
  local Terminal = require('toggleterm.terminal').Terminal
  local govet = Terminal:new({
    cmd = 'go vet',
    hidden = true,
    direction = 'float',
    float_opts = {
      border = 'none',
      width = 100000,
      height = 100000,
    },
    on_open = function(_) end,
    on_close = function(_) end,
    count = 99,
  })
  govet:toggle()
end
return M
