return {
  {
    "catppuccin/nvim",
    priority = 1000,
    main = "catppuccin",
    lazy = false,
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
          lavender = "{{ color13 }}",
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
    config = function(_, opts)
      require("catppuccin").setup(opts)

      local background = "{{ background }}"
      local foreground = "{{ foreground }}"
      local dark = "{{ color4 | darken(0.6) }}"
      local color = "{{ color13 }}"
      local dimmed = "{{ background | lighten(0.5) }}"

      local function set_hl(group, opts)
        vim.api.nvim_set_hl(0, group, opts)
      end

      -- undo/redo highlighting
      set_hl('HighlightUndo', { bg = dark })
      set_hl('HighlightRedo', { bg = dark })

      set_hl('RecordStatus', { fg = background, bg = color, blend = 0 })

      set_hl('LuaLineContext', { fg = dimmed })

      -- buffer line
      set_hl('BufferCurrent', { fg = foreground, bold = true })
      set_hl('BufferCurrentMod', { fg = color, bold = true })

      set_hl('BufferInactive', { fg = dimmed })
      set_hl('BufferInactiveMod', { fg = dimmed, bold = false })

      -- vim-illuminate
      set_hl('IlluminatedWord', { bg = dark, bold = true })

      -- snacks indent and scope
      set_hl('SnacksIndent', { fg = dark })
      set_hl('SnacksIndentScope', { fg = dimmed })

      if (vim.g.neovide) then
        -- background
        set_hl('Normal', { bg = background })
        set_hl('NormalFloat', { bg = background, blend = 70 })
        set_hl('FloatBorder', { bg = background, blend = 70 })

        -- nvim-cmp
        set_hl('PMenu', { link = "NormalFloat" })
        set_hl('PMenuBorder', { link = "FloatBorder" })
        set_hl('PMenuSel', { bg = background, blend = 30 })

        -- Lazy popup window
        set_hl('LazyNormal', { bg = background, blend = 100 })

        -- Yazi
        set_hl('YaziBufferHovered', { bg = background, blend = 100 })
        set_hl('YaziBufferSameDirectory', { bg = background, blend = 100 })
        set_hl('YaziFloat', { link = "NormalFloat" })

        -- Telescope
        set_hl('TelescopeNormal', { link = "NormalFloat" })

        set_hl('NotifyBackground', { link = "NormalFloat" })

        set_hl('NotificationMiniNormal', { bg = background, blend = 100 })
        set_hl('NotificationNormal', { link = "NormalFloat" })
        set_hl('ProgressNormal', { link = "NormalFloat" })
      end

      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
