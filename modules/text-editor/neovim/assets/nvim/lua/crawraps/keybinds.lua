local function map(m, k, v)
  vim.keymap.set(m, k, v, { silent = true })
end

-- Fix * (Keep the cursor position, don't move to next match)
map('n', '*', '*N')

-- Mimic shell movements
map('i', '<C-E>', '<C-o>$')
map('i', '<C-A>', '<C-o>^')

-- Move to the next/previous buffer
-- map('n', '<leader>[', '<CMD>bp<CR>')
-- map('n', '<leader>]', '<CMD>bn<CR>')

-- Move to last buffer
-- map('n', "''", '<CMD>b#<CR>')

-- Copying the vscode behaviour of making tab splits
map('n', '<C-\\>', '<CMD>vsplit<CR>')
map('n', '<A-\\>', '<CMD>split<CR>')

-- Move line up and down in NORMAL and VISUAL modes
-- Reference: https://vim.fandom.com/wiki/Moving_lines_up_or_down
map('n', '<C-j>', '<CMD>move .+1<CR>')
map('n', '<C-k>', '<CMD>move .-2<CR>')
map('x', '<C-j>', ":move '>+1<CR>gv=gv")
map('x', '<C-k>', ":move '<-2<CR>gv=gv")

-- Buffer navigation
-- Move to previous/next
map('n', '<A-h>', '<Cmd>BufferPrevious<CR>')
map('n', '<A-l>', '<Cmd>BufferNext<CR>')
-- Re-order to previous/next
map('n', '<C-h>', '<Cmd>BufferMovePrevious<CR>')
map('n', '<C-l>', '<Cmd>BufferMoveNext<CR>')
-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>')
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>')
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>')
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>')
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>')
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>')
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>')
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>')
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>')
map('n', '<A-0>', '<Cmd>BufferLast<CR>')
-- Hop to buffer
map('n', 'L', '<Cmd>BufferPick<CR>')
-- Close buffer
map('n', '<leader>q', '<Cmd>BufferClose<CR>')

-- Reload nvim
map('n', '<F5>', ':source $HOME/.config/nvim/init.lua<CR>')

-- neovide
if vim.g.neovide then
  vim.keymap.set({ "n", "v" }, "+", "<Cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "-", "<Cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  vim.keymap.set({ "n", "v" }, "=", "<Cmd>lua vim.g.neovide_scale_factor = 1<CR>")
end
