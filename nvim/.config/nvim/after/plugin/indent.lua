-- Indent lines
vim.cmd('highlight IndentBlanklineContextChar guifg=#8877FF gui=nocombine')

require("indent_blankline").setup({
    show_trailing_blankline_indent = false,
    show_current_context = true,
    show_first_indent_level = false,
    use_treesitter = true,
})
