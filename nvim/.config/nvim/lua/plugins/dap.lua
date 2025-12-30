-- DAP

return {
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
            "scalameta/nvim-metals",
        },
        keys = {
            { "<leader>mi", ":MetalsImportBuild<CR>", desc = "Import a metals build" },
            { "<leader>mo", ":MetalsOrganizeImports<CR>", desc = "Sort scala imports" },
            { "<leader>mn", ":MetalsNewScalaFile<CR>", desc = "Create a new scala file" },
        },
        config = function()
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

            metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

            metals_config.init_options.statusBarProvider = "on"

            local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "scala", "sbt", "java" },
                callback = function()
                    require("metals").initialize_or_attach(metals_config)
                end,
                group = nvim_metals_group,
            })

            -- DAP Setup

            local ok, dap = pcall(require, 'dap')
            if ok then
                -- local dap = require('dap')
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
            end
        end,
    },
}
