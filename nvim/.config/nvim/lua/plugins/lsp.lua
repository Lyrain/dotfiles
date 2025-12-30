-- Autocompletion

return {
    {
        "neovim/nvim-lspconfig",

        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },

        config = function()
            -- LSP

            -- local lspconfig = require('lspconfig')
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


            local isNixOS = not (vim.loop.os_uname().version:find("NixOS") == nil)

            local mason_ensure_installed = function()
                if isNixOS then
                    return {}
                else
                    return {
                        'html',
                        'cssls',
                        'lua_ls',
                        'gopls',
                        'ccls'
                    }
                end
            end

            require('mason').setup({})
            require('mason-lspconfig').setup({
                automatic_enable = mason_ensure_installed(),
            })

            vim.lsp.config("ccls", {})

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        runtime = {
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            globals = {
                                'vim',
                                'require',
                            },
                        },
                        workspace = {
                            library = vim.api.nvim_get_runtime_file("", true),
                        },
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            })

            local luasnip = require('luasnip')

            vim.keymap.set({ "i" }, "<C-K>", function() luasnip.expand() end, { silent = true })

            require("luasnip.loaders.from_snipmate").lazy_load()

            local cmp = require('cmp')
            cmp.setup({
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }),
            })

            cmp.setup.cmdline({'/', '?'}, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' },
                }
            })
        end,
    },
}
