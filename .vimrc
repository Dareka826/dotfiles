set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

call vundle#end()
filetype plugin on

syntax on

colorscheme inkpot
set t_Co=256
let g:airline_theme='violet'
let g:airline_powerline_fonts = 1
set guifont=Source\ Code\ Pro:h11

set encoding=utf-8
set number
set autoindent
set noerrorbells
set tabstop=4
set softtabstop=0 noexpandtab
set shiftwidth=4
set rnu

no <Left> <Nop>
no <Down> <Nop>
no <Up> <Nop>
no <Right> <Nop>

ino <Left> <Nop>
ino <Down> <Nop>
ino <Up> <Nop>
ino <Right> <Nop>

vno <Left> <Nop>
vno <Down> <Nop>
vno <Up> <Nop>
vno <Right> <Nop>

