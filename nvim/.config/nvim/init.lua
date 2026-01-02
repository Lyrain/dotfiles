-- init.lua

-- TODO: Consider changing test here to `stat /nix/store`, if that fails then the os is 100% NOT nix
-- The benefit: Would allow for use of nix the package manager on Darwin,
local isNixOS = not (vim.loop.os_uname().version:find("NixOS") == nil)

-- Packages
require("config.lazy")

-- Line Numbers

local number_group = vim.api.nvim_create_augroup('numbertoggle', { clear = true })

vim.api.nvim_create_autocmd(
{'BufEnter', 'FocusGained', 'InsertLeave', 'WinEnter'},
{
    pattern = '*',
    group = number_group,
    desc = "Enable relative number in active non-insert window",
    callback = function()
        vim.opt.relativenumber = true
    end,
})

vim.api.nvim_create_autocmd(
{'BufLeave', 'FocusLost', 'InsertEnter', 'WinLeave'},
{
    pattern = '*',
    group = number_group,
    desc = "Disable relative number for inactive window & insert mode",
    callback = function()
        vim.opt.relativenumber = false
    end,
})

-- Tabs

local tab_level = function(size)
    vim.opt.tabstop = size
    vim.opt.softtabstop = size
    vim.opt.shiftwidth = size
    vim.opt.expandtab = true
end

vim.opt.tabstop = tab_level(4)
vim.opt.softtabstop = tab_level(4)
vim.opt.shiftwidth = tab_level(4)
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.list = true
vim.opt.listchars = {
    eol = '¬',
    tab = '>-',
    trail = '~',
    extends = '>',
    precedes = '<',
}

vim.opt.wrap = false
vim.opt.wrapscan = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

--vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"

vim.opt.ruler = true
vim.wo.colorcolumn = "120,121"

vim.opt.updatetime = 50

vim.opt.autoread = true
vim.opt.errorbells = false

vim.opt.smartcase = true
vim.opt.cursorline = true

vim.opt.shortmess:append({ I = true, c = true })
vim.opt.completeopt = {"menuone", "noinsert", "preview"}
vim.opt.spelllang = "en_gb"
-- vim.opt.clipboard:append({ name = "unnamedplus" })

vim.opt.modeline = true

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

vim.diagnostic.config({
    virtual_text = true,
})

-- Gloabl Key Remaps
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('n', '<leader>w', ':w<CR>') -- Quick save
vim.keymap.set('n', '<leader>q', ':q<CR>') -- Quick save
vim.keymap.set('n', '<leader><leader>', '<c-^>') -- Toggle buffers
vim.keymap.set('n', '<leader>]', '<C-]>') -- Jump to tag
vim.keymap.set('n', '<leader>n', ':noh<CR>') -- Dismiss search highlight
vim.keymap.set('n', '<leader>x', 'exb') -- Delete last char of word
vim.keymap.set('n', '<leader>mm', ':make<CR>') -- Quick make

-- Move selected lines in visual mode, ty to theprimeagen
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'Q', '<nop>')

-- Base64 decode selected text in visual mode
vim.keymap.set("v", "<leader>e64", 'c<c-r>=system("base64", @")<CR><ESC>')
vim.keymap.set("v", "<leader>b64", 'c<c-r>=system("base64 --decode", @")<CR><ESC>')

-- Autocommands

-- Trailing Whitespace

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    desc = "Trim whitespace from the end of the line for all filetypes",
    callback = function()
        -- Except yaml, don't do this for yaml.
        if (vim.bo.filetype == "yaml") then
            return
        end

        vim.cmd([[%s/\s\+$//e]])
    end,
})

-- File Types

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'make', 'go'},
    desc = "Makefiles & Go files require actual tab characters.",
    callback = function()
        vim.opt.expandtab = false
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'javascript', 'typescript', 'nix'},
    desc = "Set indent to 2 spaces for Specific file types",
    callback = function()
        tab_level(2)
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'lua', 'c', 'cpp'},
    desc = "Set indent to 4 spaces for lua, C & C++",
    callback = function()
        tab_level(4)
    end,
})

-- Markdown

local markdown_group = vim.api.nvim_create_augroup('markdownGroup',
{ clear = true })

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'}, {
    pattern = '*.Rmd',
    group = markdown_group,
    desc = "RMarkdown files should use the markdown filetype",
    callback = function()
        vim.bo.filetype = "markdown"
    end,
})

local enable_spell = function()
    vim.opt.spell = true
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'markdown',
    group = markdown_group,
    desc = "Markdown files should have spell enabled",
    callback = enable_spell,
})

-- TODO: iabbr

-- LaTex & Tex

vim.g.tex_flavor = "latex"
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'tex',
    desc = "LaTex and Tex files should have spell enabled",
    callback = enable_spell,
})

