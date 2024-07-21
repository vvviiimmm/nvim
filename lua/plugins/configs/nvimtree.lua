local function get_centered_window_config()
  local screen_w = vim.opt.columns:get()
  local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
  local window_w = math.floor(screen_w * 0.5)
  local window_h = math.floor(screen_h * 0.5)
  local window_w_int = math.floor(window_w)
  local window_h_int = math.floor(window_h)
  local center_x = (screen_w - window_w) / 2
  local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
  return {
    border = "rounded",
    relative = "cursor",
    row = center_y,
    col = center_x,
    width = window_w_int,
    height = window_h_int,
  }
end

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
      -- side = "right",
      -- width = 25,
      -- hide_root_folder = true,
      float = {
        enable = true,
        open_win_config = {
          border = "rounded",
          relative = "cursor",
          row = center_y,
          col = center_x,
          width = window_w_int,
          height = window_h_int,
        }
      },
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
        window_picker = {
          enable = false,
        }
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

