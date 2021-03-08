set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'mattn/emmet-vim'
Plugin 'gyim/vim-boxdraw'
Plugin 'baskerville/vim-sxhkdrc'
Plugin 'ap/vim-css-color'
Plugin 'ekalinin/Dockerfile.vim'

call vundle#end()
filetype plugin on

syntax on

" YCM configuration
let g:ycm_confirm_extra_conf='false'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf=0
let g:ycm_autoclose_preview_window_after_completion=1

" Make emmet's ctrl-y only work in insert mode
let g:user_emmet_mode='i'
let g:user_emmet_leader_key='<C-y>'

" Airline settings
let g:airline_theme='violet'
let g:airline_powerline_fonts = 0

let g:fzf_layout={'down': '30%'}

let mapleader=" "

colorscheme molokai

set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,default
set number rnu
set autoindent
set incsearch
set noerrorbells
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set showcmd
set cursorline
set cc=80
set ignorecase
set splitbelow splitright

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

