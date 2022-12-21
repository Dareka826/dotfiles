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
map.nnoremap("<leader>w", vim.cmd.write)
map.nnoremap("<leader>q", vim.cmd.quit)
map.nnoremap("<leader>Q", vim.cmd['quit!'])

-- Break undo sequence on these
map.inoremap(",", ",<c-g>u")
map.inoremap(".", ".<c-g>u")
map.inoremap("!", "!<c-g>u")
map.inoremap("?", "?<c-g>u")

-- Clear highlight after search
map.nnoremap("<leader><space>", vim.cmd.nohlsearch) -- silent?

-- Center and unfold after these:
map.nnoremap('<c-o>', '<c-o>zzzv')
map.nnoremap('n', 'nzzzv')
map.nnoremap('N', 'Nzzzv')

-- Signify
map.nmap('<leader>gj', '<plug>(signify-next-hunk)')
map.nmap('<leader>gk', '<plug>(signify-prev-hunk)')
map.nmap('<leader>gy', vim.cmd.SignifyToggleHighlight)

-- Make bg transparent
--map.nnoremap('<leader>t', ':hi Normal guibg=NONE ctermbg=NONE<CR>')
--map.nnoremap('<leader>t', ':let g:sonokai_transparent_background = 1<CR>:colorscheme sonokai<CR>')

-- Git Fugitive
map.nnoremap('<leader>gs', '<cmd>Git<CR>')
map.nnoremap('<leader>gh', '<cmd>diffget //2<CR>')
map.nnoremap('<leader>gl', '<cmd>diffget //3<CR>')

-- Vimspector
--map.nnoremap('<leader>dd', ':call vimspector#Launch()<CR>')
--map.nnoremap('<leader>dc', ':call vimspector#Continue()<CR>')
--map.nnoremap('<leader>dl', ':call vimspector#StepInto()<CR>')
--map.nnoremap('<leader>dj', ':call vimspector#StepOver()<CR>')
--map.nnoremap('<leader>dk', ':call vimspector#StepOut()<CR>')
--map.nnoremap('<leader>dr', ':call vimspector#Restart()<CR>')
--map.nnoremap('<leader>dt', ':call vimspector#RunToCursor()<CR>')
--map.nnoremap('<leader>db', ':call vimspector#ToggleBreakpoint()<CR>')
--map.nnoremap('<leader>do', ':call vimspector#ToggleConditionalBreakpoint()<CR>')
--map.nnoremap('<leader>dp', ':call vimspector#Pause()<CR>')
--map.nnoremap('<leader>dx', ':call vimspector#Stop()<CR>')

-- Clear cmdline
map.nnoremap('<leader>c', ':<BS>')
