local M = {}

M.format_filter = function(client)
  local filetype = vim.bo.filetype
  local nls = require('null-ls')
  local method = nls.methods.FORMATTING
  local sources = require('null-ls.sources')

  local available_formatters = sources.get_available(filetype, method)
  if #available_formatters == 0 then
    return client.name == 'null-ls'
  elseif client.supports_method('textDocument/formatting') then
    return true
  else
    return false
  end
end

M.format = function(opts)
  opts = opts or {}
  opts.filter = opts.filter or M.format_filter
  return vim.lsp.buf.format(opts)
end

return M
