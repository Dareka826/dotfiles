set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'baskerville/vim-sxhkdrc'
"Plugin 'mzlogin/vim-smali'
"Plugin 'rubixninja314/vim-mcfunction'
Plugin 'ap/vim-css-color'

call vundle#end()
filetype plugin on

syntax on

let g:ycm_confirm_extra_conf='false'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
let g:ycm_confirm_extra_conf = 0

let mapleader=" "

" colorscheme inkpot
colorscheme molokai
"highlight Normal ctermbg=NONE
"highlight LineNr ctermbg=NONE

"set t_Co=256
let g:airline_theme='violet'
let g:airline_powerline_fonts = 0

set encoding=utf-8
set fileencodings=utf-8,sjis,euc-jp,default
set number rnu
set autoindent
set noerrorbells
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set showcmd
set cursorline
set cc=80
set ignorecase
set splitbelow splitright

" Disable arrow keys
inoremap <Up> <Nop>
vnoremap <Up> <Nop>
inoremap <Down> <Nop>
vnoremap <Down> <Nop>
inoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Left> <Nop>
inoremap <Right> <Nop>

