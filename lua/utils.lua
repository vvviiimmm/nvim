local M = {}

function M.yank_paste_comment()
  vim.cmd 'normal! "zy'
  vim.cmd 'normal! `>"zp'
  vim.cmd "normal! `<"
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
  vim.cmd "normal! `]"
end

return M
