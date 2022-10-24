local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

local lsp_config = {
    capabilities = capabilities,
    on_attach = function()
        -- Run inside every buffer after lsp attached
        vim.keymap.set("n", "K",          vim.lsp.buf.hover,           { buffer = 0 })

        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition,      { buffer = 0 })
        vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation,  { buffer = 0 })
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references,      { buffer = 0 })
        vim.keymap.set("n", "<leader>gR", vim.lsp.buf.rename,          { buffer = 0 })
        vim.keymap.set("n", "<leader>gt", vim.lsp.buf.type_definition, { buffer = 0 })

        vim.keymap.set("n", "<leader>gs", vim.diagnostic.setqflist,    { buffer = 0 })
        vim.keymap.set("n", "<leader>gj", vim.diagnostic.goto_next,    { buffer = 0 })
        vim.keymap.set("n", "<leader>gk", vim.diagnostic.goto_prev,    { buffer = 0 })
    end,
}

require("lspconfig").clangd.setup(lsp_config)
require("lspconfig").sumneko_lua.setup(lsp_config)
require("lspconfig").html.setup(lsp_config)
require("lspconfig").cssls.setup({
    capabilities = lsp_config.capabilities,
    on_attach = lsp_config.on_attach,
    cmd = { "vscode-css-languageserver", "--stdio" },
})
require("lspconfig").jsonls.setup({
    capabilities = lsp_config.capabilities,
    on_attach = lsp_config.on_attach,
    cmd = { "vscode-json-languageserver", "--stdio" },
})
require("lspconfig").rust_analyzer.setup(lsp_config)
require("lspconfig").zls.setup(lsp_config)
-- require("lspconfig").tsserver.setup(lsp_config)
-- require("lspconfig").eslint.setup(lsp_config)
