local telescope = require("telescope")
local builtin   = require("telescope.builtin")

telescope.setup({
    defaults = {
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
})

telescope.load_extension('fzf')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>',      builtin.git_files,  {})
vim.keymap.set('n', '<leader>fs', function()
    builtin.grep_string({
        search = vim.fn.input("Grep> ")
    })
end)
