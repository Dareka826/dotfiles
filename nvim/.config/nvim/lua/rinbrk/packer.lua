vim.cmd("packadd packer.nvim")

return require("packer").startup(function()
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    -- Colorschemes
    --use('tomasr/molokai')
    use('sainnhe/sonokai')
    use('axvr/photon.vim')
    --use('Luxed/ayu-vim')
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

            -- LSP Progress
            {'j-hui/fidget.nvim'},
        }
    })

    -- Telescope
    use({
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    })
    use({
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    })

    -- Statusline
    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    })

    -- Line indents
    use('lukas-reineke/indent-blankline.nvim')

    -- Undotree
    use('mbbill/undotree')

    -- VimWiki
    use('vimwiki/vimwiki')

    -- Harpoon
    use({
        'ThePrimeagen/harpoon',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-lua/popup.nvim' },
        }
    })

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

    -- Info pages
    use('alx741/vinfo')

    -- Useful short binds
    use('tpope/vim-unimpaired')

    -- DAP
    use('mfussenegger/nvim-dap')
    use('rcarriga/nvim-dap-ui')
    use('theHamsta/nvim-dap-virtual-text')

    -- Twilight
    use('folke/twilight.nvim')

    use('mattn/emmet-vim')
--use('baskerville/vim-sxhkdrc')
--use('rubixninja314/vim-mcfunction')
--use('ekalinin/Dockerfile.vim')
--use('sbdchd/neoformat')
--use('puremourning/vimspector')

--use('tridactyl/vim-tridactyl')

end)
