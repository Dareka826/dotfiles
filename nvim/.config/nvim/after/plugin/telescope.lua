local telescope = require("telescope")

telescope.setup({
    defaults = {
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    },
})

telescope.load_extension('fzf')
