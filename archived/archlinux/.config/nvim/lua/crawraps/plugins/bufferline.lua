require("bufferline").setup({
  options = {
    mode = 'buffers',
    diagnostics = 'nvim_lsp',
    offsets = {
      {
        filetype = 'NvimTree',
        text = 'File explorer',
        highlight = 'directory',
        separator = true,
      }
    }
  }
})


