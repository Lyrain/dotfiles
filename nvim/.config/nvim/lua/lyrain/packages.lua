-- Packages
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    use { 'morhetz/gruvbox', as = 'gruvbox' }
    use 'vim-airline/vim-airline'
    use 'airblade/vim-rooter'

    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- Tresitter (should) replace below
    -- use 'sheerun/vim-polyglot'
    -- use 'ledger/vim-ledger'
    -- use 'epitzer/vim-rdf-turtle'

    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-repeat'

    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.0',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use 'mattn/emmet-vim'

    use 'mbbill/undotree'

    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},
            {'hrsh7th/cmp-vsnip'},
            {'hrsh7th/vim-vsnip'},

            {'L3MON4D3/LuaSnip'},
        }
    }

    use 'scalameta/nvim-metals'

    use 'mfussenegger/nvim-dap'
    use 'rcarriga/nvim-dap-ui'

    -- To enable more of the features of rust-analyzer, such as inlay hints and more!
    -- use 'simrat39/rust-tools.nvim'
end)

