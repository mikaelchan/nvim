-- vim: ft=lua tw=80

std.nvim = {
  globals = {
    vim = {fields = {'g'}},
  },
  read_globals = {
    'jit',
    'os',
    'vim'
  },
}
std = "lua51+nvim"
self = false
ignore = {
  '631',
  '212/_.*',
}
