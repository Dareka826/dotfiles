local lsp = require("lsp-zero")
local cmp = require("cmp")

lsp.preset("recommended")

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn  = 'W',
        hint  = 'H',
        info  = 'I',
    }
})

lsp.configure('clangd', {
    force_setup = true,
    cmd = { 'clangd' }
})

lsp.configure('sumneko_lua', {
    force_setup = true,
    cmd = { 'lua-language-server' }
})

-- cmp mappings
local cmp_mappings = {
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),

    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-space>"] = cmp.mapping.complete(),

    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs( 4),
}

lsp.setup_nvim_cmp({
    mapping = cmp_mappings,
    completion = {
        border = 'none',
    },
    documentation = {
        border = {'', '', '', ' ', '', '', '', ' '},
        scrollable = true,
        winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,CursorLine:PmenuSel,Search:None',
    },
    formatting = {
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
    },
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

vim.diagnostic.config({
    virtual_text = true,
    float = {
        border = 'none',
    }
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
    vim.lsp.handlers.hover,
    { border = 'none', }
)

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers.signature_help,
    { border = 'none', }
)

vim.cmd([[hi! link CmpItemAbbr           Fg     " Completion suggestions]])
vim.cmd([[hi! link CmpItemAbbrDeprecated Red    " Deprecated cmp suggestions]])
vim.cmd([[hi! link CmpItemAbbrMatch      Purple " Matched chars in cmp suggestions]])
vim.cmd([[hi! link CmpItemAbbrMatchFuzzy Purple " Matched chars in cmp suggestions]])
vim.cmd([[hi! link CmpItemMenu           Grey   " Source of suggestion]])

-- Snippet config
local luasnip = require("luasnip")

vim.keymap.set({"i", "s"}, "<C-u>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true, noremap = true })

vim.keymap.set({"i", "s"}, "<C-d>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true, noremap = true })
