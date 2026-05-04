return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'gitsigns.nvim',
      'nvim-web-devicons',
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      clickable = false,
      icons = {
        button = '',
        separator = { left = '', right = '' },
        separator_at_end = false,
        separator_at_start = false,
        inactive = {
          separator = { left = '', right = '' },
        },
      },
    },
  },
  { -- bottom info line
    "nvim-lualine/lualine.nvim",
    event = "BufRead",
    opts = function()
      local navic = require("nvim-navic")
      local noice = require("noice")

      local function get_location()
        return require("auto-session.lib").current_session_name(true) .. '/ ' .. navic.get_location({
          highlight = true,
          separator = ' / ',
          depth_limit = 8,
        })
      end

      local function get_copilot_status()
        return vim.api.nvim_call_function("codeium#GetStatusString", {})
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
            {
              noice.api.statusline.mode.get,
              fmt = function(value)
                return string.find(value, "record") and value:sub(-2) or ""
              end,
              cond = noice.api.statusline.mode.has,
              color = 'RecordStatus',
            },
          },
          lualine_c = {
            { get_location, cond = navic.is_available, color = "LuaLineContext" },
          },
          lualine_x = {
            {
              "codecompanion",
              icon = " ",
              -- spinner_symbols = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
              spinner_symbols = { "", "", "", "", "", "" },
              done_symbol = "✓",
            }
          },
          lualine_y = {
            'diagnostics',
            {
              get_copilot_status
            },
            'filetype',
            'progress' },
          lualine_z = {
            { 'location', color = { gui = 'bold' } },
          },
        },
        extensions = { 'quickfix', 'nvim-tree' },
      }
    end
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
  {
    'tzachar/highlight-undo.nvim',
    opts = {
      hlgroup = "HighlightUndo",
      duration = 300,
      pattern = { "*" },
      ignored_filetypes = { "neo-tree", "fugitive", "TelescopePrompt", "mason", "lazy" },
    },
  },
  { -- current context info
    "SmiteshP/nvim-navic",
    lazy = true,
  },
  { -- notifications and custom command line
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "nui.nvim",
    },
    opts = {
      presets = {
        long_message_to_split = true,
      },
      routes = {
        {
          view = "notice",
          filter = { event = { "confirm", "confirm_sub", "rpc_error" } },
        },
        {
          view = "notifier",
          filter = {
            event = "msg_show",
            any = {
              { min_height = 2 },
            }
          },
        },
        {
          view = "mini",
          filter = {
            event = "msg_show",
            error = true,
          }
        },
        {
          opts = { skip = true },
          filter = {
            event = "msg_show",
          }
        },
      },
      lsp = {
        progress = {
          enabled = true,
          -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
          -- See the section on formatting for more details on how to customize.
          --- @type NoiceFormat|string
          format = "lsp_progress",
          --- @type NoiceFormat|string
          format_done = "lsp_progress_done",
          throttle = 1000 / 30, -- frequency to update lsp progress message
          view = "mini",
        },
      },
      views = {
        cmdline_popup = {
          border = vim.g.neovide and {
            style = "none",
            padding = { 1, 2 },
          } or {
            style = "rounded",
          },
          position = {
            row = -3,
            col = 0.5,
          },
          size = {
            width = '50%',
            height = 1,
          },
          win_options = {
            winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" }
          }
        },
        popupmenu = { -- cmd line completions
          enabled = true,
          scrollbar = false,
          position = {
            row = "88%",
            col = "50%",
          },
          size = {
            height = 'auto',
            width = '52%',
            min_height = 12,
            max_height = 20,
          },
          border = vim.g.neovide and {
            style = "none",
            padding = { 1, 2, 0, 2 },
          } or {
            style = "rounded",
          },
          win_options = {
            winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" }
          },
        },
        mini = {
          size = {
            max_height = 4,
          },
          win_options = {
            winhighlight = { Normal = "NotificationMiniNormal" }
          },
          position = {
            row = -2,
            col = -2,
          },
          border = {
            style = "none",
            padding = { 0, 1 },
          },
        },
        notifier = {
          backend = "popup",
          relative = "editor",
          align = "message-left",
          reverse = false,
          focusable = true,
          timeout = 5000,
          position = {
            row = -3,
            col = 0.5,
          },
          close = {
            keys = { "q" },
          },
          size = {
            width = "auto",
            height = "auto",
            max_height = 10,
          },
          border = {
            style = "none",
            padding = { 1, 2 },
          },
          win_options = {
            winhighlight = { Normal = "NotificationNormal" }
          },
        },
        notice = {
          backend = "popup",
          relative = "editor",
          focusable = false,
          align = "center",
          enter = false,
          zindex = 210,
          format = { "{confirm}" },
          position = { row = "50%", col = "50%" },
          size = "auto",
          border = { style = "rounded", padding = { 0, 1 } },
          win_options = {
            winhighlight = {
              Normal = "NoiceConfirm",
              FloatBorder = "NoiceConfirmBorder"
            },
            winbar = "",
            foldenable = false
          }
        },
      },
    },
  },
}
