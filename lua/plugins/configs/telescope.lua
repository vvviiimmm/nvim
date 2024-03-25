-- scope search to a directory selected via file_browser
local ts_select_dir = function(live_grep)
  local action_state = require("telescope.actions.state")
  local fb = require("telescope").extensions.file_browser
  local current_line = action_state.get_current_line()

  local fn = function(prompt_bufnr)
    fb.file_browser({
      files = false,
      depth = false,
      attach_mappings = function(prompt_bufnr)
        require("telescope.actions").select_default:replace(function()
          local entry_path = action_state.get_selected_entry().Path
          local dir = entry_path:is_dir() and entry_path or entry_path:parent()
          local relative = dir:make_relative(vim.fn.getcwd())
          local absolute = dir:absolute()

          live_grep({
            results_title = relative .. "/",
            cwd = absolute,
            default_text = current_line,
          })
        end)

        return true
      end,
    })
  end

  return fn
end

return function()
  local opts = {
     defaults = {
      vimgrep_arguments = {
        "rg",
        "-L",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        n = { ["q"] = require("telescope.actions").close },
      },
    },
    pickers = {
      buffers = {
        ignore_current_buffer = true,
        sort_mru = true,
      },
      live_grep = {
        mappings = {
          i = {
            ["<C-f>"] = ts_select_dir(require("telescope.builtin").live_grep),
          },
          n = {
            ["<C-f>"] = ts_select_dir(require("telescope.builtin").live_grep),
          },
        },
      },
      find_files = {
        mappings = {
          i = {
            ["<C-f>"] = ts_select_dir(require("telescope.builtin").find_files),
          },
          n = {
            ["<C-f>"] = ts_select_dir(require("telescope.builtin").find_files),
          },
        },
      },
    },

    extensions_list = { "themes", "terms", "file_browser" },
  }
  
  local telescope = require("telescope")
  telescope.setup(opts)
  -- telescope.extensions.aerial.aerial()

end
