vim.opt.guicursor = "n-v-r:block,i-c:ver10"

vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.list = true
vim.o.listchars = 'tab:>·,trail:-,nbsp:+'

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.wrap = false
vim.opt.scrolloff = 2
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 100

vim.opt.colorcolumn = "80"

vim.opt.laststatus = 2
vim.opt.showmode = false

vim.g.mapleader = " "
vim.opt.timeout = false

vim.opt.completeopt = { "menu", "menuone", "noselect" }

vim.opt.foldmethod = "marker"

vim.opt.lazyredraw = true

-- VimWiki stuff
vim.opt.compatible = false
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
-- vim.g.neovide_cursor_vfx_particle_density = 25.0
-- vim.g.neovide_cursor_vfx_particle_density = 50.0
vim.g.neovide_cursor_vfx_particle_density = 100.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1
