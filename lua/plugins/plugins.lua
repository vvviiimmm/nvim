local plugins = {

  {
    "sainnhe/everforest",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        vim.opt.termguicolors = true
        vim.opt.background = "dark"
        vim.g.everforest_background = "medium"
        vim.g.everforest_enable_italic = 1
        vim.g.everforest_better_performance = 1
        -- vim.g.nvim_tree_disable_statusline = 1
        vim.g.everforest_transparent_background = 1

        -- load the colorscheme here
        vim.cmd([[colorscheme everforest]])
    end,
    enabled = true,
  },

  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
    enabled = false,
  },

  { 
    "folke/which-key.nvim", 
    lazy = false 
  },

  {
    "hrsh7th/nvim-cmp",
    -- load cmp on InsertEnter
    event = "InsertEnter",
    -- these dependencies will only be loaded when cmp loads
    -- dependencies are always lazy-loaded unless specified otherwise
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      -- ...
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      {"<leader>e", "<cmd> NvimTreeFocus <CR>", desc = "focus nvimtree" },
      {"<leader>b", "<cmd> NvimTreeToggle <CR>", desc = "toggle nvimtree" },
    },
    config = require("plugins.configs.nvimtree")
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {"<leader>ff", "<cmd> Telescope find_files <CR>", desc = "find files" },
      {"<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", desc = "find all" },
      {"<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "live grep" },
      {"<leader>fb", "<cmd> Telescope buffers <CR>", desc = "find buffers" },
      {"<C-Tab>", "<cmd> Telescope buffers <CR>", desc = "find buffers" },
      {"<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "help page" },
      {"<leader>fo", "<cmd> Telescope oldfiles <CR>", desc = "find oldfiles" },
      {"<leader>tk", "<cmd> Telescope keymaps <CR>", desc = "show keys" },
      {"<leader>fi", "<cmd> Telescope grep_string <CR>", desc = "search word under the cursor" },
      {"<leader>tk", "<cmd> Telescope keymaps <CR>", desc = "show keys" },

      -- git
      {"<leader>cm", "<cmd> Telescope git_commits <CR>", desc = "git commits" },
      {"<leader>gt", "<cmd> Telescope git_status <CR>", desc = "git status" },

      -- telescope lsp
      {"<leader>fr", "<cmd> Telescope lps_references <CR>", desc = "references" },
    },
    config = require("plugins.configs.telescope")
  },

  {
    "neovim/nvim-lspconfig",
    keys = {
      {"<leader>gd", "<cmd> lua vim.lsp.buf.definition() <CR>", desc = "go to definition"},
      {"<leader>gD", "<cmd> lua vim.lsp.buf.declaration() <CR>", desc = "go to declaration"}, 
      {"<leader>gr", "<cmd> lua vim.lsp.buf.references() <CR>", desc = "go to references"}, 
      {"<leader>gd", "<cmd> lua vim.lsp.buf.implementation() <CR>", desc = "go to implementation"}, 
      {"<leader>rn", "<cmd> lua vim.lsp.buf.rename() <CR>", desc = "rename"}, 
      {"<leader>ca", "<cmd> lua vim.lsp.buf.code_action() <CR>", desc = "code action"}, 
      {"<leader>h", "<cmd> lua vim.lsp.buf.hover() <CR>", desc = "hover"}, 
      -- {"<leader>wa", "<cmd> lua vim.lsp.buf.add_workspace_folder() <CR>", desc = "add workspace folder"}, 
      -- {"<leader>wr", "<cmd> lua vim.lsp.buf.remove_workspace_folder() <CR>", desc = "remove workspace folder"}, 
      -- {"<leader>wl", "<cmd> lua print(vim.inspect(vim.lsp.buf.list_workspace_folders())) <CR>", desc = "list workspace folders"}, 
      {"<leader>D", "<cmd> lua vim.lsp.buf.type_definition() <CR>", desc = "type definition"}, 
      -- signature_help
    }
  },

  {
    "nvim-treesitter/nvim-treesitter",
    -- opts = require("plugins.configs.treesitter"),
    config = require("plugins.configs.treesitter")
  },

  { 
    "nvim-tree/nvim-web-devicons", 
    lazy = true 
  }, {
    "mg979/vim-visual-multi",
    lazy = false
  },

  'nvim-lua/plenary.nvim',

  { 
    'github/copilot.vim',
    lazy = false,
    keys = {
      -- suggest
    },
  },

  {
    'numToStr/Comment.nvim',
    keys = {
        {"<leader>/", function() require("Comment.api").toggle.linewise.current() end, mode = "n", desc = "toggle comment" },
        {"<leader>/",  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", mode = "v", desc = "toggle comment" },
    },
    opts = {}
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {}
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {}
  },

  {
    "simrat39/rust-tools.nvim",
    opts = require("plugins.configs.rust-tools")
  },

  { 'hrsh7th/nvim-cmp',
    config = require("plugins.configs.cmp"),
  }, 

  -- navigation
  {
    'phaazon/hop.nvim',
    keys = {
      { "<leader>jj", "<cmd> HopWord <CR>", desc = "hop words"},
      { "<leader>jl", "<cmd> HopLine <CR>", desc = "hop line"},
      { "<leader>ja", "<cmd> HopWordMW <CR>", desc = "hop word multi window"},
    },
    opts = {}
  },

  -- LSP completion source:
  { 'hrsh7th/cmp-nvim-lsp',
  },

  -- illuminate
  {
    'RRethy/vim-illuminate',
    config = require("plugins.configs.illuminate")
  },

  -- autopair
  {
    'windwp/nvim-autopairs',
    opts = {}
  },

  { "lukas-reineke/indent-blankline.nvim" },

  -- visual
  {
    'nvim-lualine/lualine.nvim',
    opts = {}
  },

  -- Useful completion sources:
  { 'hrsh7th/cmp-nvim-lua',
  },
  { 'hrsh7th/cmp-nvim-lsp-signature-help',
  },
  { 'hrsh7th/cmp-vsnip',
  },                             
  { 'hrsh7th/cmp-path',
  },                              
  { 'hrsh7th/cmp-buffer',
  },                            
  { 'hrsh7th/vim-vsnip',
  },
}

local opts = {}

return plugins, ops
