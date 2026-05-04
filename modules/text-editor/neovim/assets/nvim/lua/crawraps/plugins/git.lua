return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead",
    opts = {
      signs = {
        add = { text = '▏' },
        change = { text = '▏' },
        changedelete = { text = '=' },
        untracked = { text = '' },
      },
      on_attach = function(buf)
        local map = vim.keymap.set
        local gs = package.loaded.gitsigns
        local opts = { buffer = buf, expr = true, replace_keycodes = false }

        -- Navigation
        map('n', ']c', "&diff ? ']c' : '<CMD>Gitsigns next_hunk<CR>'", opts)
        map('n', '[c', "&diff ? '[c' : '<CMD>Gitsigns prev_hunk<CR>'", opts)

        -- Actions
        map({ 'n', 'v' }, '<leader>hr', gs.reset_hunk, { buffer = buf })
        map({ 'n', 'v' }, '<leader>hs', gs.stage_hunk)
        map('n', '<leader>hS', gs.stage_buffer, { buffer = buf })
        map('n', '<leader>hp', gs.preview_hunk, { buffer = buf })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { buffer = buf })
      end,
    },
  },
  {
    "rhysd/git-messenger.vim",
    event = "BufRead",
    init = function()
      vim.g.git_messenger_no_default_mappings = true
      vim.keymap.set('n', 'gm', '<CMD>GitMessenger<CR>')
    end,
  }
}
