return function()
  -- vim.o.foldcolumn = '1' -- '0' is not bad
  vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true

  vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

  local ufo = require "ufo"
  local opts = {
      provider_selector = function(bufnr, filetype, buftype)
        return {'treesitter', 'indent'}
      end
  }

  ufo.setup(opts)
end
