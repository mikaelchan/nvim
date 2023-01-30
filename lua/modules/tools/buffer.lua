local M = {}
M.kill = function()
  local fn, cmd = vim.fn, vim.cmd
  local buflisted = fn.getbufinfo({ buflisted = 1 })
  if #buflisted < 2 then
    cmd('confirm q')
  end

  local cur_winnr, cur_bufnr = fn.winnr(), fn.bufnr()
  for _, winid in ipairs(fn.getbufinfo(cur_bufnr)[1].windows) do
    cmd(fn.win_id2win(winid) .. 'wincmd w')
    cmd(cur_bufnr == buflisted[#buflisted].bufnr and 'bp' or 'bn')
  end
  cmd(cur_winnr .. 'wincmd w')
  cmd(fn.getbufvar(cur_bufnr, '&buftype') == 'terminal' and 'bd! #' or 'silent! confirm bd #')
end
return M
