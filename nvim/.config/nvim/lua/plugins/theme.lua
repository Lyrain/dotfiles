return {
    {
        "morhetz/gruvbox",
        lazy = false,
        priority = 1000,
        config = function()
            color = color or "gruvbox"
            vim.cmd.colorscheme(color)
            vim.opt.background = "dark"

            --vim.cmd "highlight Normal ctermbg=NONE"
            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end,
    },
    {
        "vim-airline/vim-airline",
        config = function()
            vim.g.airline_theme = "gruvbox"
        end,
    },
    {
        "airblade/vim-rooter",
    },
    {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    },
    {
        "nvim-treesitter/playground",
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
