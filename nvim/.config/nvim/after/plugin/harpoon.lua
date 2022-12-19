local mark = require('harpoon.mark')
local ui   = require('harpoon.ui')

vim.keymap.set('n', '<leader>a', mark.add_file)
vim.keymap.set('n', '<C-e>',     ui.toggle_quick_menu)

vim.keymap.set('n', '<leader>hn', function() ui.nav_file(1) end)
vim.keymap.set('n', '<leader>he', function() ui.nav_file(1) end)
vim.keymap.set('n', '<leader>hi', function() ui.nav_file(1) end)
vim.keymap.set('n', '<leader>ho', function() ui.nav_file(1) end)
