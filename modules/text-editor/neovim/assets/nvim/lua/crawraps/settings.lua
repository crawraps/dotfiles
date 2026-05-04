local g = vim.g
local o = vim.o

-- silence deprecation warning
vim.deprecate = function() end

-- cmd('syntax on')
-- vim.api.nvim_command('filetype plugin indent on')

o.termguicolors = true
o.background = 'dark'

-- Do not save when switching buffers
-- o.hidden = true

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 5

-- Better editor UI
o.number = true
o.numberwidth = 3
o.relativenumber = false
o.signcolumn = 'yes:2'
o.cursorline = true
o.cursorlineopt = 'number'

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.cindent = true
-- o.autoindent = true
o.wrap = true
o.textwidth = 300
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = true
o.listchars = 'trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂'
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = 'unnamedplus'

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Hide commandline
o.cmdheight = 0

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'
-- o.undodir = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
o.jumpoptions = 'view'

-- WARN: this won't update the search count after pressing `n` or `N`
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- o.lazyredraw = true

-- Better folds (don't fold by default)
-- o.foldmethod = 'indent'
-- o.foldlevelstart = 99
-- o.foldnestmax = 3
-- o.foldminlines = 1

--
g.skip_ts_context_commentstring_module = true

-- Map <leader> to space
g.mapleader = ' '
g.maplocalleader = ' '

-- Neovide settings
if vim.g.neovide then
  o.guifont = "Kode Mono,Symbols Nerd Font:h12"

  g.neovide_opacity = 0.5
  g.neovide_normal_opacity = 0.5
  g.neovide_background = "bg_color"
  g.neovide_hide_mouse_when_typing = true
  g.neovide_padding_top = 16
  g.neovide_cursor_trail_size = 0.2
  g.neovide_cursor_animate_command_line = false
  g.neovide_floating_corner_radius = 0.4

  g.neovide_floating_blur_amount_x = 10.0
  g.neovide_floating_blur_amount_y = 10.0

  g.neovide_floating_shadow = false
end

vim.opt.linespace = -2
o.shortmess = o.shortmess .. 'sWIc'
