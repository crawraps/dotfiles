return function()
  local types = require('luasnip.util.types')

  require('luasnip').setup({
    ext_opts = {
      [types.choiceNode] = {
        active = {
          virt_text = { { '●', 'DiffAdd' } },
        },
      },
      [types.insertNode] = {
        active = {
          virt_text = { { '●', 'DiffDelete' } },
        },
      },
    },
  })

  -- Loading any vscode snippets from plugins
  require('luasnip.loaders.from_vscode').lazy_load()

  -- Allow jsx and tsx to use js snippets
  require('luasnip').filetype_extend('javascript', { 'javascriptreact', 'typescriptreact' })
end

