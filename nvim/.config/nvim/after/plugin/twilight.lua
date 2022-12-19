require("twilight").setup({
    dimming = {
        alpha = 0.25,     -- amount of dimming
    },
    context = 20, -- amount of lines we will try to show around the current line
    treesitter = true, -- use treesitter when available for the filetype
    exclude = {}, -- exclude these filetypes
})
