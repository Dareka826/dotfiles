vim.cmd("packadd packer.nvim")

return require("packer").startup(function()
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    -- Colorscheme
    use('sainnhe/sonokai')
    use('arzg/vim-colors-xcode')
    use('folke/tokyonight.nvim')

    -- Treesitter
    use('nvim-treesitter/nvim-treesitter', {
        run = ':TSUpdate'
    })
    use('nvim-treesitter/playground')
    use('nvim-treesitter/nvim-treesitter-textobjects')

    -- LSP / Completion
    use({
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
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    })

    -- Lua common
    use('nvim-lua/plenary.nvim')
    use('nvim-lua/popup.nvim')

    -- Telescope
    use({
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    })
    use('nvim-telescope/telescope-fzf-native.nvim', {
        run = "make"
    })

    -- Line indents
    use('lukas-reineke/indent-blankline.nvim')

    -- Undotree
    use('mbbill/undotree')

    -- VimWiki
    use('vimwiki/vimwiki')

    -- Harpoon
    use('ThePrimeagen/harpoon')

    -- Show colors
    use('norcalli/nvim-colorizer.lua')

    -- Additional syntax
    use('baskerville/vim-sxhkdrc')
    use('djpohly/vim-execline')
    use('tridactyl/vim-tridactyl')
    use('Dareka826/vim-sixel-syntax')
    use('kmonad/kmonad-vim')

    -- Git
    use('mhinz/vim-signify')
    use('tpope/vim-fugitive')
    use('junegunn/gv.vim')
    use('TimUntersberger/neogit')

    -- DAP
    use('mfussenegger/nvim-dap')
    use('rcarriga/nvim-dap-ui')
    use('theHamsta/nvim-dap-virtual-text')

    -- Statusline
    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    })

    -- Twilight
    use('folke/twilight.nvim')

end)
