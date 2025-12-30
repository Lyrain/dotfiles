-- Metals

return {
    {
        'scalameta/nvim-metals',
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

        end,
    },
}
