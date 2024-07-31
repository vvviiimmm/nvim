return function()
  local opts = {
    ensure_installed = {
      "rust",
      "scala",
      "lua",
      "python",
      "haskell",
      "bash",
      "json",
      "yaml",
      "toml",
      "html",
      "css",
      "javascript",
      "typescript",
      "tsx",
      "tsx",
      "go",
      "cpp",
      "c",
      "cmake",
      "dockerfile",
      "java",
    },

    highlight = {
      enable = true,
      -- use_languagetree = true,
    },

    indent = {
      enable = true,
    },

    rainbow = {
      enable = true,
      extended_mode = true,
      max_file_lines = nil,
    },
  }

  require("nvim-treesitter.configs").setup(opts)
end
