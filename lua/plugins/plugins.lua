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
    config = require("plugins.configs.cmp")
 },

  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      -- {"<leader>e", "<cmd> NvimTreeFocus <CR>", desc = "focus nvimtree" },
      {"<leader>e", "<cmd> NvimTreeFocus <CR>", desc = "focus nvimtree" },
      {"<leader>ee", "<cmd> NvimTreeToggle <CR>", desc = "toggle nvimtree" },
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
      {"<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "help page" },
      {"<leader>fo", "<cmd> Telescope oldfiles <CR>", desc = "find oldfiles" },
      {"<leader>tk", "<cmd> Telescope keymaps <CR>", desc = "show keys" },
      {"<leader>fi", "<cmd> Telescope grep_string hidden=true <CR>", desc = "search word under the cursor" },

      -- git (deprecated, use lazygit)
      -- {"<leader>cm", "<cmd> Telescope git_commits <CR>", desc = "git commits" },
      -- {"<leader>gt", "<cmd> Telescope git_status <CR>", desc = "git status" },

      -- telescope lsp
      {"<leader>fr", "<cmd> Telescope lsp_references <CR>", desc = "references" },
      {"<leader>ft", "<cmd> Telescope lsp_type_definitions <CR>", desc = "type definitions" },
      {"<leader>fd", "<cmd> Telescope lsp_definitions <CR>", desc = "definitions" },
      { "<leader>fq", "<cmd> Telescope quickfix <CR>", desc = "quickfix" },

      {"<leader>fs", "<cmd> Telescope aerial <CR>", desc = "document symbols" },
      {"<leader>fe", "<cmd> Telescope resume <CR>", desc = "telescope resume" },
      {"<leader>fg", "<cmd> Telescope git_status <CR>", desc = "git status" },
      {"<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "current buffer fuzzy" },
    },
    config = require("plugins.configs.telescope"),
    dependencies = {
      'stevearc/aerial.nvim',
      { 
        "nvim-telescope/telescope-live-grep-args.nvim" ,
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    }

  },

  {
    "neovim/nvim-lspconfig",
    keys = {
      {"<leader>gd", "<cmd> lua vim.lsp.buf.definition() <CR>", desc = "go to definition"},
      {"<leader>gg", "<cmd> lua vim.lsp.buf.declaration() <CR>", desc = "go to declaration"}, 
      {"<leader>gr", "<cmd> lua vim.lsp.buf.references() <CR>", desc = "go to references"}, 
      {"<leader>gi", "<cmd> lua vim.lsp.buf.implementation() <CR>", desc = "go to implementation"}, 
      {"<leader>rn", "<cmd> lua vim.lsp.buf.rename() <CR>", desc = "rename"}, 
      -- {"<leader>ca", "<cmd> lua vim.lsp.buf.code_action() <CR>", desc = "code action"}, 
      {"<leader>h", "<cmd> lua vim.lsp.buf.hover() <CR>", desc = "hover"}, 
      -- {"<leader>wa", "<cmd> lua vim.lsp.buf.add_workspace_folder() <CR>", desc = "add workspace folder"}, 
      -- {"<leader>wr", "<cmd> lua vim.lsp.buf.remove_workspace_folder() <CR>", desc = "remove workspace folder"}, 
      -- {"<leader>wl", "<cmd> lua print(vim.inspect(vim.lsp.buf.list_workspace_folders())) <CR>", desc = "list workspace folders"}, 
      -- {"<leader>D", "<cmd> lua vim.lsp.buf.type_definition() <CR>", desc = "type definition"}, 
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
        {"<leader><BS>", function() require("Comment.api").toggle.linewise.current() end, mode = "n", desc = "toggle comment" },
        {"<leader><BS>",  "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", mode = "v", desc = "toggle comment" },
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

  -- {
  --   "simrat39/rust-tools.nvim",
  --   config = require("plugins.configs.rust-tools"),
  --   keys = {
  --     {"<leader>rf","<cmd> :%! rustfmt <CR>", desc = "rustfmt" },
  --     {"<leader>rc","<cmd> RustOpenCargo <CR>" , desc = "open cargo" },
  --   },
  --   lazy = false
  -- },

  {
    'mrcjkb/rustaceanvim',
    version = '^4',
    lazy = false,
  },

  -- navigation
  {
    'phaazon/hop.nvim',
    keys = {
      { "<leader>jj", "<cmd> HopChar2 <CR>", mode = {"v", "n"}, desc = "hop char"},
      { "<leader>k", "<cmd> HopWord <CR>", mode = { "v", "n"}, desc = "hop words"},
      { "<leader>jl", "<cmd> HopLine <CR>", mode = { "v", "n"}, desc = "hop line"},
      { "<leader>ja", "<cmd> HopWordMW <CR>", desc = "hop word multi window"},
    },
    config = require("plugins.configs.hop"),
  },

  -- LSP completion source:
  { 'hrsh7th/cmp-nvim-lsp',
  },

  -- illuminate
  {
    'RRethy/vim-illuminate',
    config = require("plugins.configs.illuminate"),
    enabled = false,
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
    opts = require("plugins.configs.lualine")
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

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {"<leader>y", "<cmd> TroubleToggle <CR>", desc = "toggle troble"},
    },
    opts = {

    },
  },        

  {
    'tpope/vim-surround',
    config = function()
      vim.g.surround_mappings_style = "surround"
    end
  },

  {
    'voldikss/vim-floaterm',
    keys = {
      {"<leader>tt", "<cmd> FloatermToggle <CR>", desc = "toggle terminal"},
      {"<leader>tn", "<cmd> FloatermNew <CR>", desc = "new terminal"},
      {"<leader>ty", "<cmd> FloatermSend !! <CR> | <cmd> FloatermShow <CR>", desc = "new terminal"},
      {"<leader>ty", function() 
        vim.cmd("write")
        vim.cmd("FloatermSend !!")
        vim.schedule(function()
            vim.cmd("FloatermShow")
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
        end)
      end, desc = "new terminal"},
      {"<leader>tn", function()  end, desc = "new terminal"},
      {"<leader>tg", "<cmd> FloatermNew --disposable lazygit <CR>", desc = "lazy git"},
      {"<Esc><Esc>", "<C-\\><C-n>:q<CR>", mode = "t", desc = "close terminal"},
    },
    config = function()
      vim.g.floaterm_width = 0.9
      vim.g.floaterm_width = 0.8
    end
  },

  {
    'akinsho/bufferline.nvim',
    keys = {
      { "<leader>bl", "<cmd>BufferLineCycleNext<CR>", desc = "bufferline: next buffer"},
      { "<leader>bh", "<cmd>BufferLineCyclePrev<CR>", desc = "bufferline: prev buffer"},
      { "<leader>bp", "<cmd>BufferLinePick<CR>", desc = "bufferline: pick"},
      { "<leader>br", "<cmd>BufferLineCloseRight<CR>", desc = "bufferline: close right"},
      { "<leader>bq", function() 
        local current_buf = vim.api.nvim_get_current_buf()
          vim.cmd [[bprevious]]
          vim.api.nvim_buf_delete(current_buf, {force = true})
        end, desc = "bufferline: close and go back"},
      { "<leader>bf", "<cmd>:bfirst<CR>", desc = "bufferline: goto first tab"},
    },
    lazy = false,
    opts = {}
  },

  {
    'stevearc/aerial.nvim',
    opts = {
      backends = { "treesitter", "lsp", "markdown", "man" },
      lazy_load = false,
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    keys = {
      {"<leader>ll", "<cmd> AerialToggle<CR>", desc = "toggle aerial"},
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    keys = {
      {"<leader>mb", "<cmd> Gitsigns blame_line <CR>", desc = "gitsigns: blame line"},
      {"<leader>mm", "<cmd> Gitsigns toggle_signs <CR>", desc = "gitsigns: toggle"},
      {"<leader>ml", "<cmd> Gitsigns toggle_linehl <CR>", desc = "gitsigns: toggle line highlight"},
      {"<leader>mj", "<cmd> Gitsigns next_hunk <CR>", desc = "gitsigns: next hunk"},
      {"<leader>mk", "<cmd> Gitsigns prev_hunk <CR>", desc = "gitsigns: prev hunk"},
      {"<leader>mp", "<cmd> Gitsigns preview_hunk <CR>", desc = "gitsigns: preview hunk"},
      {"<leader>mi", "<cmd> Gitsigns preview_hunk_inline <CR>", desc = "gitsigns: preview hunk inline"},
      {"<leader>mr", "<cmd> Gitsigns reset_hunk <CR>", desc = "gitsigns: reset hunk"},
      {"<leader>mu", "<cmd> Gitsigns reset_buffer <CR>", desc = "gitsigns: reset buffer"},
      {"<leader>mc", "<cmd> Gitsigns toggle_current_line_blame <CR>", desc = "gitsigns: toggle blame"},
      {"<leader>ms", "<cmd> Gitsigns setqflist <CR>", desc = "gitsigns: all changes in qf"},
    },
    opts = {}
  },

  {
    'nvimdev/lspsaga.nvim',
    keys = {
      {"<leader>ca", "<cmd>Lspsaga code_action<CR>", desc = "lspsaga: code action", mode = "n"}, 
      {"<leader>sd", "<cmd>Lspsaga goto_definition<CR>", desc = "lspsaga: goto definition"}, 
      {"<leader>sn", "<cmd>Lspsaga incoming_calls<CR>", desc = "lspsaga: incoming calls"}, 
      {"<leader>sm", "<cmd>Lspsaga outgoing_calls<CR>", desc = "lspsaga: outgoing calls"}, 
      {"<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", desc = "lspsaga: buf diagnostics"}, 
      {"<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "lspsaga: line diagnostics"}, 
      {"<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "lspsaga: workspace diagnostics"}, 
      {"<leader>ss", "<cmd>Lspsaga outline<CR>", desc = "lspsaga: outline"}, 
      {"<leader>sp", "<cmd>Lspsaga peek_definition<CR>", desc = "lspsaga: peek definition"}, 
      {"<leader>sr", "<cmd>Lspsaga rename<CR>", desc = "lsp saga: rename"}, 
      {"<leader>sh", "<cmd>Lspsaga hover_doc<CR>", desc = "lsp saga: hover doc"}, 

    },
    config = require("plugins.configs.lspsaga"),
  },

  {
    'arkav/lualine-lsp-progress',
    config = function()
      require("lualine").setup {
        options = {
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_c = {
            {
              "lsp_progress",
              spinner_symbols = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
              -- spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
              -- display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' }},
              display_components = { 'spinner', { 'title', 'percentage', 'message' } },
            },
          },
        },
      }
    end
  },

  -- {
  --   'puremourning/vimspector'
  -- },

  {
    "shortcuts/no-neck-pain.nvim",
    keys = {
      {"<leader>nn", "<cmd> NoNeckPain <CR>", desc = "toggle no neck pain"},
    },
    config = require("plugins.configs.no-neck-pain"),
    lazy = false,
  },

  -- {
  --   'edluffy/specs.nvim',
  --   opts = { 
  --     show_jumps  = true,
  --     min_jump = 30,
  --     popup = {
  --       delay_ms = 0, -- delay before popup displays
  --       inc_ms = 10, -- time increments used for fade/resize effects 
  --       blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
  --       width = 10,
  --       winhl = "PMenu",
  --       fader = require('specs').linear_fader,
  --       resizer = require('specs').shrink_resizer
  --     },
  --     ignore_filetypes = {},
  --     ignore_buftypes = {
  --       nofile = true,
  --     },
  --   }
  -- }

  -- {
  --   '-hui/fidget.nvim',
  --   config = function()
  --     require("fidget").setup()
  --   end
  -- }

  {
    'scalameta/nvim-metals',
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-lua/popup.nvim",
    },
    config = function()
      local metals_config = require("metals").bare_config()

      metals_config.settings = {
        showImplicitArguments = true,
        excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
      }
    end
  },

  {
    -- 'sindrets/diffview.nvim',
    -- 'vvviiimmm/diffview.nvim'
    dir = '~/dev/sandbox/diffview.nvim',
    lazy = false,
    keys = {
      {"<leader>dvo", "<cmd> DiffviewOpen <CR>", desc = "open diff view"},
      {"<leader>dvc", "<cmd> DiffviewClose <CR>", desc = "close diff view"},
    },
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },

  { 
    "folke/neodev.nvim", 
    opts = {},
    config = function()
      require("neodev").setup()
    end
  },

  {
    dir = "/Users/vi/dev/sandbox/nvim/helloplugin/",
    name = "helloplugin",
    config = function()
      require("scratch_buffer")
    end,
    lazy = false,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {},
    -- stylua: ignore
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>lz", "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>", desc = "Spectre search on current file" },
      { "<leader>li", "<cmd>lua require('spectre').open_visual()<CR>", desc = "Search current word", mode = "v" },
    }
  }
}

local opts = {}

return plugins, ops
