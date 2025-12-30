return {
    {
        "nvim-telescope/telescope.nvim",

        tag = "0.1.5",

        dependencies = {
            "nvim-lua/plenary.nvim"
        },

        config = function()
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

            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
            vim.keymap.set('n', '<C-p>', builtin.git_files, {})
            vim.keymap.set('n', '<leader>ps', builtin.live_grep, { })

            vim.keymap.set('n', '<leader>tgs', builtin.git_status)
            vim.keymap.set('n', '<leader>tgd', builtin.git_commits)
        end,
    },
}
