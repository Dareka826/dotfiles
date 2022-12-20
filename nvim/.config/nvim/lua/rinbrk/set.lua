-- No Compatible
vim.opt.compatible = false

-- Leader
vim.g.mapleader = " "
vim.opt.timeout = false

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Encoding
vim.o.fileencodings = 'utf-8,sjis,euc-jp,default'

-- Splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Markers
vim.opt.foldmethod = "marker"

-- Listchars
vim.opt.list = true
vim.o.listchars = 'tab:>·,trail:-,nbsp:+'

-- Statusline
vim.opt.laststatus = 2
vim.opt.showmode = false

-- Searching
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true

-- Look
vim.opt.guicursor = "n-v-r:block,i-c:ver10"
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"
vim.opt.showcmd = true
vim.opt.cursorline = true

-- Misc
vim.opt.wrap = false
vim.opt.scrolloff = 2

vim.opt.signcolumn = "yes"
vim.opt.lazyredraw = true
vim.opt.updatetime = 50
vim.opt.errorbells = false
vim.opt.hidden = true
vim.g.c_syntax_for_h = 1

vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Emmet
vim.g.user_emmet_mode = 'i'
vim.g.user_emmet_leader_key = '<c-h>'

-- Signify
vim.g.signify_sign_change = '~'
vim.g.signify_sign_show_count = 0

vim.cmd([[highlight SignifySignAdd    guifg=#22AA66 ctermfg=41]])
vim.cmd([[highlight SignifySignChange guifg=#FF6600 ctermfg=202]])
vim.cmd([[highlight SignifySignDelete guifg=#FF2255 ctermfg=197]])

-- VimWiki
vim.cmd("filetype plugin on")
vim.cmd("syntax on")

vim.g.vimwiki_list = {{
    path = "~/vimwiki/",
    syntax = "markdown",
    ext = ".md",
}}

-- Neovide
vim.opt.guifont = "Source Code Pro"
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_particle_density = 100.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1

-- Syntax augroup
vim.cmd([[
augroup rinbrk_syntax
    " Clear the group
    autocmd!

    " Redo syntax
    autocmd BufRead,BufNewFile *.do set ft=sh
    " Execline syntax
    autocmd BufRead,BufNewFile *.xl set ft=execline

    " Do not use spaces for python
    autocmd BufRead,BufNewFile *.py,*.pyw set noexpandtab
augroup END
]])

-- Firenvim
vim.cmd([[
if exists('g:started_by_firenvim')
    set guifont=monospace:h11
endif
]])

vim.cmd([[
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
]])

-- Cursor shape
vim.cmd([[let &t_EI = "\<Esc>[2 q"]]) -- Non-blinking block
vim.cmd([[let &t_SI = "\<Esc>[6 q"]]) -- Non-blinking beam
vim.cmd([[let &t_SR = "\<Esc>[4 q"]]) -- Non-blinking underscore

-- Enable gdb integration
vim.cmd([[packadd termdebug]])
vim.cmd([[let g:termdebug_wide=1]])
