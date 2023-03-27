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

lsp.ensure_installed({
    'html',
    'cssls',
    'sumneko_lua',
    'rust_analyzer',
    'elixirls',
    'gopls',
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    -- ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
})

lsp.set_preferences({
    suggest_lsp_servers = false,
})

lsp.configure('sumneko_lua', {
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
})

lsp.configure('rust_analyzer', {
    settings = {
    }
})

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
-- {
--     -- icons = {}
--     mappings = {
--         expand = { "<CR>", "<2-LeftMouse>" },
--         open = "o",
--         remove = "d",
--         edit = "e",
--         repl = "r",
--         toggle = "t",
--     },
--     layouts = {
--     {
--       elements = {
--       -- Elements can be strings or table with id and size keys.
--         { id = "scopes", size = 0.25 },
--         "breakpoints",
--         "stacks",
--         "watches",
--       },
--       size = 40, -- 40 columns
--       position = "left",
--     },
--     {
--       elements = {
--         "repl",
--         "console",
--       },
--       size = 0.25, -- 25% of total lines
--       position = "bottom",
--     },
--   },
--   controls = {
--     -- Requires Neovim nightly (or 0.8 when released)
--     enabled = true,
--     -- Display controls in this element
--     element = "repl",
--     icons = {
--       pause = "",
--       play = "",
--       step_into = "",
--       step_over = "",
--       step_out = "",
--       step_back = "",
--       run_last = "",
--       terminate = "",
--     },
--   },
--   floating = {
--     max_height = nil, -- These can be integers or a float between 0 and 1.
--     max_width = nil, -- Floats will be treated as percentage of your screen.
--     border = "single", -- Border style. Can be "single", "double" or "rounded"
--     mappings = {
--       close = { "q", "<Esc>" },
--     },
--   },
--   windows = { indent = 1 },
--   render = {
--     max_type_length = nil, -- Can be integer or nil.
--     max_value_lines = 100, -- Can be integer or nil.
--   },
-- }

metals_config.on_attach = function(client, bufnr)
    lsp_set_keymap(client, bufnr)

    dap_set_keymap()

    require('metals').setup_dap()
end

vim.diagnostic.config({
    virtual_text = true,
})

-- local nvim_lsp = require('lspconfig')

-- -- Lua
--
-- nvim_lsp.sumneko_lua.setup {
--     settings = {
--         Lua = {
--             diagnostics = {
--                 globals = { 'vim' }
--             }
--         }
--     }
-- }
--
-- -- Python
--
-- nvim_lsp.pylsp.setup {}
--
-- -- Rust
--
-- local rt = require('rust-tools')
--
-- local opts = {
--     tools = {
--         autoSetHints = true,
--         -- hover_with_actions = true,
--         inlay_hints = {
--             show_parameter_hints = true,
--             parameter_hints_prefix = "",
--             other_hints_prefix = "",
--         },
--     },
--
--     server = {
--         settings = {
--             ["rust-analyzer"] = {
--                 checkOnSave = {
--                     command = "clippy"
--                 },
--             },
--         },
--         on_attach = function(_, bufnr)
--             vim.keymap.set("n", "<C-space>",
--                 rt.hover_actions.hover_actions, { buffer = bufnr })
--
--             vim.keymap.set("n", "<Leader>a",
--                 rt.code_action_group.code_action_group, { buffer = bufnr })
--         end,
--     },
-- }
--
-- rt.setup(opts)
--
-- local cmp = require 'cmp'
--
-- cmp.setup({
--     sources = {
--         { name = 'nvim_lsp' },
--         { name = 'vsnip' },
--         { name = 'path' },
--         -- { name = 'buffer' },
--     },
--     snippet = {
--         expand = function(args)
--             vim.fn["vsnip#anonymous"](args.body)
--         end,
--     },
--     mapping =  {
--         ['<C-p>'] = cmp.mapping.select_prev_item(),
--         ['<C-n>'] = cmp.mapping.select_next_item(),
--         -- Add tab support
--         ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--         ['<Tab>'] = cmp.mapping.select_next_item(),
--         ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--         ['<C-f>'] = cmp.mapping.scroll_docs(4),
--         ['<C-Space>'] = cmp.mapping.complete(),
--         ['<C-e>'] = cmp.mapping.close(),
--         ['<CR>'] = cmp.mapping.confirm({
--           behavior = cmp.ConfirmBehavior.Insert,
--           select = true,
--         })
--     },
-- })

