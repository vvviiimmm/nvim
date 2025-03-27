local opt = vim.opt
local g = vim.g

vim.api.nvim_set_keymap("t", "<C-l>", "<C-\\><C-N>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<C-S>", ":w<CR>", { noremap = true })
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true })
vim.api.nvim_set_keymap("n", "[", "{", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-'>", '"', { noremap = true, silent = true })

-- visuals
vim.api.nvim_set_keymap(
  "n",
  "<Leader>li",
  ":lua vim.api.inlay_hints.enable(true) <CR>",
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "<Leader>hs", ":noh<CR>", { silent = false })
vim.api.nvim_set_keymap("n", "<Leader>,", ":nohlsearch<CR>", { silent = true })

-- corne awkwardness
vim.api.nvim_set_keymap("i", "<C-t>", "=>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("i", "<C-t>", "->", { noremap = true, silent = true })

-- movement
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { silent = true })

-- move between buffers
vim.api.nvim_set_keymap("n", "<S-Tab>", "<C-^>", { noremap = true })

-- copy filename to buffer
vim.api.nvim_set_keymap("n", "<C-T>", ":let @+ = expand('%:p')<CR>", { noremap = true })

-- still not using this one
vim.api.nvim_set_keymap("n", "<Leader>l", ":w<CR>", { silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", { noremap = true })
--vim.api.nvim_set_keymap("i", "<C-O>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
