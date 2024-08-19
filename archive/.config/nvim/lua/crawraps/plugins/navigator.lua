require('Navigator').setup({
    auto_save = 'current',
})

vim.keymap.set({ 'n', 't' }, '<C-M-h>', '<CMD>NavigatorLeft<CR>')
vim.keymap.set({ 'n', 't' }, '<C-M-l>', '<CMD>NavigatorRight<CR>')
vim.keymap.set({ 'n', 't' }, '<C-M-k>', '<CMD>NavigatorUp<CR>')
vim.keymap.set({ 'n', 't' }, '<C-M-j>', '<CMD>NavigatorDown<CR>')
