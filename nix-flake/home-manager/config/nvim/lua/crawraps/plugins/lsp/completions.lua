return function()
  local cmp = require('cmp')

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end

  local next_comp = function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
      -- elseif luasnip.expand_or_jumpable() then
      --   luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end

  local prev_comp = function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
      -- elseif luasnip.jumpable(-1) then
      --   luasnip.jump(-1)
    else
      fallback()
    end
  end

  local icons = {
    Text = ' ',
    Method = ' ',
    Function = '󰊕',
    Constructor = 'c',
    Field = ' ',
    Variable = '󰫧 ',
    Class = ' ',
    Interface = '{}',
    Module = '󰕳 ',
    Property = '~',
    Unit = 'u',
    Value = 'v',
    Enum = '',
    Keyword = '󰌆 ',
    Snippet = ' ',
    Color = ' ',
    File = '',
    Reference = '',
    Folder = ' ',
    EnumMember = ' ',
    Constant = 'ℇ ',
    Struct = ' ',
    Event = '',
    Operator = '⊙',
    TypeParameter = ' ',
  }

  return {
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-e>'] = cmp.config.disable,
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
      ['<C-Space>'] = cmp.mapping.complete(),
      --['<Tab>'] = cmp.mapping(next_comp, { "i", "s" }),
      --['<S-Tab>'] = cmp.mapping(prev_comp, { "i", "s" }),
      ['<M-j>'] = cmp.mapping(next_comp, { "i", "s" }),
      ['<M-k>'] = cmp.mapping(prev_comp, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp', max_item_count = 20 },
      { name = 'luasnip',  max_item_count = 20 },
      { name = 'path',     max_item_count = 10 },
      { name = 'buffer',   max_item_count = 10 },
    }),
    formatting = {
      format = function(entry, item)
        -- Kind icons
        item.kind = string.format('%s', icons[item.kind])
        return item
      end,
    },
  }
end
