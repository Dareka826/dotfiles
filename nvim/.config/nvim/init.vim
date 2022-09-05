set nocompatible

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'junegunn/vim-plug'

Plug 'neovim/nvim-lspconfig'

Plug 'L3MON4D3/LuaSnip'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'saadparwaiz1/cmp_luasnip'

Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

Plug 'itchyny/lightline.vim'
"Plug 'junegunn/fzf'
"Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
"Plug 'gyim/vim-boxdraw'
Plug 'baskerville/vim-sxhkdrc'
"Plug 'rubixninja314/vim-mcfunction'
Plug 'ap/vim-css-color'
"Plug 'ekalinin/Dockerfile.vim'
Plug 'sbdchd/neoformat'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'alx741/vinfo'
Plug 'puremourning/vimspector'
Plug 'tpope/vim-unimpaired'
"Plug 'tomasr/molokai'
Plug 'sainnhe/sonokai'
"Plug 'axvr/photon.vim'
"Plug 'Luxed/ayu-vim'
"Plug 'Dareka826/firenvim', { 'branch': 'librewolf-support', 'do': { _ -> firenvim#install(0) } }

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'
Plug 'nvim-treesitter/nvim-treesitter-textobjects'

Plug 'jamessan/vim-gnupg'
Plug 'djpohly/vim-execline'
"Plug 'tridactyl/vim-tridactyl'
Plug 'nvim-lua/plenary.nvim'
Plug 'ThePrimeagen/harpoon'
call plug#end()
command! PU PlugUpdate | PlugUpgrade

" leader
let mapleader=" "
set notimeout

" Colorscheme
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

"set background=dark
let g:sonokai_style = 'default'
"let g:sonokai_style = 'andromeda'
let g:sonokai_diagnostic_text_highlight = 1
let g:sonokai_better_performance = 1

colorscheme sonokai

" Make bg transparent
"nnoremap <leader>t :hi Normal guibg=NONE ctermbg=NONE<CR>
nnoremap <leader>t :let g:sonokai_transparent_background = 1<CR>:colorscheme sonokai<CR>

" Firenvim
if exists('g:started_by_firenvim')
    set guifont=monospace:h11
endif

" Make emmet only work in insert mode
let g:user_emmet_mode='i'
let g:user_emmet_leader_key='<c-h>'

" Lightline
let g:lightline = { 'colorscheme': 'sonokai' }

set laststatus=2
set noshowmode

" Telescope
lua <<EOF
require("telescope").setup({
    defaults = {
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
})

require('telescope').load_extension('fzf')
EOF

nnoremap <leader>T :Telescope<space>

nnoremap <leader>fb  :Telescope buffers<CR>
nnoremap <leader>fg  :Telescope git_files<CR>
nnoremap <leader>ff  :Telescope find_files<CR>
nnoremap <leader>fd  :Telescope diagnostics<CR>
nnoremap <leader>ft  :Telescope treesitter<CR>
nnoremap <leader>fk  :Telescope keymaps<CR>
nnoremap <leader>fq  :Telescope quickfix<CR>
nnoremap <leader>fll :Telescope loclist<CR>
nnoremap <leader>fh  :Telescope help_tags<CR>
nnoremap <leader>fm  :Telescope man_pages<CR>
nnoremap <leader>flr :Telescope lsp_references<CR>
nnoremap <leader>fld :Telescope lsp_definitions<CR>
nnoremap <leader>fli :Telescope lsp_implementations<CR>

nnoremap <C-p> :Telescope git_files<CR>
nnoremap <C-f> :Telescope find_files<CR>

" fzf
let g:fzf_layout={'down': '30%'}
"nnoremap <C-p> :GFiles<CR>
"nnoremap <C-f> :Files<CR>

" Signify
let g:signify_sign_change='~'
let g:signify_sign_show_count=0

nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
nmap <leader>gy :SignifyToggleHighlight<CR>

highlight SignifySignAdd    guifg=#22AA66 ctermfg=41
highlight SignifySignChange guifg=#FF6600 ctermfg=202
highlight SignifySignDelete guifg=#FF2255 ctermfg=197

" Save & quit shortcuts
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :q!<CR>
nnoremap <leader>w :w<CR>

" Make <c-o> center the line and unfold
nnoremap <c-o> <c-o>zzzv

" Make Y operate similar to D and C
nnoremap Y y$

" Make search centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Break undo sequence on these
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Run current line as a command
nnoremap <C-s> !!sh<CR>

" Git Fugitive
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gh :diffget //2<CR>
nnoremap <leader>gl :diffget //3<CR>

set fileencodings=utf-8,sjis,euc-jp,default " Encodings EN,JP,default
set number rnu " Show number lines and set them to relative
set noerrorbells " Disable annoying error bells

" Tabs and spaces
set tabstop=4 shiftwidth=4
set softtabstop=-1 expandtab
set autoindent
set list listchars=tab:>·,trail:-,nbsp:+

set showcmd " Show incomplete commands
set cursorline cc=80 " Cursor show line and color column 80
set incsearch ignorecase " Search settings
set splitbelow splitright " Split settings
set hidden " Do not abandon unloaded buffers

" Cursor shape
let &t_EI = "\<Esc>[2 q" " Non-blinking block
let &t_SI = "\<Esc>[6 q" " Non-blinking beam
let &t_SR = "\<Esc>[4 q" " Non-blinking underscore

" Disable arrow keys
inoremap <Up> <Nop>
vnoremap <Up> <Nop>
inoremap <Down> <Nop>
vnoremap <Down> <Nop>
inoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Left> <Nop>
inoremap <Right> <Nop>

" Clear highlighting after search
nnoremap <silent> <leader><space> :noh<CR>

" LSP & Autocomplete
set completeopt=menu,menuone,noselect

lua <<EOF
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_config = {
    capabilities = capabilities,
    on_attach = function()
        -- Run inside every buffer after lsp attached
        vim.keymap.set("n", "K",          vim.lsp.buf.hover,           { buffer = 0 })

        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition,      { buffer = 0 })
        vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation,  { buffer = 0 })
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references,      { buffer = 0 })
        vim.keymap.set("n", "<leader>gR", vim.lsp.buf.rename,          { buffer = 0 })
        vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { buffer = 0 })

        vim.keymap.set("n", "<leader>gs", vim.diagnostic.setqflist,    { buffer = 0 })
        vim.keymap.set("n", "<leader>gj", vim.diagnostic.goto_next,    { buffer = 0 })
        vim.keymap.set("n", "<leader>gk", vim.diagnostic.goto_prev,    { buffer = 0 })
    end,
}

