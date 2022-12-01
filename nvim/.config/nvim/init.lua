-- init.lua

vim.cmd 'filetype plugin indent on'
vim.cmd 'syntax on'

-- Packages

vim.cmd 'call plug#begin("~/.vim/plugged")'

vim.cmd "Plug 'morhetz/gruvbox', { 'as': 'gruvbox' }"
vim.cmd "Plug 'vim-airline/vim-airline'"

vim.cmd "Plug 'tpope/vim-surround'"
vim.cmd "Plug 'tpope/vim-repeat'"
vim.cmd "Plug 'tpope/vim-markdown'"

vim.cmd "Plug 'airblade/vim-rooter'"
vim.cmd "Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }"
vim.cmd "Plug 'junegunn/fzf.vim'"
vim.cmd "Plug 'mattn/emmet-vim'"

vim.cmd "Plug 'sheerun/vim-polyglot'"
vim.cmd "Plug 'ledger/vim-ledger'"
vim.cmd "Plug 'epitzer/vim-rdf-turtle'"

-- Collection of common configurations for the Nvim LSP client
vim.cmd "Plug 'neovim/nvim-lspconfig'"

-- Completion framework
vim.cmd "Plug 'hrsh7th/nvim-cmp'"
vim.cmd "Plug 'hrsh7th/cmp-nvim-lsp'"
vim.cmd "Plug 'hrsh7th/cmp-path'"
vim.cmd "Plug 'hrsh7th/cmp-buffer'"
vim.cmd "Plug 'hrsh7th/cmp-vsnip'"
vim.cmd "Plug 'hrsh7th/vim-vsnip'"

-- See hrsh7th's other plugins for more completion sources!

-- To enable more of the features of rust-analyzer, such as inlay hints and more!
vim.cmd "Plug 'simrat39/rust-tools.nvim'"

-- Scala
vim.cmd "Plug 'scalameta/nvim-metals'"
vim.cmd "Plug 'nvim-lua/plenary.nvim'"
vim.cmd "Plug 'mfussenegger/nvim-dap'"

vim.cmd 'call plug#end()'

-- Essential Options

vim.g.mapleader = " "
vim.opt.autoread = true
vim.opt.errorbells = false
local tab_level = 4
vim.opt.tabstop = tab_level
vim.opt.softtabstop = tab_level
vim.opt.shiftwidth = tab_level
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.wrapscan = true
vim.opt.smartcase = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = "/tmp/undodir"
vim.opt.incsearch = true
vim.opt.cursorline = true
vim.opt.ruler = true
vim.opt.shortmess:append({ I = true, c = true })
vim.opt.signcolumn = "yes"
vim.opt.completeopt = {"menu", "menuone", "preview"}
vim.opt.spelllang = "en_gb"
-- vim.opt.clipboard:append({ name = "unnamedplus" })
vim.wo.colorcolumn = "120,121"

-- View tab
vim.opt.list = true
vim.opt.listchars = {
    eol = '¬',
    tab = '>-',
    trail = '~',
    extends = '>',
    precedes = '<',
}

-- Theme

vim.cmd 'colorscheme gruvbox'
vim.opt.background = 'dark'
vim.cmd 'highlight Normal ctermbg=NONE'

vim.g.airline_theme = 'gruvbox'

vim.env.FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

vim.opt.number = true
vim.opt.relativenumber = true

-- Keybindings

vim.keymap.set('n', '<Leader>w', ':w<CR>') -- Quick save
vim.keymap.set('n', '<Leader><Leader>', '<c-^>') -- Toggle buffers
vim.keymap.set('n', '<Leader>]', '<C-]>') -- Jump to tag
vim.keymap.set('n', '<Leader>n', ':noh<CR>') -- Dismiss search highlight
vim.keymap.set('n', '<Leader>x', 'exb') -- Delete last char of word
vim.keymap.set('n', '<Leader>m', ':make') -- Quick make
vim.keymap.set('n', '<Leader>p', ':Files<CR>') -- FZF file finder
vim.keymap.set('n', '<Leader>;', ':Buffer<CR>') -- FZF buffer selector

vim.keymap.set('n', '<Leader>gd', vim.lsp.buf.definition) -- LSP Definition
vim.keymap.set('n', '<Leader>r', vim.lsp.buf.references) -- LSP references
vim.keymap.set('n', '<Leader>h', vim.lsp.buf.hover) -- LSP hover

-- Base64 decode selected text in visual mode
vim.keymap.set('v', '<Leader>64',
'c<c-r>=system("base64 --decode", @")<CR><ESC>')

-- Line Numbers

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

-- Trailing Whitespace

vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*',
    desc = "Trim whitespace from the end of the line for all filetypes",
    callback = function()
        vim.cmd ':%s/\\s\\+$//e'
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

-- LSP

local nvim_lsp = require('lspconfig')
local rt = require('rust-tools')

local opts = {
    tools = {
        autoSetHints = true,
        -- hover_with_actions = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    server = {
        settings = {
            ["rust-analyzer"] = {
                checkOnSave = {
                    command = "clippy"
                },
            },
        },
        on_attach = function(_, bufnr)
            vim.keymap.set("n", "<C-space>",
                rt.hover_actions.hover_actions, { buffer = bufnr })

            vim.keymap.set("n", "<Leader>a",
                rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
    },
}

rt.setup(opts)

local metals_config = require("metals").bare_config()

metals_config.settings = {
    showImplicitArguments = true,
    excludedPackages = {
        "akka.actor.typed.javadsl",
        "com.github.swagger.akka.javadsl",
    },
}

-- metals_config.init_options.statusBarProvider = "on"

local dap = require("dap")

dap.configurations.scala = {
    {
        type = "scala",
        request = "launch",
        name = "RunOrTest",
        metals = {
            runType = "runOrTestFile"
        },
    },
    {
        type = "scala",
        request = "launch",
        name = "Test Target",
        metals = {
            runType = "testTarget"
        },
    },
}

metals_config.on_attach = function(client, bufnr)
    require("metals").setup_dap()
end

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "scala", "sbt", "java" },
    callback = function()
        require("metals").initialize_or_attach(metals_config)
    end,
    group = nvim_metals_group,
})

local cmp = require 'cmp'

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
        { name = 'path' },
        -- { name = 'buffer' },
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping =  {
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Add tab support
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.close(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        })
    },
})
