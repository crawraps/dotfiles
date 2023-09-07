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
map('n', '<M-j>', '<CMD>move .+1<CR>')
map('n', '<M-k>', '<CMD>move .-2<CR>')
map('x', '<M-j>', ":move '>+1<CR>gv=gv")
map('x', '<M-k>', ":move '<-2<CR>gv=gv")

-- Buffer navigation
map('n', '<M-1>', '<CMD>lua require("bufferline").go_to_buffer(1, true)<CR>')
map('n', '<M-2>', '<CMD>lua require("bufferline").go_to_buffer(2, true)<CR>')
map('n', '<M-3>', '<CMD>lua require("bufferline").go_to_buffer(3, true)<CR>')
map('n', '<M-4>', '<CMD>lua require("bufferline").go_to_buffer(4, true)<CR>')
map('n', '<M-5>', '<CMD>lua require("bufferline").go_to_buffer(5, true)<CR>')
map('n', '<M-6>', '<CMD>lua require("bufferline").go_to_buffer(6, true)<CR>')
map('n', '<M-7>', '<CMD>lua require("bufferline").go_to_buffer(7, true)<CR>')
map('n', '<M-8>', '<CMD>lua require("bufferline").go_to_buffer(8, true)<CR>')
map('n', '<M-9>', '<CMD>lua require("bufferline").go_to_buffer(9, true)<CR>')
map('n', '<M-$>', '<CMD>lua require("bufferline").go_to_buffer(-1, true)<CR>')

map('n', '<M-h>', ':BufferLineCyclePrev<CR>')
map('n', '<M-l>', ':BufferLineCycleNext<CR>')

map('n', '<C-h>', ':BufferLineMovePrev<CR>')
map('n', '<C-l>', ':BufferLineMoveNext<CR>')

map('n', '<leader>q', ':bd<CR>')

-- Reload nvim
map('n', '<F5>', ':source $HOME/.config/nvim/init.lua<CR>')
