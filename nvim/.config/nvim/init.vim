set nocompatible

" Install vim-plug if not found
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')
Plug 'junegunn/vim-plug'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'gyim/vim-boxdraw'
"Plug 'baskerville/vim-sxhkdrc'
"Plug 'rubixninja314/vim-mcfunction'
Plug 'ap/vim-css-color'
"Plug 'ekalinin/Dockerfile.vim'
Plug 'sbdchd/neoformat'
Plug 'mhinz/vim-signify'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'preservim/nerdtree'
Plug 'alx741/vinfo'
Plug 'puremourning/vimspector'
Plug 'tpope/vim-unimpaired'
Plug 'tomasr/molokai'
Plug 'axvr/photon.vim'
Plug 'Luxed/ayu-vim'
Plug 'Dareka826/firenvim', { 'branch': 'librewolf-support', 'do': { _ -> firenvim#install(0) } }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()
command! PU PlugUpdate | PlugUpgrade

" Colorscheme
"colorscheme photon
"colorscheme molokai
set termguicolors
set background=dark
let g:ayucolor = "mirage"
colorscheme ayu

" Firenvim
if exists('g:started_by_firenvim')
    set guifont=monospace:h11
endif

" Make emmet's ctrl-y only work in insert mode
let g:user_emmet_mode='i'
let g:user_emmet_leader_key='<C-y>'

" Lightline
let g:lightline = {
    \ 'colorscheme': 'deus',
    \ 'active': {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
        \ 'gitbranch': 'FugitiveHead',
        \ 'cocstatus': 'LightLineCoc'
    \ },
    \ }

set laststatus=2
set noshowmode

function! LightLineCoc()
    if empty(get(g:, 'coc_status', '')) && empty(get(b:, 'coc_diagnostic_info', {}))
        return ''
    endif
    return trim(coc#status())
endfunction

" fzf
let g:fzf_layout={'down': '30%'}
nnoremap <C-p> :Files<CR>

" leader
let mapleader=" "
set notimeout

" Signify
let g:signify_sign_change='~'
let g:signify_sign_show_count=0

nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
nmap <leader>gy :SignifyToggleHighlight<CR>

highlight SignifySignAdd    guifg=#22AA66 ctermfg=41
highlight SignifySignChange guifg=#FF6600 ctermfg=202
highlight SignifySignDelete guifg=#FF2255 ctermfg=197

" Make bg transparent
nnoremap <leader>h :hi Normal guibg=NONE ctermbg=NONE<CR>

" Save & quit shortcuts
nnoremap <leader>q :q!<CR>
nnoremap <leader>Q :qa!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>W :wqa!<CR>

" Make <c-o> center the line and unfold
nnoremap <c-o> <c-o>zzzv

" Make Y operate similar to D and C
nnoremap Y y$

" Make search centered
nnoremap n nzzzv
nnoremap N Nzzzv

" Don't move cursor when joining lines
nnoremap J mzJ`z
nnoremap gJ mzgJ`z

" Break undo sequence on these
inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u

" Moving text around
nnoremap <leader>j :m .+1<CR>==
nnoremap <leader>k :m .-2<CR>==
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '>-2<CR>gv=gv

" Run current line as a command
nnoremap <C-s> !!sh<CR>

" Git Fugitive
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gh :diffget //2<CR>
nnoremap <leader>gl :diffget //3<CR>

" Nerdtree
nnoremap <leader>gt :NERDTreeToggle<CR>

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
nnoremap <leader><space> :noh<CR>

" Coc use TAB to move in the popup menu
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Coc bindings
nmap <silent> <leader>gd <Plug>(coc-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)

nmap <silent> <leader>gd :CocList diagnostics<CR>
nmap <silent> <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>g] <Plug>(coc-diagnostic-next)

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

    " Do not use spaces for python
    autocmd BufRead,BufNewFile *.py,*.pyw set noexpandtab
augroup END

" Treesitter
lua <<EOF
require('nvim-treesitter.configs').setup({
    ensure_installed = { "c" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    indent = { enable = true }
})
EOF

" Folds
set foldmethod=marker
