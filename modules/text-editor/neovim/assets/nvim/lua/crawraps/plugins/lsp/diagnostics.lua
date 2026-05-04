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
