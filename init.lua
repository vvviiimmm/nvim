vim.defer_fn(function()
  pcall(require, "impatient")
end, 0)

require "core"
require "core.options"

require "plugins"

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {},
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr) end,
    default_settings = {
      -- rust-analyzer language server configuration
      ["rust-analyzer"] = {
        checkOnSave = true,
        -- temp
        -- ['cargo'] = {
        --   features = { 'prove' },
        -- },
      },
    },
  },
  -- DAP configuration
  dap = {},
}
