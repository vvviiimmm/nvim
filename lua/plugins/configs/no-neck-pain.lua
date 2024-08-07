return function()
  local NoNeckPain = require "no-neck-pain"
  local opts = {
    -- Prints useful logs about triggered events, and reasons actions are executed.
    --- @type boolean
    debug = false,
    -- The width of the focused window that will be centered. When the terminal width is less than the `width` option, the side buffers won't be created.
    --- @type integer|"textwidth"|"colorcolumn"
    width = 150,
    -- Represents the lowest width value a side buffer should be.
    -- This option can be useful when switching window size frequently, example:
    -- in full screen screen, width is 210, you define an NNP `width` of 100, which creates each side buffer with a width of 50. If you resize your terminal to the half of the screen, each side buffer would be of width 5 and thereforce might not be useful and/or add "noise" to your workflow.
    --- @type integer
    minSideBufferWidth = 10,
    -- Disables the plugin if the last valid buffer in the list have been closed.
    --- @type boolean
    disableOnLastBuffer = false,
    -- When `true`, disabling the plugin closes every other windows except the initially focused one.
    --- @type boolean
    killAllBuffersOnDisable = false,
    -- Adds autocmd (@see `:h autocmd`) which aims at automatically enabling the plugin.
    --- @type table
    autocmds = {
      -- When `true`, enables the plugin when you start Neovim.
      -- If the main window is  a side tree (e.g. NvimTree) or a dashboard, the command is delayed until it finds a valid window.
      -- The command is cleaned once it has successfuly ran once.
      --- @type boolean
      enableOnVimEnter = false,
      -- When `true`, enables the plugin when you enter a new Tab.
      -- note: it does not trigger if you come back to an existing tab, to prevent unwanted interfer with user's decisions.
      --- @type boolean
      enableOnTabEnter = false,
      -- When `true`, reloads the plugin configuration after a colorscheme change.
      --- @type boolean
      reloadOnColorSchemeChange = false,
    },
    -- Creates mappings for you to easily interact with the exposed commands.
    --- @type table
    mappings = {
      -- When `true`, creates all the mappings that are not set to `false`.
      --- @type boolean
      enabled = false,
      -- Sets a global mapping to Neovim, which allows you to toggle the plugin.
      -- When `false`, the mapping is not created.
      --- @type string
      toggle = "<Leader>np",
      -- Sets a global mapping to Neovim, which allows you to increase the width (+5) of the main window.
      -- When `false`, the mapping is not created.
      --- @type string
      widthUp = "<Leader>n=",
      -- Sets a global mapping to Neovim, which allows you to decrease the width (-5) of the main window.
      -- When `false`, the mapping is not created.
      --- @type string
      widthDown = "<Leader>n-",
      -- Sets a global mapping to Neovim, which allows you to toggle the scratchpad feature.
      -- When `false`, the mapping is not created.
      --- @type string
      scratchPad = "<Leader>ns",
    },
    --- Common options that are set to both side buffers.
    --- See |NoNeckPain.bufferOptions| for option scoped to the `left` and/or `right` buffer.
    --- @type table
    buffers = {
      -- When `true`, the side buffers will be named `no-neck-pain-left` and `no-neck-pain-right` respectively.
      --- @type boolean
      setNames = false,
      -- Leverages the side buffers as notepads, which work like any Neovim buffer and automatically saves its content at the given `location`.
      -- note: quitting an unsaved scratchpad buffer is non-blocking, and the content is still saved.
      --- see |NoNeckPain.bufferOptionsScratchpad|
      scratchPad = NoNeckPain.bufferOptionsScratchpad,
      -- colors to apply to both side buffers, for buffer scopped options @see |NoNeckPain.bufferOptions|
      --- see |NoNeckPain.bufferOptionsColors|
      colors = NoNeckPain.bufferOptionsColors,
      -- Vim buffer-scoped options: any `vim.bo` options is accepted here.
      --- @see NoNeckPain.bufferOptionsBo `:h NoNeckPain.bufferOptionsBo`
      bo = NoNeckPain.bufferOptionsBo,
      -- Vim window-scoped options: any `vim.wo` options is accepted here.
      --- @see NoNeckPain.bufferOptionsWo `:h NoNeckPain.bufferOptionsWo`
      wo = NoNeckPain.bufferOptionsWo,
      --- Options applied to the `left` buffer, options defined here overrides the `buffers` ones.
      --- @see NoNeckPain.bufferOptions `:h NoNeckPain.bufferOptions`
      left = NoNeckPain.bufferOptions,
      --- Options applied to the `right` buffer, options defined here overrides the `buffers` ones.
      --- @see NoNeckPain.bufferOptions `:h NoNeckPain.bufferOptions`
      right = NoNeckPain.bufferOptions,
    },
    -- Supported integrations that might clash with `no-neck-pain.nvim`'s behavior.
    --- @type table
    integrations = {
      -- By default, if NvimTree is open, we will close it and reopen it when enabling the plugin,
      -- this prevents having the side buffers wrongly positioned.
      -- @link https://github.com/nvim-tree/nvim-tree.lua
      --- @type table
      NvimTree = {
        -- The position of the tree.
        --- @type "left"|"right"
        position = "left",
        -- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
        --- @type boolean
        reopen = false,
      },
      -- By default, if NeoTree is open, we will close it and reopen it when enabling the plugin,
      -- this prevents having the side buffers wrongly positioned.
      -- @link https://github.com/nvim-neo-tree/neo-tree.nvim
      NeoTree = {
        -- The position of the tree.
        --- @type "left"|"right"
        position = "left",
        -- When `true`, if the tree was opened before enabling the plugin, we will reopen it.
        reopen = false,
      },
      -- @link https://github.com/mbbill/undotree
      undotree = {
        -- The position of the tree.
        --- @type "left"|"right"
        position = "left",
      },
    },
  }

  NoNeckPain.setup(opts)
end
