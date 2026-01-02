local live_grep_opts = {
    additional_args = {
        "--hidden",
    },
}

return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = {
            "nvim-lua/plenary.nvim"
        },
        keys = {
            { '<leader>pf',  function() require("telescope.builtin").find_files() end, desc = "Fuzzy find files" },
            { '<C-p>',       function() require("telescope.builtin").git_files() end, desc = "Fuzzy find files in the git index" },
            { '<leader>ps',  function() require("telescope.builtin").live_grep(live_grep_opts) end, desc = "Grep file content" },
            { '<leader>tgs', function() require("telescope.builtin").git_status() end, desc = "Fuzzy find on git status" },
            { '<leader>tgd', function() require("telescope.builtin").git_commits() end, desc = "Fuzzy find on git commits" },
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
            }
        end,
    },
}
