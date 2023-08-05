local opt = vim.opt
local g = vim.g

vim.opt.formatoptions:remove({ 'c', 'r', 'o' })

opt.laststatus = 3 -- global statusline
opt.showmode = false
opt.termguicolors = true
g.loaded_netrw = 1
g.loaded_netrwPlugin = 1

opt.clipboard = "unnamedplus"
opt.cursorline = true

--Set completeopt to have a better completion experience
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300) 

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true


-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"


g.mapleader = " "

vim.api.nvim_set_keymap('n', '<C-S>', ':w<CR>', { noremap = true })
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>,', ':nohlsearch<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<Leader>l', ':w<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '[', '{', {noremap = true, silent = true})

-- move between buffers
vim.api.nvim_set_keymap('n', '<S-Tab>', '<C-^>', { noremap = true })


-- move to mappings
--g.copilot_no_tab_map = true
--g.copilot_assume_mapped = true
--vim.api.nvim_set_keymap("i", "<C-O>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

opt.clipboard = { 'unnamed', 'unnamedplus' }

-- disable some builtin vim plugins
local default_plugins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
  "tutor",
  "rplugin",
  "syntax",
  "synmenu",
  "optwin",
  "compiler",
  "bugreport",
  "ftplugin",
}

for _, plugin in pairs(default_plugins) do
  g["loaded_" .. plugin] = 1
end

local default_providers = {
  "node",
  "perl",
  "python3",
  "ruby",
}

for _, provider in ipairs(default_providers) do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

vim.cmd [[
  autocmd FileType * setlocal formatoptions-=ro
]]

