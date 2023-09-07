local Path = require('plenary.path')
local group = require('crawraps.autocmd')

require('session_manager').setup({
  sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),
  path_replacer = '__',
  colon_replacer = '++',
  autoload_mode = 'disabled',
  autosave_last_session = true, 
  autosave_ignore_not_normal = true,
  autosave_ignore_dirs = {'home/crawraps/.config'},
  autosave_ignore_filetypes = {
    'gitcommit',
  },
  autosave_ignore_buftypes = {},
  autosave_only_in_session = false,
  max_path_length = 80,
})

-- List available sessions
vim.keymap.set('n', "<leader>s", ':SessionManager load_session<CR>')
