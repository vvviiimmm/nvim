return function()
  local cmp = require('cmp')

  local lspkind_comparator = function(conf)
    local lsp_types = require('cmp.types').lsp
    return function(entry1, entry2)
      if entry1.source.name ~= 'nvim_lsp' then
        if entry2.source.name == 'nvim_lsp' then
          return false
        else
          return nil
        end
      end
      local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
      local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

      local priority1 = conf.kind_priority[kind1] or 0
      local priority2 = conf.kind_priority[kind2] or 0
      if priority1 == priority2 then
        return nil
      end
      return priority2 < priority1
    end
  end

  local label_comparator = function(entry1, entry2)
    return entry1.completion_item.label < entry2.completion_item.label
  end

  local opts = {
    -- Enable LSP snippets
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      ['<Up>'] = cmp.mapping.select_prev_item(),
      ['<Down>'] = cmp.mapping.select_next_item(),
      -- Add tab support
      ['<S-Tab>'] = cmp.mapping.select_prev_item(),
      -- ['<Tab>'] = cmp.mapping.select_next_item(),
      ['<C-I>'] = cmp.mapping.scroll_docs(-4),
      ['<C-P>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      })
    },
    -- Installed sources:
    sources = cmp.config.sources({
      { name = 'path' },                              -- file paths
      { name = 'nvim_lsp' },      -- from language server
      { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
      { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
      { name = 'buffer', keyword_length = 3 },        -- source current buffer
      { name = 'vsnip', keyword_length = 3  },         -- nvim-cmp source for vim-vsnip 
    }),
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      fields = {'kind','abbr','menu' },
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '📁',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
    },

    sorting = {
      comparators = {
        lspkind_comparator({
          kind_priority = {
            Field = 211,
            Property = 11,
            Constant = 10,
            Enum = 10,
            EnumMember = 10,
            Event = 10,
            Function = 10,
            Method = 10,
            Operator = 10,
            Reference = 10,
            Struct = 10,
            Variable = 9,
            File = 8,
            Folder = 8,
            Class = 5,
            Color = 5,
            Module = 5,
            Keyword = 2,
            Constructor = 1,
            Interface = 1,
            Snippet = 0,
            Text = 1,
            TypeParameter = 1,
            Unit = 1,
            Value = 1,
          },
        }),
        label_comparator,
      },
    }
  }
  
  cmp.setup(opts)

  --  -- Set up lspconfig.
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['rust-analyzer'].setup {
  --   capabilities = capabilities
  -- }
end
