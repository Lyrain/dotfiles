-- Set Essential Options

-- Line Numbers
vim.opt.number = true
vim.opt.relativenumber = true

local number_group = vim.api.nvim_create_augroup('numbertoggle',
{ clear = true })
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

-- Tab Handling
local tab_level = 4
vim.opt.tabstop = tab_level
vim.opt.softtabstop = tab_level
vim.opt.shiftwidth = tab_level
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

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.ruler = true
vim.wo.colorcolumn = "120,121"

vim.opt.updatetime = 50

vim.opt.autoread = true
vim.opt.errorbells = false

vim.opt.smartcase = true
vim.opt.cursorline = true

vim.opt.shortmess:append({ I = true, c = true })
vim.opt.completeopt = {"menu", "menuone", "preview"}
vim.opt.spelllang = "en_gb"
-- vim.opt.clipboard:append({ name = "unnamedplus" })

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
