-- Gloabl Key Remaps
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>w", ":w<CR>") -- Quick save
vim.keymap.set("n", "<leader><leader>", "<c-^>") -- Toggle buffers
vim.keymap.set("n", "<leader>]", "<C-]>") -- Jump to tag
vim.keymap.set("n", "<leader>n", ":noh<CR>") -- Dismiss search highlight
vim.keymap.set("n", "<leader>x", "exb") -- Delete last char of word
vim.keymap.set("n", "<leader>m", ":make") -- Quick make

-- vim.keymap.set("n", "<C-p>", ":Files<CR>") -- FZF file finder
-- vim.keymap.set("n", "<leader>;", ":Buffer<CR>") -- FZF buffer selector

vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition) -- LSP Definition
vim.keymap.set("n", "<leader>r", vim.lsp.buf.references) -- LSP references
vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover) -- LSP hover

-- Base64 decode selected text in visual mode
vim.keymap.set("v", "<leader>64", 'c<c-r>=system("base64 --decode", @")<CR><ESC>')
