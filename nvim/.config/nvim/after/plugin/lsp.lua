local cmp = require("cmp")

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    mapping = {
        ["<c-n>"] = cmp.mapping(cmp.mapping.select_next_item(), {'i'}),
        ["<c-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), {'i'}),

        ["<c-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), {'i'}),
        ["<c-f>"] = cmp.mapping(cmp.mapping.scroll_docs( 4), {'i'}),

        ["<c-space>"] = cmp.mapping(cmp.mapping.complete(), {'i'}),

        ["<c-e>"] = cmp.mapping(cmp.mapping.close(), {'i'}),
        ["<c-y>"] = cmp.mapping(cmp.mapping.confirm({ select = true }), {'i'}),
    },
    sources = {
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path"     },
        { name = "luasnip"  },
        { name = "buffer", keyword_length = 3 },
    },
    formatting = {
        format = function(entry, vim_item)
            vim_item.menu = ({
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
            })[entry.source.name]

            return vim_item
        end
    },
    experimental = {
        ghost_text = true,
    },
})
