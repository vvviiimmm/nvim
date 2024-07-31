return function()
  local opts = {
    rename = {
      auto_save = true,
    },
  }

  require("lspsaga").setup(opts)
end
