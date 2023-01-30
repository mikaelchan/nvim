local M = {}

M.setup_codelens_refresh = function(client, bufnr)
  local status_ok, codelens_supported = pcall(function()
    return client.supports_method('textDocument/codeLens')
  end)
  if not status_ok or not codelens_supported then
    return
  end
  local group = 'LspCodeLensRefresh'
  local events = { 'BufEnter', 'InsertLeave' }
  local ok, autocmds = pcall(vim.api.nvim_get_autocmd({ group = group, buffer = bufnr, events = events }))
  if ok and #autocmds > 0 then
    return
  end
  vim.api.nvim_create_augroup(group, { clear = false })
  vim.api.nvim_create_autocmd(events, {
    group = group,
    buffer = bufnr,
    callback = vim.lsp.codelens.refresh,
  })
end

return M
