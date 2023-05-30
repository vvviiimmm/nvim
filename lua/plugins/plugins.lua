local plugins = {
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  { 
    "folke/which-key.nvim", 
    lazy = true 
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
    },
   -- opts = {}
    opts = require("plugins.configs.nvimtree")
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {"<leader>ff", "<cmd> Telescope find_files <CR>", desc = "find files" },
      {"<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", desc = "find all" },
      {"<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "live grep" },
      {"<leader>fb", "<cmd> Telescope buffers <CR>", desc = "find buffers" },
      {"<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "help page" },
      {"<leader>fo", "<cmd> Telescope oldfiles <CR>", desc = "find oldfiles" },
      {"<leader>tk", "<cmd> Telescope keymaps <CR>", desc = "show keys" },
      {"<leader>fi", "<cmd> Telescope grep_string <CR>", desc = "search word under the cursor" },

      -- git
      {"<leader>cm", "<cmd> Telescope git_commits <CR>", desc = "git commits" },
      {"<leader>gt", "<cmd> Telescope git_status <CR>", desc = "git status" },

      -- pick a hidden term
      {"<leader>pt", "<cmd> Telescope terms <CR>", desc = "pick hidden term" },
    },
    config = require("plugins.configs.telescope")
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = require("plugins.configs.treesitter")
  },

  { 
    "nvim-tree/nvim-web-devicons", 
    lazy = true 
  },

  {
    "mg979/vim-visual-multi",
    lazy = true
  },

  'nvim-lua/plenary.nvim',

  { 
    'github/copilot.vim',
    lazy = false,
    keys = {
    },
  },

  {
    'numToStr/Comment.nvim',
    opts = {}
  }
}

local opts = {}

return plugins, ops
