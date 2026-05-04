return {
  {
    "numToStr/FTerm.nvim",
    event = "CursorHold",
    opts = {
      border = vim.g.neovide and "solid" or "rounded",
      dimensions = { height = 0.75, width = 0.75 },
      hl = 'NormalFloat',
    },
    init = function()
      vim.keymap.set('n', '<A-i>', "<CMD>lua require('FTerm').toggle()<CR>")
      vim.keymap.set('t', '<A-i>', "<C-\\><C-n><CMD>lua require('FTerm').toggle()<CR>")
    end,
  },
}
