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
-- vim.keymap.set('n', '<leader>ps', function()
--     builtin.grep_string({ search = vim.fn.input("Grep > ") })
-- end)
vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
