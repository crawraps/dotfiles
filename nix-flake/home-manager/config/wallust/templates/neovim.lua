return {
  {
    "catppuccin/nvim",
    priority = 1000,
    main = "catppuccin",
    opts = {
      flavour = "mocha",
      transparent_background = true,
      show_end_of_buffer = false,
      term_colors = true,
      dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
      },
      styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
      },
      color_overrides = {
        all = {
          rosewater = "#F2D5CF",
          flamingo = "#EEBEBE",
          pink = "#F4B8E4",
          mauve = "#cf96f7",
          red = "#E78284",
          maroon = "#EA999C",
          peach = "#faa65b",
          yellow = "#f7e593",
          green = "{{ color10 | lighten(0.5) }}",
          teal = "#5bd0dc",
          sky = "#99D1DB",
          sapphire = "#85C1DC",
          lavender = "{{ color4 }}",
          blue = "{{ color12 }}",

          text = "{{ foreground }}",
          subtext1 = "{{ background | lighten(0.6) }}",
          subtext0 = "{{ background | lighten(0.5) }}",
          overlay2 = "{{ background | lighten(0.4) }}",
          overlay1 = "{{ background | lighten(0.4) }}",
          overlay0 = "{{ background | lighten(0.4) }}",
          surface2 = "{{ color4 | darken(0.4) }}",
          surface1 = "{{ color4 | darken(0.5) }}",
          surface0 = "{{ color4 | darken(0.6) }}",

          base = "{{ background | saturate(0.2) }}",
          mantle = "{{ background | saturate(0.1) }}",
          crust = "{{ background }}",
        },
      },
      custom_highlights = function(colors)
        return {
          CursorLineNr = {
            fg = colors.overlay2,
          },
          Comment = {
            fg = colors.overlay2,
          }
        }
      end,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        telescope = true,
        hop = true,
        notify = false,
        mini = false,
        indent_blankline = {
          enabled = true,
          colored_indent_levels = false,
        },
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
        },
        navic = {
          enabled = true,
        },
      },
    },
    init = function()
      vim.cmd('colorscheme catppuccin')
    end,
  },
}
