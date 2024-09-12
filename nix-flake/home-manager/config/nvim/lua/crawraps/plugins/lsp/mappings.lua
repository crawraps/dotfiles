return function(buf)
  local map = vim.keymap.set
  local opts = { buffer = buf }

  map('n', 'gl', '<cmd>Navbuddy<CR>', opts)

  map('n', ',f', '<cmd>lua vim.lsp.buf.format()<CR>', opts)
  map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map('n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

  map('i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- map('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- map('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- map('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map('n', '<leader>c', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- map('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  map('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  map('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  -- map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)

  -- Mappins to move around inside snippets
  map({ 'i', 's' }, '<C-j>', '<CMD>lua require("luasnip").jump(1)<CR>')
  map({ 'i', 's' }, '<C-k>', '<CMD>lua require("luasnip").jump(-1)<CR>')
end

