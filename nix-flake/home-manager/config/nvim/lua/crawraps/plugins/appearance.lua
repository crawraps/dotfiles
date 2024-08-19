return {
  { -- popups
    "stevearc/dressing.nvim",
    event = "CursorHold",
    opts = {
      input = {
        mappings = {
          i = {
            ["<Esc>"] = "Close",
          },
        },
      },
    },
  },
  { -- top buffer line
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    opts = {
      options = {
        mode = 'buffers',
        number = 'none',
        show_buffer_close_icons = false,
        diagnostics = 'nvim_lsp',
        offsets = {
          {
            filetype = 'NvimTree',
            text = 'File explorer',
            highlight = 'directory',
            separator = true,
          },
        },
        separator_style = { " ", " " },
      }
    },
  },
  { -- bottom info line
    "nvim-lualine/lualine.nvim",
    event = "BufRead",
    opts = function()
      local navic = require("nvim-navic")

      local function get_location()
        return '/ ' .. navic.get_location({
          highlight = true,
          separator = ' / ',
          depth_limit = 8,
        })
      end

      return {
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
            { 'diff',  colored = false },
          },
          lualine_c = {
            { get_location, cond = navic.is_available },
          },
          lualine_x = {
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
      }
    end
  },
  { -- lines showing current context
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = {
        char = '▏',
        highlight = { 'Comment' }
      }
    },
  },
  { -- show colors
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead" },
    config = function()
      require('colorizer').setup({
        '*',
        css = { rgb_fn = true },
        html = { names = false },
      }, {
        css = true,
        RRGGBBAA = true
      })
    end,
  },
  { -- current context info
    "SmiteshP/nvim-navic",
    lazy = true,
  },
}
