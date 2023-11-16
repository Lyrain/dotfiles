-- init.lua

-- Set Essential Options

vim.cmd "filetype plugin indent on"
vim.cmd "syntax on"

vim.opt.number = true
vim.opt.relativenumber = true

local isNixOS = not (vim.loop.os_uname().version:find("NixOS") == nil)

-- Packages
if not isNixOS then
    vim.cmd [[packadd packer.nvim]]

    require('packer').startup(function(use)
        use 'wbthomason/packer.nvim'

        use { 'morhetz/gruvbox', as = 'gruvbox' }
        use 'vim-airline/vim-airline'
        use 'airblade/vim-rooter'

        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
        use 'nvim-treesitter/playground'

        -- Tresitter (should) replace below
        -- use 'sheerun/vim-polyglot'
        -- use 'ledger/vim-ledger'
        -- use 'epitzer/vim-rdf-turtle'

        use 'tpope/vim-fugitive'
        use 'tpope/vim-surround'
        use 'tpope/vim-repeat'

        use {
            'nvim-telescope/telescope.nvim',
            tag = '0.1.0',
            requires = { { 'nvim-lua/plenary.nvim' } }
        }

        use 'mattn/emmet-vim'

        use 'mbbill/undotree'

        -- LSP Support
        use 'neovim/nvim-lspconfig'
        use 'williamboman/mason.nvim'
        use 'williamboman/mason-lspconfig.nvim'

        -- Autocompletion
        use 'hrsh7th/nvim-cmp'
        use 'hrsh7th/cmp-buffer'
        use 'hrsh7th/cmp-path'
        use 'hrsh7th/cmp-nvim-lsp'
        use 'hrsh7th/cmp-nvim-lua'
        use 'hrsh7th/cmp-vsnip'
        use 'hrsh7th/vim-vsnip'

        use 'L3MON4D3/LuaSnip'

        use 'scalameta/nvim-metals'

        use 'mfussenegger/nvim-dap'
        use 'rcarriga/nvim-dap-ui'
    end)
end

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
vim.keymap.set("v", "<leader>64", 'c<c-r>=system("base64 --decode", @")<CR><ESC>')

-- Autocommands

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

-- Colors

function Color(color)
    color = color or "gruvbox"
    vim.cmd.colorscheme(color)
    vim.opt.background = "dark"

    --vim.cmd "highlight Normal ctermbg=NONE"
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

Color()

vim.g.airline_theme = "gruvbox"

vim.keymap.set('n', '<leader>gs', vim.cmd.Git)

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

require('telescope').setup{
    defaults = {
        mappings = {
            i = {
                ["<Esc>"] = require('telescope.actions').close
            },
        },
    },
    pickers = {
        git_files = {
            theme = "dropdown",
        },
        find_files = {
            theme = "dropdown",
        },
    },
}

treesitter_ensure_installed = function()
    if isNixOS then
        return {}
    else
        return { "javascript", "c", "lua", "elixir", "java", "scala" }
    end
end

-- if !string.find(vim.loop.os_uname().sysname, "NixOS") then
require('nvim-treesitter.configs').setup{
    ensure_installed = treesitter_ensure_installed(),
    sync_install = false,
    auto_install = not isNixOS,

    highlight = {
        enable = true,

        additional_vim_regex_highlighting = false,
    },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.live_grep, { })

vim.keymap.set('n', '<leader>tgs', builtin.git_status)
vim.keymap.set('n', '<leader>tgd', builtin.git_commits)

-- LSP

local lspconfig = require('lspconfig')
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}

        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'go', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'gR', vim.lsp.buf.rename, opts)

        -- vim.keymap.set({'n', 'x'}, 'gm', vim.lsp.buf.format({async = true}), opts)
        vim.keymap.set({'n', 'x'}, '<leader>f', vim.lsp.buf.format, opts)
        vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
    end
})

local default_setup = function(server)
    lspconfig[server].setup({
        capabilities = lsp_capabilities,
    })
end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = {
        'html',
        'cssls',
        'elixirls',
        'lua_ls',
        'gopls'
    },
    handlers = {
        default_setup,
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                    },
                    diagnostics = {
                        globals = {'vim'},
                    },
                    workspace = {
                        library = {
                            vim.env.VIMRUNTIME,
                        },
                    },
                },
            })
        end,
    },
})

local cmp = require('cmp')
cmp.setup({
    cmp_select = {
        behavior = cmp.SelectBehavior.Select
    },
    cmp_mappings = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        -- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
})

-- Metals isn't supported by Mason so use nvim-metals
-- https://github.com/williamboman/mason.nvim/issues/369
-- Using metals with lspconfig is also an issue...
-- See footnote 1 - https://github.com/scalameta/nvim-metals

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

-- DAP Setup

local dap = require('dap')
require('dapui').setup()

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

local dap_set_keymap = function()
    local dap = require('dap')
    local dapui = require('dapui')

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

    vim.keymap.set('n', '<leader>do', dapui.open)
    vim.keymap.set('n', '<leader>dc', dapui.close)

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
end

metals_config.on_attach = function(client, bufnr)
    lsp_set_keymap(client, bufnr)

    dap_set_keymap()

    require('metals').setup_dap()
end

vim.diagnostic.config({
    virtual_text = true,
})
