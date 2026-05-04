local navic = require("nvim-navic")

vim.api.nvim_set_hl(0, "NavicText", {fg = "#DEBAD4"})

local function get_location()
  return '/ ' .. navic.get_location({
    highlight = true,
    separator = ' / ',
    depth_limit = 100,
  })
end

local function get_codeium()
  return vim.fn['codeium#GetStatusString']()
end

require('lualine').setup({
  options = {
    theme = 'catppuccin',
    component_separators = '',
    section_separators = '',
    icons_enabled = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {
      { 'mode', color = { gui = 'bold' } },
    },
    lualine_b = {
      { 'branch' },
      { 'diff', colored = false },
    },
    lualine_c = {
      { 'filename', file_status = true },
      { get_location, cond = navic.is_available },
    },
    lualine_x = {
      { get_codeium, cond = vim.g.codeium_enabled },
      'diagnostics',
      'filetype',
      'encoding',
    },
    lualine_y = { 'progress' },
    lualine_z = {
      { 'location', color = { gui = 'bold' } },
    },
  },
  extensions = { 'quickfix', 'nvim-tree' },
})

