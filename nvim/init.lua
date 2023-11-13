-- init.lua

vim.cmd "filetype plugin indent on"
vim.cmd "syntax on"

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
vim.opt.completeopt = {"menu", "menuone", "preview"}
vim.opt.spelllang = "en_gb"
-- vim.opt.clipboard:append({ name = "unnamedplus" })

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Gloabl Key Remaps

vim.g.mapleader = " "

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('n', '<leader>w', ':w<CR>')       -- Quick save
vim.keymap.set('n', '<leader><leader>', '<c-^>') -- Toggle buffers
vim.keymap.set('n', '<leader>]', '<C-]>')        -- Jump to tag
vim.keymap.set('n', '<leader>n', ':noh<CR>')     -- Dismiss search highlight
vim.keymap.set('n', '<leader>x', 'exb')          -- Delete last char of word
vim.keymap.set('n', '<leader>m', ':make')        -- Quick make

-- Move selected lines in visual mode, ty to theprimeagen
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'Q', '<nop>')

-- Base64 decode selected text in visual mode
vim.keymap.set('v', '<leader>64', 'c<c-r>=system("base64 --decode", @")<CR><ESC>')

-- Trailing Whitespace

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    desc = "Trim whitespace from the end of the line for all filetypes",
    command = [[%s/\s\+$//e]],
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
    pattern = {'javascript', 'typescript'},
    desc = "Set indent to 2 spaces for JavaScript & TypeScript",
    callback = function()
        vim.opt.tabstop = 2
    end,
})

-- Markdown

local markdown_group = vim.api.nvim_create_augroup('markdownGroup',
{ clear = true })

vim.api.nvim_create_autocmd({'BufRead', 'BufNewFile'},
{
    pattern = '*.Rmd',
    group = markdown_group,
    desc = "RMarkdown files should use the markdown filetype",
    callback = function()
        vim.opt.filetype = "markdown"
    end,
})

local enable_spell = function()
    vim.opt.spell = true
end

vim.api.nvim_create_autocmd('FileType',
{
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


-- Plugin Config

-- Theme
function Color(color)
    color = color or "gruvbox"
    vim.cmd.colorscheme(color)
    vim.opt.background = "dark"

    --vim.cmd "highlight Normal ctermbg=NONE"
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

Color()

-- Airline
vim.g.airline_theme = "gruvbox"

-- Fugitive
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

-- Undotree
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

-- Telescope
require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<Esc>"] = require('telescope.actions').close
            },
        },
    },
    pickers = {
        find_files = {
            -- theme = "dropdown",
        },
    },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})

vim.keymap.set('n', '<leader>tgs', builtin.git_status)
vim.keymap.set('n', '<leader>tgd', builtin.git_commits)

-- Treesitter
require('nvim-treesitter.configs').setup{
    sync_install = false,
    auto_install = false,

    highlight = {
        enable = true,

        additional_vim_regex_highlighting = false,
    },
}

-- LSP

local lsp = require('lsp-zero')
local lsp_set_keymap = function(_client, bufnr)
    local opts = {buffer = bufnr, remap = false}

    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
end

local dap_set_keymap = function()
    local dap = require('dap')

    vim.keymap.set('n', '<F5>', dap.continue)
    vim.keymap.set('n', '<F10>', dap.step_over)
    vim.keymap.set('n', '<F11>', dap.step_into)
    vim.keymap.set('n', '<F12>', dap.step_out)
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
    vim.keymap.set('n', '<leader>B', function()
        dap.set_breakpoint(vim.fn.input('Breakpoint condition > '))
    end)
    vim.keymap.set('n', '<leader>lp', function()
        dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
    end)
    vim.keymap.set('n', '<leader>dr', dap.repl.open)
end

lsp.preset('recommended')

-- lsp.ensure_installed({
--     'html',
--     'cssls',
--     'lua_ls',
--     'rust_analyzer',
--     'elixirls',
--     'gopls',
--     'rnix',
-- })

local cmp = require('cmp')
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    -- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        { name = 'buffer' },
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
})

lsp.set_preferences({
    suggest_lsp_servers = false,
})

lsp.configure('lua_ls', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
})

-- lsp.configure('rust_analyzer', {
--     settings = {
--     }
-- })

lsp.on_attach(function()
    lsp_set_keymap()

    dap_set_keymap()
end)

lsp.setup()

-- Metals isn't supported by Mason so use nvim-metals
-- https://github.com/williamboman/mason.nvim/issues/369

local metals_config = require("metals").bare_config()

metals_config.settings = {
    showImplicitArguments = true,
    excludedPackages = {
        "akka.actor.typed.javadsl",
        "com.github.swagger.akka.javadsl",
    },
}

-- metals_config.init_options.statusBarProvider = "on"

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function()
        require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})

-- Debugger

local dap = require('dap')

dap.configurations.scala = {
    {
        type = 'scala',
        request = 'launch',
        name = 'RunOrTest',
        metals = {
            runType = 'runOrTestFile'
        },
    },
    {
        type = 'scala',
        request = 'launch',
        name = 'Test Target',
        metals = {
            runType = 'testTarget'
        },
    },
}

require('dapui').setup()

metals_config.on_attach = function(client, bufnr)
    lsp_set_keymap(client, bufnr)

    dap_set_keymap()

    require('metals').setup_dap()
end

vim.diagnostic.config({
    virtual_text = true,
})
