-- Theme plugins

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
        lazy = false,
        config = function()
            vim.g.airline_theme = "gruvbox"
        end,
    },
}
