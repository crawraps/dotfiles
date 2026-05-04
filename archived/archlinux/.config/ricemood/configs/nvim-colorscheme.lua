require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = true,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
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
        green = "#94f5b7",
        teal = "#5bd0dc",
        sky = "#99D1DB",
        sapphire = "#85C1DC",
        blue = "^r@pr^",
        lavender = "^r@fg^",

        text = "^r@fg^",
        subtext1 = "^r@fg>da(0.1)>de^",
        subtext0 = "^r@fg>da(0.2)>de^",
        overlay2 = "^r@fg>da(0.3)>de^",
        overlay1 = "^r@fg>da(0.4)>de^",
        overlay0 = "^r@fg>da(0.5)>de^",
        surface2 = "^r@fg>da(0.6)>de^",
        surface1 = "^r@fg>da(0.7)>de^",
        surface0 = "^r@fg>da(0.8)>de^",

        base = "#352939",
        mantle = "#211924",
        crust = "#1a1016",
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
})

vim.cmd('colorscheme catppuccin')
