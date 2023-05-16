-- Indent lines
require("indent_blankline").setup({
    show_trailing_blankline_indent = false,
    show_current_context = true,
    show_first_indent_level = false,
    use_treesitter = true,
})

vim.cmd('highlight IndentBlanklineChar               cterm=nocombine gui=nocombine guifg=#3b4261')
vim.cmd('highlight IndentBlanklineSpaceChar          cterm=nocombine gui=nocombine guifg=#3b4261')
vim.cmd('highlight IndentBlanklineSpaceCharBlankline cterm=nocombine gui=nocombine guifg=#3b4261')
