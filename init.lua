vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

  
require "core"
require "core.options"

require("plugins")
