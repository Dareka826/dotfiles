set nocompatible

call plug#begin(stdpath('data') . '/plugged')
Plug 'junegunn/vim-plug'
"let g:polyglot_disabled = ['autoindent']
"Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mattn/emmet-vim'
Plug 'gyim/vim-boxdraw'
Plug 'baskerville/vim-sxhkdrc'
Plug 'rubixninja314/vim-mcfunction'
Plug 'ap/vim-css-color'
Plug 'ekalinin/Dockerfile.vim'
call plug#end()
command! PU PlugUpdate | PlugUpgrade

syntax on

" Make emmet's ctrl-y only work in insert mode
let g:user_emmet_mode='i'
let g:user_emmet_leader_key='<C-y>'

" Airline settings
let g:airline_theme='violet'
let g:airline_powerline_fonts=0

" fzf settings
let g:fzf_layout={'down': '30%'}

" Set the leader to a space
let mapleader=" "

" Molokai colorscheme
colorscheme molokai

set fileencodings=utf-8,sjis,euc-jp,default " Encodings EN,JP,default
set number rnu " Show number lines and set them to relative
set noerrorbells " Disable annoying error bells

" Tabs and spaces
set tabstop=4 shiftwidth=4
set softtabstop=0 noexpandtab
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

" Ctrl-P for fzf
nnoremap <C-p> :Files<CR>

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

"command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Enable gdb integration
packadd termdebug
let g:termdebug_wide=1

