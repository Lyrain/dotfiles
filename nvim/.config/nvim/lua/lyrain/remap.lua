-- Gloabl Key Remaps
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('n', '<leader>w', ':w<CR>') -- Quick save
vim.keymap.set('n', '<leader><leader>', '<c-^>') -- Toggle buffers
vim.keymap.set('n', '<leader>]', '<C-]>') -- Jump to tag
vim.keymap.set('n', '<leader>n', ':noh<CR>') -- Dismiss search highlight
vim.keymap.set('n', '<leader>x', 'exb') -- Delete last char of word
vim.keymap.set('n', '<leader>m', ':make') -- Quick make

-- Move selected lines in visual mode, ty to theprimeagen
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'Q', '<nop>')

-- Base64 decode selected text in visual mode
vim.keymap.set('v', '<leader>64', 'c<c-r>=system("base64 --decode", @")<CR><ESC>')
