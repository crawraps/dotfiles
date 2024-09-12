return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    config = require('crawraps.plugins.lsp.snippets'),
    lazy = true,
  },
  {
    "saadparwaiz1/cmp_luasnip",
    lazy = true,
  },
  {
    'hrsh7th/cmp-path',
    lazy = true,
  },
  {
    'hrsh7th/cmp-buffer',
    lazy = true,
  },
  {
    "hrsh7th/nvim-cmp",
    lazy = true,
    dependencies = { "LuaSnip", "cmp_luasnip", "cmp-path", "cmp-buffer" },
    event = "InsertEnter",
    opts = require('crawraps.plugins.lsp.completions'),
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },
  {
    "williamboman/mason.nvim",
    lazy = true,
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    opts = {
      ensure_installed = {
        "lua_ls",
        "ts_ls",
      },
      handlers = { require('crawraps.plugins.lsp.servers').configure_common_server }
    },
  },
  {
    "creativenull/efmls-configs-nvim",
    version = "v1.x.x",
    lazy = true,
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    dependencies = { "cmp-nvim-lsp", "mason-lspconfig.nvim", "nvim-navic", "nvim-navbuddy", "efmls-configs-nvim" },
    config = require('crawraps.plugins.lsp.servers').configure_servers,
    init = function()
      -- formatters, linters and diagnostics
      require('crawraps.plugins.lsp.efm')
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    lazy = true,
    event = "InsertEnter",
    opts = {
      panel = {
        auto_refresh = true,
        layout = {
          position = "right",
          ratio = 0.3,
        },
      },
      suggestion = {
        auto_trigger = true,
        accept = false,
      },
    },
    init = function()
      vim.keymap.set("i", '<Tab>', function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, {
        silent = true,
      })
    end
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    event = "VeryLazy",
    dependencies = { "copilot.lua", "plenary.nvim" },
    config = true,
  },
}
