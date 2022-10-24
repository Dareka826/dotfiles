require('nvim-treesitter.configs').setup({
    ensure_installed = { "c", "lua", "comment" },
    sync_install = false,
    highlight = { enable = true },
    indent    = { enable = true },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
            },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start     = { ["]m"] = "@function.outer" },
            goto_next_end       = { ["]M"] = "@function.outer" },
            goto_previous_start = { ["]m"] = "@function.outer" },
            goto_previous_end   = { ["]M"] = "@function.outer" },
        },
    },
})

-- Setup treesitter for sixel
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.sixel = {
    install_info = {
        url = "https://github.com/Dareka826/tree-sitter-sixel",
        files = { "src/parser.c" },
        branch = "master",
        generate_requires_npm = false,
        requires_generate_from_grammar = false,
    },
    filetype = "six",
}
