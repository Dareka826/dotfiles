local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
    --"clangd",
    --"sumneko_lua",
    --"html",
    --"cssls",
    --"rust_analyzer",
    --"zls",
    "tsserver",
    --"eslint",
})

lsp.configure('clangd', {
    force_setup = true,
    cmd = { 'clangd' }
})

lsp.configure('sumneko_lua', {
    force_setup = true,
    cmd = { 'lua-language-server' }
})

lsp.set_preferences({
    sign_icons = {
        error = 'E',
        warn  = 'W',
        hint  = 'H',
        info  = 'I',
    }
})

lsp.on_attach(function()
    -- Run inside every buffer after lsp attached
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,           { buffer = 0 })

    vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition,      { buffer = 0 })
    vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation,  { buffer = 0 })
    vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references,      { buffer = 0 })
    vim.keymap.set("n", "<leader>gR", vim.lsp.buf.rename,          { buffer = 0 })
    vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { buffer = 0 })

    vim.keymap.set("n", "<leader>gq", vim.diagnostic.setqflist,    { buffer = 0 })
    vim.keymap.set("n", "<leader>gj", vim.diagnostic.goto_next,    { buffer = 0 })
    vim.keymap.set("n", "<leader>gk", vim.diagnostic.goto_prev,    { buffer = 0 })
end)

lsp.nvim_workspace({
    library = vim.api.nvim_get_runtime_file('', true)
})

lsp.setup()

-- Adjust cmp config
local cmp = require("cmp")
local cmp_config = lsp.defaults.cmp_config()

local cmp_select = { behavior = cmp.SelectBehavior.Select }
cmp_config.mapping = {
    ["<C-p>"] = cmp.mapping( cmp.mapping.select_prev_item(cmp_select), {'i'} ),
    ["<C-n>"] = cmp.mapping( cmp.mapping.select_next_item(cmp_select), {'i'} ),

    ["<C-y>"] = cmp.mapping( cmp.mapping.confirm({ select = true }), {'i'} ),
    ["<C-e>"] = cmp.mapping( cmp.mapping.close(), {'i'} ),
    ["<C-space>"] = cmp.mapping( cmp.mapping.complete(), {'i'} ),

    ["<C-b>"] = cmp.mapping( cmp.mapping.scroll_docs(-4), {'i'} ),
    ["<C-f>"] = cmp.mapping( cmp.mapping.scroll_docs( 4), {'i'} ),
}

cmp_config.window = {
    completion = {
        border = 'none',
    },
    documentation = {
        border = {'', '', '', ' ', '', '', '', ' '},
        scrollable = true,
        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
    },
}

cmp_config.formatting = {
    format = function(entry, vim_item)
        vim_item.menu = ({
            buffer   = "[buf]",
            nvim_lsp = "[LSP]",
            nvim_lua = "[api]",
            path     = "[path]",
            luasnip  = "[snip]",
        })[entry.source.name]

        return vim_item
    end
}
cmp_config.experimental = {
    ghost_text = true,
}

cmp.setup(cmp_config)

vim.cmd([[hi! link CmpItemAbbr           Fg     " Completion suggestions]])
vim.cmd([[hi! link CmpItemAbbrDeprecated Red    " Deprecated cmp suggestions]])
vim.cmd([[hi! link CmpItemAbbrMatch      Purple " Matched chars in cmp suggestions]])
vim.cmd([[hi! link CmpItemAbbrMatchFuzzy Purple " Matched chars in cmp suggestions]])
vim.cmd([[hi! link CmpItemMenu           Grey   " Source of suggestion]])
