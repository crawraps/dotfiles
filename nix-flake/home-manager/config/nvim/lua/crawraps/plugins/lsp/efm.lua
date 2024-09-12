local languages = require('efmls-configs.defaults').languages()
languages = vim.tbl_extend('force', languages, {
  -- Custom languages, or override existing ones
  vue = {
    require('efmls-configs.formatters.prettier'),
    require('efmls-configs.linters.eslint'),
  },
})

local efmls_config = {
  filetypes = vim.tbl_keys(languages),
  settings = {
    rootMarkers = { '.git/', 'package.json' },
    languages = languages,
  },
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
}

require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_config, {
  on_attach = require('crawraps.plugins.lsp.servers').on_attach,
  capabilities = require('crawraps.plugins.lsp.servers').capabilities,
  flags = require('crawraps.plugins.lsp.servers').flags,
}))


-- Configuring native diagnostics
vim.diagnostic.config({
  virtual_text = {
    prefix = "·",
    spacing = 2,
    virt_text_pos = "eol",
  },
  float = true,
})

for _, diag in ipairs({ "Error", "Warn", "Info", "Hint" }) do
  vim.fn.sign_define("DiagnosticSign" .. diag, {
    text = "",
    texthl = "DiagnosticSign" .. diag,
    linehl = "",
    numhl = "DiagnosticSign" .. diag,
  })
end
