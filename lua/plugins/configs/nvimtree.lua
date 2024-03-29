return function() 
  local ops = {
    filters = {
      dotfiles = false,
    },
    disable_netrw = true,
    hijack_netrw = true,
    -- open_on_setup = false,
    hijack_cursor = true,
    hijack_unnamed_buffer_when_opening = false,
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = false,
    },
    view = {
      adaptive_size = true,
      side = "left",
      width = 25,
      -- hide_root_folder = true,
    },
    git = {
      enable = false,
      ignore = true,
    },
    filesystem_watchers = {
      enable = true,
      ignore_dirs = { ".git", "node_modules", ".cache", "target" },
    },
    actions = {
      open_file = {
        resize_window = true,
      },
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      highlight_opened_files = "none",

      indent_markers = {
        enable = false,
      },

      icons = {
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = false,
        },
        -- glyphs = {
        --   default = "",
        --   symlink = "",
        --   folder = {
        --     default = "",
        --     empty = "",
        --     empty_open = "",
        --     open = "",
        --     symlink = "",
        --     symlink_open = "",
        --     arrow_open = "",
        --     arrow_closed = "",
        --   },
        --   git = {
        --     unstaged = "✗",
        --     staged = "✓",
        --     unmerged = "",
        --     renamed = "➜",
        --     untracked = "★",
        --     deleted = "",
        --     ignored = "◌",
        --   },
        -- },
      },
    },
  }

  require("nvim-tree").setup(ops)

end