require("lspconfig").clangd.setup(lsp_config)
require("lspconfig").sumneko_lua.setup(lsp_config)
-- require("lspconfig").tsserver.setup(lsp_config)

local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    mapping = {
        ["<c-n>"] = cmp.mapping(cmp.mapping.select_next_item(), {'i'}),
        ["<c-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), {'i'}),

        ["<c-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i'}),
        ["<c-f>"] = cmp.mapping(cmp.mapping.scroll_docs( 4), {'i'}),

        ["<c-space>"] = cmp.mapping(cmp.mapping.complete(), {'i'}),

        ["<c-e>"] = cmp.mapping(cmp.mapping.close(), {'i'}),
        ["<c-y>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), {'i'}),
    },
    sources = {
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path"     },
        { name = "luasnip"  },
        { name = "buffer", keyword_length = 3 },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
            })[entry.source.name]

            return vim_item
        end
    },
    experimental = {
        ghost_text = true,
    },
})
EOF

hi! link CmpItemAbbr           Fg     " Completion suggestions
hi! link CmpItemAbbrDeprecated Red    " Deprecated cmp suggestions
hi! link CmpItemAbbrMatch      Purple " Matched chars in cmp suggestions
hi! link CmpItemAbbrMatchFuzzy Purple " Matched chars in cmp suggestions
hi! link CmpItemMenu           Grey   " Source of suggestion

" Neoformat
"vnoremap <C-f> :Neoformat<CR>
"nnoremap <leader>gf :%Neoformat<CR>
"
"let g:neoformat_cpp_clangformat = {
"    \ 'exe': 'clang-format',
"    \ 'args': ['--style="{IndentWidth: 4, TabWidth: 4, UseTab: Always, IndentAccessModifiers: true}"']
"\}
"let g:neoformat_enabled_cpp = ['clangformat']
"let g:neoformat_enabled_c = ['clangformat']

" Enable gdb integration
packadd termdebug
let g:termdebug_wide=1

" Vimspector
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call vimspector#Continue()<CR>
nnoremap <leader>dl :call vimspector#StepInto()<CR>
nnoremap <leader>dj :call vimspector#StepOver()<CR>
nnoremap <leader>dk :call vimspector#StepOut()<CR>
nnoremap <leader>dr :call vimspector#Restart()<CR>
nnoremap <leader>dt :call vimspector#RunToCursor()<CR>
nnoremap <leader>db :call vimspector#ToggleBreakpoint()<CR>
nnoremap <leader>do :call vimspector#ToggleConditionalBreakpoint()<CR>
nnoremap <leader>dp :call vimspector#Pause()<CR>
nnoremap <leader>dx :call vimspector#Stop()<CR>

" H headers are for C
let g:c_syntax_for_h = 1

augroup vimrc_au
    " Clear the group
    autocmd!

    " Redo syntax
    autocmd BufRead,BufNewFile *.do set ft=sh
    " Execline syntax
    autocmd BufRead,BufNewFile *.xl set ft=execline

    " Do not use spaces for python
    autocmd BufRead,BufNewFile *.py,*.pyw set noexpandtab
augroup END

" Treesitter
lua <<EOF
require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "lua", "comment" },
    sync_install = false,
    highlight = { enable = true },
    indent    = { enable = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start     = { ["]m"] = "@function.outer" },
            goto_next_end       = { ["]M"] = "@function.outer" },
            goto_previous_start = { ["]m"] = "@function.outer" },
            goto_previous_end   = { ["]M"] = "@function.outer" },
        },
    },
})
EOF

" Folds
set foldmethod=marker

" For macros
set lazyredraw

" Neovide
set guifont=Source\ Code\ Pro
let g:neovide_cursor_vfx_mode = "pixiedust"
"let g:neovide_cursor_vfx_particle_density=25.0
let g:neovide_cursor_vfx_particle_density=50.0
let g:neovide_cursor_vfx_particle_lifetime=1

" Clear cmdline
nnoremap <leader>c :<BS>

" Open netrw
nnoremap <leader>v :Vex <bar> :vertical resize 40<CR>

" Harpoon
lua <<EOF
require("harpoon").setup({
    menu = {
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }
    }
})
EOF

nnoremap <silent> <leader>a :lua require("harpoon.mark").add_file()<CR>
nnoremap <silent> <leader>h :lua require("harpoon.ui").toggle_quick_menu()<CR>
nnoremap <silent> <leader>H :lua require("harpoon.ui").nav_file(1)<CR>
nnoremap <silent> <leader>J :lua require("harpoon.ui").nav_file(2)<CR>
nnoremap <silent> <leader>K :lua require("harpoon.ui").nav_file(3)<CR>
nnoremap <silent> <leader>L :lua require("harpoon.ui").nav_file(4)<CR>
nnoremap <silent> <leader>n :lua require("harpoon.ui").nav_file(
