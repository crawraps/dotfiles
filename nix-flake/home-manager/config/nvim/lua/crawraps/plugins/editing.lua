return {
  { -- additional "surroundings"
    "tpope/vim-surround",
    event = "BufRead",
    dependencies = { "vim-repeat" },
  },
  { -- toggling between single-line and multi-line statement
    'Wansmer/treesj',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    keys = {
      { "sl", function() require('treesj').toggle() end },
      { "sj", function() require('treesj').split() end },
      { "sk", function() require('treesj').join() end },
    },
    config = true,
  },
  { -- commenting
    "numToStr/Comment.nvim",
    event = 'BufRead',
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    opts = function(Comment)
      return { -- required for .jsx, .tsx files
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
      }
    end,
  },
  { -- auto pair quotes, brackets, etc.
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
  { -- auto xml tags
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter" },
    event = "InsertEnter"
  },
}
