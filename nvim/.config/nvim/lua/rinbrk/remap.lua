--local map = require("rinbrk.keymap")
local map = {}

map.noremap = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true })
end
map.map = function(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = false })
end

map.nmap     = function(lhs, rhs) map.map("n", lhs, rhs) end
map.nnoremap = function(lhs, rhs) map.noremap("n", lhs, rhs) end
map.vnoremap = function(lhs, rhs) map.noremap("v", lhs, rhs) end
map.inoremap = function(lhs, rhs) map.noremap("i", lhs, rhs) end

-- Open netrw
map.nnoremap("<leader>pv", vim.cmd.Ex)

-- Telescope
map.nnoremap("<leader>T", ":Telescope<space>")

map.nnoremap("<leader>fb",  "<cmd>Telescope buffers<CR>")
map.nnoremap("<leader>fg",  "<cmd>Telescope git_files<CR>")
map.nnoremap("<leader>ff",  "<cmd>Telescope find_files<CR>")
map.nnoremap("<leader>fd",  "<cmd>Telescope diagnostics<CR>")
map.nnoremap("<leader>ft",  "<cmd>Telescope treesitter<CR>")
map.nnoremap("<leader>fk",  "<cmd>Telescope keymaps<CR>")
map.nnoremap("<leader>fq",  "<cmd>Telescope quickfix<CR>")
map.nnoremap("<leader>fll", "<cmd>Telescope loclist<CR>")
map.nnoremap("<leader>fh",  "<cmd>Telescope help_tags<CR>")
map.nnoremap("<leader>fm",  "<cmd>Telescope man_pages<CR>")
map.nnoremap("<leader>flr", "<cmd>Telescope lsp_references<CR>")
map.nnoremap("<leader>fld", "<cmd>Telescope lsp_definitions<CR>")
map.nnoremap("<leader>fli", "<cmd>Telescope lsp_implementations<CR>")

map.nnoremap("<c-p>", "<cmd>Telescope git_files<CR>")
map.nnoremap("<c-f>", "<cmd>Telescope find_files<CR>")

-- CTRL-/ to fuzzy find in current buffer
map.nnoremap("<c-_>", "<cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending<CR>")

-- Yank to eol
map.nnoremap("Y", "y$")
map.vnoremap("Y", "y$")

-- System clipboard
map.nnoremap("<leader>p", '"+p')
map.nnoremap("<leader>y", '"+y')
map.nnoremap("<leader>Y", '"+y$')
map.vnoremap("<leader>y", '"+y')
map.vnoremap("<leader>Y", '"+y$')

-- Leader save, quit
map.nnoremap("<leader>w", "<cmd>w<CR>")
map.nnoremap("<leader>q", "<cmd>q<CR>")
map.nnoremap("<leader>Q", "<cmd>q!<CR>")

-- Break undo sequence on these
map.inoremap(",", ",<c-g>u")
map.inoremap(".", ".<c-g>u")
map.inoremap("!", "!<c-g>u")
map.inoremap("?", "?<c-g>u")

-- Clear highlight after search
map.nnoremap("<leader><space>", "<cmd>noh<CR>")

