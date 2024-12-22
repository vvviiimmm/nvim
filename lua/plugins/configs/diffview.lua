return function()
  local diffview = require "diffview"

  local opts = {
    git_cmd = { "git" },
  }

  diffview.setup(opts)
end
