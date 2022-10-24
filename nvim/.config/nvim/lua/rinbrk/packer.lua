vim.cmd("packadd packer.nvim")

return require("packer").startup(function()
    -- Packer can manage itself
    use('wbthomason/packer.nvim')

    -- Lua common
    use('nvim-lua/plenary.nvim')
    use('nvim-lua/popup.nvim')

    -- Telescope
    use('nvim-telescope/telescope.nvim')
    use('nvim-telescope/telescope-fzf-native.nvim', {
        run = "make"
    })

    -- Completion + Snippets + LSP
    use('neovim/nvim-lspconfig')

    use('hrsh7th/nvim-cmp')
    use('hrsh7th/cmp-buffer')
    use('hrsh7th/cmp-path')
    use('hrsh7th/cmp-nvim-lua')
    use('hrsh7th/cmp-nvim-lsp')

    use('L3MON4D3/LuaSnip')
    use('saadparwaiz1/cmp_luasnip')

    -- Line indents
    use('lukas-reineke/indent-blankline.nvim')

    -- Undotree
    use('mbbill/undotree')

    -- VimWiki
    use('vimwiki/vimwiki')

    -- Treesitter
    use('nvim-treesitter/nvim-treesitter', {
        run = ":TSUpdate"
    })
    use('nvim-treesitter/playground')
    use('nvim-treesitter/nvim-treesitter-textobjects')

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

    -- Colorscheme
    use('sainnhe/sonokai')
    use('arzg/vim-colors-xcode')
    use('folke/tokyonight.nvim')

    -- Statusline
    use({
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    })

end)
