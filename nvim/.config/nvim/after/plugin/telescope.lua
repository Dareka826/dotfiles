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

vim.keymap.set("n", "<leader>T", ":Telescope<space>", { noremap = true })

vim.keymap.set("n", "<leader>ff",  builtin.find_files,      { noremap = true })
vim.keymap.set("n", "<leader>fg",  builtin.git_files,       { noremap = true })
vim.keymap.set("n", "<leader>fb",  builtin.buffers,         { noremap = true })
vim.keymap.set("n", "<leader>fd",  builtin.diagnostics,     { noremap = true })
vim.keymap.set("n", "<leader>fk",  builtin.keymaps,         { noremap = true })
vim.keymap.set("n", "<leader>fq",  builtin.quickfix,        { noremap = true })
vim.keymap.set("n", "<leader>fll", builtin.loclist,         { noremap = true })
vim.keymap.set("n", "<leader>fh",  builtin.help_tags,       { noremap = true })
vim.keymap.set("n", "<leader>fm",  builtin.man_pages,       { noremap = true })
vim.keymap.set("n", "<leader>flr", builtin.lsp_references,  { noremap = true })
vim.keymap.set("n", "<leader>fld", builtin.lsp_definitions, { noremap = true })

vim.keymap.set("n", "<c-f>",  builtin.find_files,      { noremap = true })
vim.keymap.set("n", "<c-p>",  builtin.git_files,       { noremap = true })

-- CTRL-/ to fuzzy find in current buffer
vim.keymap.set("n", "<c-_>", "<cmd>Telescope current_buffer_fuzzy_find sorting_strategy=ascending<CR>", { noremap = true })
