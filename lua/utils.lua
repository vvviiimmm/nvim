local M = {}

function M.yank_paste_comment()
  vim.cmd 'normal! "zy'
  vim.cmd 'normal! `>"zp'
  vim.cmd "normal! `<"
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
  vim.cmd "normal! `]"
end

function M.yank_paste()
  vim.cmd('normal! "zy')
  
  vim.cmd('normal! `>o')

  vim.cmd('normal! cc ')
  vim.cmd('normal! x"zp')
end
return M
