--local current_colorscheme = "tokyonight"
local current_colorscheme = "tokyonight-moon"
--local current_colorscheme = "tokyonight-night"

-- Set up the colorscheme
vim.opt.background = "dark"

vim.g.sonokai_style = "andromeda"
vim.g.sonokai_diagnostic_text_highlight = 1
vim.g.sonokai_better_performance = 1

vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transparent = true

require("tokyonight").setup({
    style = "moon",
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
        sidebars = "dark",
        floats = "dark",
    },
})

vim.cmd("colorscheme " .. current_colorscheme)
