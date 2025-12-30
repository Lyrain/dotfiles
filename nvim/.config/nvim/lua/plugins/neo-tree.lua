
return {
    {
        'nvim-neo-tree/neo-tree.nvim',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            require('neo-tree').setup({
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                        hide_gitignored = false,
                    },
                },
                window = {
                    position = "left",
                },
            })

            local neotree_command = require('neo-tree.command')

            vim.keymap.set('n', '<leader>e', function() neotree_command.execute({ toggle = true, dir = vim.uv.cwd() }) end)
            vim.keymap.set('n', '<leader>ge', function() neotree_command.execute({ toggle = true, source = "git_status" }) end)
            vim.keymap.set('n', '<leader>be', function() neotree_command.execute({ toggle = true, source = "buffers" }) end)
        end,
    }
}
