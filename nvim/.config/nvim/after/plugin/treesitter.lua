require('nvim-treesitter.configs').setup{
    ensure_installed = { "help", "javascript", "c", "lua", "rust", "java", "scala", "elixir", "hcl" },

    sync_install = false,

    auto_install = true,

    highlight = {
        enable = true,

        additional_vim_regex_highlighting = false,
    },
}
