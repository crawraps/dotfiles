return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
  },
  {
    "tpope/vim-surround",
    event = "BufRead",
    dependencies = { "vim-repeat" },
  },
  {
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { "sl", function() require('treesj').toggle() end },
      { "sj", function() require('treesj').split() end },
      { "sk", function() require('treesj').join() end },
    },
    config = true,
  },
  {
    "numToStr/Comment.nvim",
    event = 'BufRead',
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    opts = function(Comment)
      return {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {
      enable_check_bracket_line = true,
    },
    config = function(_, opts)
      require('nvim-autopairs').setup(opts)

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter" },
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      }
    },
  },
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup({})
      require("telescope").load_extension("textcase")
    end,
    keys = {
      "ga",
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
    },
    cmd = {
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
    lazy = false,
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { "markdown", "codecompanion" }
  },
  {
    "HakonHarnes/img-clip.nvim",
    event = "VeryLazy",
    opts = {
      default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
          insert_mode = true,
        },
      },
    },
  },
  {
    "olimorris/codecompanion.nvim",
    version = "^19.1.0",
    opts = function()
      vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
      vim.keymap.set({ "n", "v" }, "<LocalLeader>a", "<cmd>CodeCompanionChat Toggle<cr>",
        { noremap = true, silent = true })
      vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

      vim.cmd([[cab cc CodeCompanion]])

      return {
        adapters = {
          http = {
            gemini_code_assist = function()
              return require("codecompanion.adapters").extend("gemini-code-assist", {
                env = {},
              })
            end,
          },
          acp = {
            gemini_cli = function()
              return require("codecompanion.adapters").extend("gemini_cli", {
                defaults = {
                  auth_method = "oauth-personal",
                  mcpServers = "inherit_from_config",
                },
              })
            end,
          },
        },
        interactions = {
          inline = { adapter = { name = "gemini-code-assist", model = "gemini-3-flash-preview" } },
          chat = { adapter = { name = "gemini_cli", model = "gemini-3.1-pro-preview" } },
          cmd = { adapter = { name = "gemini-code-assist", model = "gemini-3-flash-preview" } },
        },
        rules = {
          modular_rules = {
            description = "Modular rules",
            files = { ".rules/**/*.md" },
          },
          opts = {
            chat = {
              autoload = "modular_rules",
            },
          },
        },
        mcp = {
          servers = {},
          opts = { default_servers = {} },
        },
        display = {
          action_palette = {
            provider = "telescope",
          },
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "viespejo/cc-adapter-gemini-code-assist.nvim",
    },
  },
}
