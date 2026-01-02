-- Core plugins

return {
    {
        "airblade/vim-rooter",
    },
    {
        "tpope/vim-fugitive",
        config = function()
            vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
        end,
    },
    {
        "tpope/vim-surround",
    },
    {
        "tpope/vim-repeat",
    },
    {
        'mattn/emmet-vim',
    },
    {
        'mbbill/undotree',
        config = function()
            vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
        end,
    },
}
