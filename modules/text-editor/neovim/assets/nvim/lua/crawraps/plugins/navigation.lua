local function are_all_buffers_unnamed_and_empty()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    if bufname ~= '' then
      return false -- If any buffer has a name, return false
    end

    local readonly = vim.api.nvim_get_option_value('readonly', { buf = bufnr })
    if readonly then
      return false
    end

    local listed = vim.api.nvim_get_option_value('buflisted', { buf = bufnr })
    if not listed then
      return false
    end

    local buftype = vim.api.nvim_get_option_value('buftype', { buf = bufnr })
    if buftype == 'terminal' then
      return false
    end
    if buftype == "quickfix" then
      return false
    end

    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    if #lines > 1 or (#lines == 1 and #lines[1] > 0) then
      return false
    end
  end
  return true
end

return {
  { -- lists finder
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = {
      "plenary.nvim",
      "auto-session",
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    after = "auto-session",
    opts = function()
      local actions = require("telescope.actions")
      local lactions = require("telescope.actions.layout")

      return {
        defaults = {
          -- borderchars = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
          borderchars = vim.g.neovide and { " ", " ", " ", " ", " ", " ", " ", " " },
          prompt_prefix = " > ",
          initial_mode = "insert",
          sorting_strategy = "ascending",
          layout_config = {
            prompt_position = "top",
          },
          mappings = {
            i = {
              ["<ESC>"] = actions.close,
              ["<A-j>"] = actions.move_selection_next,
              ["<A-k>"] = actions.move_selection_previous,
              ["<TAB>"] = actions.toggle_selection + actions.move_selection_next,
              ["<C-s>"] = actions.send_selected_to_qflist,
              ["<C-q>"] = actions.send_to_qflist,
              ["<C-h>"] = lactions.toggle_preview,
            },
          },
        }
      }
    end,
    init = function()
      local finders = require("telescope.builtin")
      local Telescope = setmetatable({}, {
        __index = function(_, k)
          if vim.bo.filetype == "NvimTree" then
            vim.cmd.wincmd("l")
          end
          return finders[k]
        end,
      })

      -- Ctrl-p = fuzzy finder
      vim.keymap.set("n", "<C-P>", function()
        local ok = pcall(Telescope.git_files, { show_untracked = true })
        if not ok then
          Telescope.find_files()
        end
      end)

      vim.keymap.set("n", "'h", Telescope.help_tags)       -- get :help at the speed of light
      vim.keymap.set("n", "'b", Telescope.buffers)         -- Fuzzy find active buffers
      vim.keymap.set("n", "'r", Telescope.live_grep)       -- Search for string
      vim.keymap.set("n", "'c", Telescope.git_status)      -- Fuzzy find changed files in git
      vim.keymap.set("n", "gr", Telescope.lsp_references)  -- Lsp references
      vim.keymap.set("n", "gd", Telescope.lsp_definitions) -- Lsp definitions
    end,
  },
  { -- navigate between buffers
    "numToStr/Navigator.nvim",
    event = "CursorHold",
    opts = {
      auto_save = "current",
    },
    init = function()
      local modes = { "n", "i", "v", "t", "c" }
      -- vim.keymap.set(modes, "", "<CMD>NavigatorLeft<CR>")
      -- vim.keymap.set(modes, "", "<CMD>NavigatorRight<CR>")
      -- vim.keymap.set(modes, "", "<CMD>NavigatorUp<CR>")
      -- vim.keymap.set(modes, "", "<CMD>NavigatorDown<CR>")
    end,
  },
  {
    "folke/todo-comments.nvim",
    optional = true,
    keys = {
      { "<leader>st", function() Snacks.picker.todo_comments() end,                                          desc = "Todo" },
      { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } }) end, desc = "Todo/Fix/Fixme" },
    },
  },
  { -- navigate to word specific word by keyboard
    "phaazon/hop.nvim",
    event = "BufRead",
    config = true,
    init = function()
      vim.keymap.set("n", "<S-j>", "<CMD>HopWordAC<CR>")
      vim.keymap.set("n", "<S-k>", "<CMD>HopWordBC<CR>")
    end,
  },
  { -- pretty scroll
    "karb94/neoscroll.nvim",
    enabled = not vim.g.neovide,
    opts = {
      hide_cursor = false,
    },
  },
  { -- navigate between language entities (see lsp.lua)
    "SmiteshP/nvim-navbuddy",
    dependencies = { "nvim-navic", "nui.nvim" },
    lazy = true,
    opts = {
      window = {
        border = vim.g.neovide and { " ", " ", " ", " ", " ", " ", " ", " " } or "rounded",
      }
    },
  },
  { -- session manager
    "rmagatti/auto-session",
    opts = {
      suppressed_dirs = { "~/", "~/downloads/*", "~/temp/*", "~/.config/*", "/" },
      no_restore_cmds = {
        function()
          vim.schedule(function() -- auto open session search on startup with no session
            if are_all_buffers_unnamed_and_empty() then
              vim.cmd("AutoSession search")
            end
          end)
        end,
      },
      session_lens = {
        load_on_setup = true,
        picker_opts = {
          border = true,
          borderchars = vim.g.neovide and {
            prompt = { " ", " ", " ", " ", " ", " ", " ", " " },
            results = { " ", " ", " ", " ", " ", " ", " ", " " },
            preview = { " ", " ", " ", " ", " ", " ", " ", " " },
          },
        },
      },
    },
    init = function()
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    end
  },
  { -- yazi intergration
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<A-/>",
        "<cmd>Yazi<cr>",
        desc = "Open yazi at the current file",
      },
      {
        "<C-/>",
        "<cmd>Yazi cwd<cr>",
        desc = "Open the file manager in nvim's working directory",
      },
    },
    opts = {
      open_for_directories = false,

      highlight_hovered_buffers_in_same_directory = false,
      yazi_floating_window_border = vim.g.neovide and "none",

      keymaps = {
        show_help = '<f1>',
      },
    },
  },
  { -- better word motion
    "chrisgrieser/nvim-spider",
    lazy = true,
    init = function()
      vim.keymap.set(
        { "n", "o", "x" },
        "w",
        "<cmd>lua require('spider').motion('w')<CR>",
        { desc = "Spider-w" }
      )
      vim.keymap.set(
        { "n", "o", "x" },
        "e",
        "<cmd>lua require('spider').motion('e')<CR>",
        { desc = "Spider-e" }
      )
      vim.keymap.set(
        { "n", "o", "x" },
        "b",
        "<cmd>lua require('spider').motion('b')<CR>",
        { desc = "Spider-b" }
      )

      -- vim.keymap.set("i", "<C-w>", "<Esc><cmd>lua require('spider').motion('b')<CR>dea")
    end,
  },
  {
    "RRethy/vim-illuminate",
    event = "BufEnter",
    config = function()
      require('illuminate').configure({
        providers = { "lsp", "treesitter" },
        delay = 250,
        under_cursor = false,
      })
    end
  },
  {
    'nanozuki/tabby.nvim',
    event = 'VimEnter',
    dependencies = 'nvim-web-devicons',
    config = function()
      vim.o.showtabline = 2
    end,
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    enabled = false,
    version = "*",
    dependencies = {
      "nvim-navic",
      "nvim-web-devicons", -- optional dependency
    },
    config = true,
    opts = {
      -- configurations go here
    },
  },
}
