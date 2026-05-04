return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      animate = { enabled = true },
      lazygit = { enabled = true },
      quickfile = { enabled = true },
      indent = { enabled = true, hl = { "SnacksIndent" } },
      scope = {
        enabled = true,
        hl = { "SnacksIndentScope" },
      },
      picker = {
        enabled = false,
        win = {
          -- input window
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            }
          }
        },
        layout = {
          cycle = true,
          layout = vim.o.columns >= 120 and {
            box = "horizontal",
            width = 0.8,
            min_width = 120,
            height = 0.8,
            {
              box = "vertical",
              title = "{title} {live} {flags}",
              { box = "horizontal", height = 2, { win = "input", height = 1, border = "vpad" } },
              { win = "list" },
            },
            { win = "preview", title = "{preview}", width = 0.5 },
          } or {
            width = 0.5,
            min_width = 80,
            height = 0.8,
            min_height = 30,
            box = "vertical",
            title = "{title} {live} {flags}",
            title_pos = "center",
            { box = "horizontal", border = "hpad",     height = 2,   { win = "input", height = 1, border = "vpad" } },
            { win = "list",       border = "vpad" },
            { win = "preview",    title = "{preview}", height = 0.4, border = "vpad" },
          }
        },
      },
    },
    keys = {
      { "<A-g>", function() Snacks.lazygit.open() end, desc = "lazygit" },

      -- { "<C-p>",      function() Snacks.picker.smart() end,                desc = "Smart Find Files" },
      -- { "<leader>,",  function() Snacks.picker.buffers() end,              desc = "Buffers" },
      -- { "<leader>:",  function() Snacks.picker.command_history() end,      desc = "Command History" },
      -- -- search
      -- { "<leader>sg", function() Snacks.picker.grep() end,                 desc = "Grep" },
      -- { "<leader>sb", function() Snacks.picker.lines() end,                desc = "Buffer Lines" },
      -- { "<leader>sB", function() Snacks.picker.grep_buffers() end,         desc = "Grep Open Buffers" },
      -- { "<leader>sw", function() Snacks.picker.grep_word() end,            desc = "Visual selection or word", mode = { "n", "x" } },
      -- { "<leader>sn", function() Snacks.picker.notifications() end,        desc = "Notification History" },
      -- { "<leader>sC", function() Snacks.picker.commands() end,             desc = "Commands" },
      -- { "<leader>sd", function() Snacks.picker.diagnostics() end,          desc = "Diagnostics" },
      -- { "<leader>sD", function() Snacks.picker.diagnostics_buffer() end,   desc = "Buffer Diagnostics" },
      -- { "<leader>sh", function() Snacks.picker.help() end,                 desc = "Help Pages" },
      -- { "<leader>sH", function() Snacks.picker.highlights() end,           desc = "Highlights" },
      -- { "<leader>si", function() Snacks.picker.icons() end,                desc = "Icons" },
      -- { "<leader>sk", function() Snacks.picker.keymaps() end,              desc = "Keymaps" },
      -- { "<leader>su", function() Snacks.picker.undo() end,                 desc = "Undo History" },
      -- { "<leader>sc", function() Snacks.picker.colorschemes() end,         desc = "Colorschemes" },
      -- -- LSP
      -- { "gd",         function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition" },
      -- { "gD",         function() Snacks.picker.lsp_declarations() end,     desc = "Goto Declaration" },
      -- { "gr",         function() Snacks.picker.lsp_references() end,       desc = "References",               nowait = true },
      -- { "gI",         function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
      -- { "gy",         function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      -- { "gai",        function() Snacks.picker.lsp_incoming_calls() end,   desc = "C[a]lls Incoming" },
      -- { "gao",        function() Snacks.picker.lsp_outgoing_calls() end,   desc = "C[a]lls Outgoing" },
    },
  },
}
