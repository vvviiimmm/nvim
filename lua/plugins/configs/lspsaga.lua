return function()
  local opts = {
    rename = {
      auto_save = true,
    },
    beacon = {
      frequency = 20,
    },
  }

  require("lspsaga").setup(opts)
end
