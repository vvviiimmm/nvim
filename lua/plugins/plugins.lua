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
      vim.cmd [[colorscheme everforest]]
    end,
    enabled = true,
  },

  {
    "folke/which-key.nvim",
    lazy = false,
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
    config = require "plugins.configs.cmp",
  },

  {
    "nvim-tree/nvim-tree.lua",
    keys = {
      -- { "<leader>e", "<cmd> NvimTreeFocus <CR>", desc = "focus nvimtree" },
      { "<leader>ee", "<cmd> NvimTreeToggle <CR>", desc = "toggle nvimtree" },
      { "<leader>er", "<cmd> NvimTreeRefresh <CR>", desc = "nvimtree refresh" },
      { "<Esc><Esc>", "<cmd> NvimTreeClose <CR>", desc = "close nvimtree" },
    },
    config = require "plugins.configs.nvimtree",
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>ff", "<cmd> Telescope find_files <CR>", desc = "find files" },
      { "<leader>fa", "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", desc = "find all" },
      { "<leader>fw", "<cmd> Telescope live_grep <CR>", desc = "live grep" },
      { "<leader>fb", "<cmd> Telescope buffers <CR>", desc = "find buffers" },
      { "<leader>fh", "<cmd> Telescope help_tags <CR>", desc = "help page" },
      { "<leader>fo", "<cmd> Telescope oldfiles <CR>", desc = "find oldfiles" },
      { "<leader>tk", "<cmd> Telescope keymaps <CR>", desc = "show keys" },
      { "<leader>fi", "<cmd> Telescope grep_string hidden=true <CR>", desc = "search word under the cursor" },

      -- telescope lsp
      { "<leader>fr", "<cmd> Telescope lsp_references <CR>", desc = "references" },
      { "<leader>ft", "<cmd> Telescope lsp_type_definitions <CR>", desc = "type definitions" },
      { "<leader>fd", "<cmd> Telescope lsp_definitions <CR>", desc = "definitions" },
      { "<leader>fq", "<cmd> Telescope quickfix <CR>", desc = "quickfix" },

      { "<leader>fs", "<cmd> Telescope aerial <CR>", desc = "document symbols" },
      { "<leader>fe", "<cmd> Telescope resume <CR>", desc = "telescope resume" },
      { "<leader>fg", "<cmd> Telescope git_status <CR>", desc = "git status" },
      { "<leader>fz", "<cmd> Telescope current_buffer_fuzzy_find <CR>", desc = "current buffer fuzzy" },
      { "<leader>fn", "<cmd> Telescope live_grep_args<CR>", desc = "find exact" },
      {
        "<leader>fl",
        function()
          local api = require "nvim-tree.api"
          local node = api.tree.get_node_under_cursor()
          if node and node.absolute_path then
            require("telescope.builtin").live_grep { search_dirs = { node.absolute_path } }
          else
            print "No directory selected in nvim-tree"
          end
        end,
        desc = "live grep in nvim-tree folder",
      },
    },
    config = require "plugins.configs.telescope",
    dependencies = {
      "stevearc/aerial.nvim",
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        version = "^1.0.0",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    keys = {
      { "<leader>gd", "<cmd> lua vim.lsp.buf.definition() <CR>", desc = "go to definition" },
      { "<leader>gg", "<cmd> lua vim.lsp.buf.declaration() <CR>", desc = "go to declaration" },
      { "<leader>gr", "<cmd> lua vim.lsp.buf.references() <CR>", desc = "go to references" },
      { "<leader>gi", "<cmd> lua vim.lsp.buf.implementation() <CR>", desc = "go to implementation" },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    config = require "plugins.configs.treesitter",
  },

  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
  },

  "nvim-lua/plenary.nvim",

  {
    "github/copilot.vim",
    lazy = false,
    keys = {
      { "<C-Space>", "<Plug>(copilot-accept-word)", mode = "i", desc = "copilot accept word" },
      { "<C-a>", "<Plug>(copilot-next)", mode = "i", desc = "copilot next" },
    },
    -- disable by default, only use when absolutely necessary
    config = function()
      vim.g.copilot_enabled = false
    end,
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      {
        "<leader><BS>",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        mode = "n",
        desc = "toggle comment",
      },
      {
        "<leader><BS>",
        "<ESC><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
        mode = "v",
        desc = "toggle comment",
      },
      {
        "<leader>o",
        function()
          require("utils").yank_paste_comment()
        end,
        mode = "v",
        desc = "yank paste",
      },
      {
        "<leader>cp",
        function()
          vim.cmd [[g/^\s*println!/normal gcc]]
        end,
        mode = "n",
        desc = "Comment println! statements",
      },
      {
        "<leader>up",
        function()
          vim.cmd [[g/^\s*\/\/\s*println!/normal gcc]]
        end,
        mode = "n",
        desc = "Uncomment println! statements",
      },
    },

    opts = {},
  },

  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {},
  },

  {
    "mrcjkb/rustaceanvim",
    version = "^4",
    lazy = false,
    keys = {
      { "<leader>rf", "<cmd> RustFmt <CR>", desc = "rustfmt" },
      { "<leader>rd", "<cmd> RustLsp openDocs <CR>", desc = "openRustDocs" },
    },
  },

  {
    "phaazon/hop.nvim",
    keys = {
      { "<leader>jj", "<cmd> HopChar2 <CR>", mode = { "v", "n" }, desc = "hop char" },
      { "<leader>k", "<cmd> HopWord <CR>", mode = { "v", "n" }, desc = "hop words" },
      { "<leader>jl", "<cmd> HopLine <CR>", mode = { "v", "n" }, desc = "hop line" },
      { "<leader>ja", "<cmd> HopWordMW <CR>", desc = "hop word multi window" },
    },
    config = require "plugins.configs.hop",
  },

  { "hrsh7th/cmp-nvim-lsp" },

  {
    "RRethy/vim-illuminate",
    config = require "plugins.configs.illuminate",
    enabled = false,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = require "plugins.configs.lualine",
  },

  { "hrsh7th/cmp-nvim-lua" },
  { "hrsh7th/cmp-nvim-lsp-signature-help" },
  -- { "hrsh7th/cmp-vsnip" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-buffer" },
  -- { "hrsh7th/vim-vsnip" },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>y", "<cmd> TroubleToggle <CR>", desc = "toggle troble" },
    },
    opts = {},
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
    -- S": surround selected text
    -- ds" or dsq
    -- ysiw"
  },

  {
    "voldikss/vim-floaterm",
    keys = {
      { "<leader>tt", "<cmd> FloatermToggle <CR>", desc = "toggle terminal" },
      { "<leader>tn", "<cmd> FloatermNew <CR>", desc = "new terminal" },
      { "<leader>ty", "<cmd> FloatermSend !! <CR> | <cmd> FloatermShow <CR>", desc = "new terminal" },
      {
        "<leader>ty",
        function()
          vim.cmd "write"
          vim.cmd "FloatermSend !!"
          vim.schedule(function()
            vim.cmd "FloatermShow"
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, false, true), "n", false)
          end)
        end,
        desc = "new terminal",
      },
      { "<leader>tg", "<cmd> FloatermNew --disposable lazygit <CR>", desc = "lazy git" },
      { "<Esc><Esc>", "<C-\\><C-n>:q<CR>", mode = "t", desc = "close terminal" },
      { "<Esc>l", "<cmd> FloatermNext <CR>", mode = "t", desc = "next terminal" },
      { "<Esc>h", "<cmd> FloatermPrev <CR>", mode = "t", desc = "prev terminal" },
      { "<Esc>n", "<cmd> FloatermNew <CR>", mode = "t", desc = "new terminal" },
    },
    config = function()
      vim.g.floaterm_width = 0.7
      vim.g.floaterm_width = 0.7
    end,
  },

  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<leader>bl", "<cmd>BufferLineCycleNext<CR>", desc = "bufferline: next buffer" },
      { "<leader>bh", "<cmd>BufferLineCyclePrev<CR>", desc = "bufferline: prev buffer" },
      { "<leader>bp", "<cmd>BufferLinePick<CR>", desc = "bufferline: pick" },
      { "<leader>br", "<cmd>BufferLineCloseRight<CR>", desc = "bufferline: close right" },
      {
        "<leader>bq",
        function()
          local current_buf = vim.api.nvim_get_current_buf()
          vim.cmd [[bprevious]]
          vim.api.nvim_buf_delete(current_buf, { force = true })
        end,
        desc = "bufferline: close and go back",
      },
      { "<leader>bf", "<cmd>:bfirst<CR>", desc = "bufferline: goto first tab" },
    },
    lazy = false,
    opts = {},
  },

  {
    "stevearc/aerial.nvim",
    opts = {
      backends = { "treesitter", "lsp", "markdown", "man" },
      lazy_load = false,
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>ll", "<cmd> AerialToggle<CR>", desc = "toggle aerial" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    keys = {
      { "<leader>mb", "<cmd> Gitsigns blame_line <CR>", desc = "gitsigns: blame line" },
      { "<leader>mm", "<cmd> Gitsigns toggle_signs <CR>", desc = "gitsigns: toggle" },
      { "<leader>ml", "<cmd> Gitsigns toggle_linehl <CR>", desc = "gitsigns: toggle line highlight" },
      { "<leader>mj", "<cmd> Gitsigns next_hunk <CR>", desc = "gitsigns: next hunk" },
      { "<leader>mk", "<cmd> Gitsigns prev_hunk <CR>", desc = "gitsigns: prev hunk" },
      { "<leader>mp", "<cmd> Gitsigns preview_hunk <CR>", desc = "gitsigns: preview hunk" },
      { "<leader>mi", "<cmd> Gitsigns preview_hunk_inline <CR>", desc = "gitsigns: preview hunk inline" },
      { "<leader>mr", "<cmd> Gitsigns reset_hunk <CR>", desc = "gitsigns: reset hunk" },
      { "<leader>mu", "<cmd> Gitsigns reset_buffer <CR>", desc = "gitsigns: reset buffer" },
      { "<leader>mc", "<cmd> Gitsigns toggle_current_line_blame <CR>", desc = "gitsigns: toggle blame" },
      { "<leader>ms", "<cmd> Gitsigns setqflist <CR>", desc = "gitsigns: all changes in qf" },
    },
    opts = {},
  },

  {
    "nvimdev/lspsaga.nvim",
    keys = {
      { "<leader>ca", "<cmd>Lspsaga code_action<CR>", desc = "lspsaga: code action", mode = "n" },
      { "<leader>sd", "<cmd>Lspsaga goto_definition<CR>", desc = "lspsaga: goto definition" },
      { "<leader>sn", "<cmd>Lspsaga incoming_calls<CR>", desc = "lspsaga: incoming calls" },
      { "<leader>sm", "<cmd>Lspsaga outgoing_calls<CR>", desc = "lspsaga: outgoing calls" },
      { "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", desc = "lspsaga: buf diagnostics" },
      { "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", desc = "lspsaga: line diagnostics" },
      { "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>", desc = "lspsaga: workspace diagnostics" },
      { "<leader>ss", "<cmd>Lspsaga outline<CR>", desc = "lspsaga: outline" },
      { "<leader>sp", "<cmd>Lspsaga peek_definition<CR>", desc = "lspsaga: peek definition" },
      { "<leader>sr", "<cmd>Lspsaga rename<CR>", desc = "lsp saga: rename" },
      { "<leader>sh", "<cmd>Lspsaga hover_doc<CR>", desc = "lsp saga: hover doc" },
      { "<leader>sj", "<cmd>Lspsaga diagnostic_jump_next<CR>", desc = "lsp saga: diagnostic jump next" },
      { "<leader>sk", "<cmd>Lspsaga diagnostic_jump_prev<CR>", desc = "lsp saga: diagnostic jump prev" },
    },
    config = require "plugins.configs.lspsaga",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    event = "LspAttach",
  },

  {
    "arkav/lualine-lsp-progress",
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
              spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
              -- spinner_symbols = { '🌑 ', '🌒 ', '🌓 ', '🌔 ', '🌕 ', '🌖 ', '🌗 ', '🌘 ' },
              -- display_components = { 'lsp_client_name', { 'title', 'percentage', 'message' }},
              display_components = { "spinner", { "title", "percentage", "message" } },
            },
          },
        },
      }
    end,
  },

  {
    "scalameta/nvim-metals",
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
    end,
  },

  {
    -- 'sindrets/diffview.nvim',
    -- 'vvviiimmm/diffview.nvim',
    dir = "~/dev/sandbox/diffview.nvim",
    lazy = false,
    keys = {
      { "<leader>dvo", "<cmd> DiffviewOpen <CR>", desc = "open diff view" },
      { "<leader>dvc", "<cmd> DiffviewClose <CR>", desc = "close diff view" },
    },
    config = require "plugins.configs.diffview",
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
    end,
  },

  {
    dir = "/Users/vi/dev/sandbox/nvim/helloplugin/",
    name = "helloplugin",
    config = function()
      require "scratch_buffer"
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
      {
        "<leader>lz",
        "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>",
        desc = "Spectre search on current file",
      },
      { "<leader>li", "<cmd>lua require('spectre').open_visual()<CR>", desc = "Search current word", mode = "v" },
    },
  },
  {
    "folke/zen-mode.nvim",
    opts = {},
    keys = {
      { "<leader>nn", "<cmd>ZenMode<CR>", desc = "Zen mode" },
    },
  },
  {
    "MunifTanjim/nui.nvim",
  },
  {
    "julienvincent/hunk.nvim",
    cmd = { "DiffEditor" },
    dependencies = { "MunifTanjim/nui.nvim" },
    config = require "plugins.configs.hunk",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    keys = {
      { "<leader>bi", "<cmd>IBLToggle<CR>", desc = "toggle indent blankline" },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },

  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>dn", "<cmd>DapNew<CR>", desc = "new debug session" },
      { "<leader>db", "<cmd>DapToggleBreakpoint<CR>", desc = "toggle breakpoint" },
      { "<leader>dj", "<cmd>DapStepOver<CR>", desc = "dap: step over" },
      { "<leader>dt", "<cmd>DapTerminate<CR>", desc = "dap: terminate" },
    },
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    lazy = true,
    opts = {},
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "toggle dap ui",
      },
    },
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return { "treesitter", "indent" }
      end,
    },
    config = require "plugins.configs.ufo",
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    dependencies = {
      -- "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    build = "make install_jsregexp",
    config = function()
      require("luasnip.loaders.from_lua").load { paths = "~/.config/nvim/lua/snippets/" }
      require("luasnip").config.setup {}
    end,
    keys = {
        
    }
  },
}

local opts = {}

return plugins, ops
