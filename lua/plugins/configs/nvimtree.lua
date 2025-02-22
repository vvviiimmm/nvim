local log_file = vim.fn.stdpath "data" .. "/zen_tree_debug.log"

local function log_message(msg)
  local file = io.open(log_file, "a")
  if file then
    file:write(os.date "%Y-%m-%d %H:%M:%S" .. " " .. msg .. "\n")
    file:close()
  end
end

local function zen_window_picker()
  log_message "Entering zen_window_picker function"
  local windows = vim.api.nvim_list_wins()
  local zen_window = nil

  log_message("Total windows: " .. #windows)

  for _, win in ipairs(windows) do
    local buf = vim.api.nvim_win_get_buf(win)
    local win_config = vim.api.nvim_win_get_config(win)
    local filetype = vim.bo[buf].filetype
    local bufname = vim.fn.bufname(buf)

    local log_entry = string.format(
      "Window %d:\n"
        .. "  Buffer: %d\n"
        .. "  Filetype: %s\n"
        .. "  Bufname: %s\n"
        .. "  Is floating: %s\n"
        .. "  Width: %d\n"
        .. "  Height: %d\n"
        .. "  Is current: %s\n",
      win,
      buf,
      filetype,
      bufname,
      tostring(win_config.relative ~= ""),
      win_config.width or vim.api.nvim_win_get_width(win),
      win_config.height or vim.api.nvim_win_get_height(win),
      tostring(vim.api.nvim_get_current_win() == win)
    )

    log_message(log_entry)

    if win_config.relative ~= "" and filetype ~= "NvimTree" and filetype ~= "zenmode-bg" and bufname ~= "" then
      zen_window = win
      log_message("Selecting as potential zen window: " .. win)
    end
  end

  log_message("ZenMode active: " .. tostring(vim.g.zen_mode_active or false))
  log_message("Final selected zen window: " .. tostring(zen_window))

  return zen_window
end

local function open_in_zen_window(file_path)
  local zen_window
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local win_config = vim.api.nvim_win_get_config(win)
    local filetype = vim.bo[buf].filetype
    local bufname = vim.fn.bufname(buf)

    if win_config.relative ~= "" and filetype ~= "NvimTree" and filetype ~= "zenmode-bg" and bufname ~= "" then
      zen_window = win
      break
    end
  end

  if zen_window then
    -- Switch to the ZenMode window
    vim.api.nvim_set_current_win(zen_window)
    -- Open the file in this window
    vim.cmd("edit " .. vim.fn.fnameescape(file_path))
  else
    -- Fallback: open in the current window
    vim.cmd("edit " .. vim.fn.fnameescape(file_path))
  end
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
      float = {
        enable = true,
        open_win_config = {
          border = "rounded",
          relative = "cursor",
          -- width = 100,
          height = 50,
        },
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
        window_picker = {
          enable = false,
        },
        quit_on_open = false,
      },
    },
    on_attach = function(bufnr)
      local api = require "nvim-tree.api"

      -- call default on_attach to maintain all the default mappings
      require("nvim-tree.keymap").default_on_attach(bufnr)

      local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
      end

      -- then create a custom "open file" mapping to play nice with zenmode
      vim.keymap.set("n", "<CR>", function()
        local node = api.tree.get_node_under_cursor()
        if node.nodes ~= nil then
          -- expand/collapse folder
          api.node.open.edit()
        else
          -- open file
          api.tree.close()
          open_in_zen_window(node.absolute_path)
        end
      end, opts "Open")
    end,
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
