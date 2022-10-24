local custom_theme = require("lualine.themes.nightfly")
custom_theme.normal.b.bg   = "#3b4059"
custom_theme.insert.b.bg   = "#3b4059"
custom_theme.visual.b.bg   = "#3b4059"
custom_theme.replace.b.bg  = "#3b4059"
--custom_theme.command.b.bg  = "#3b4059"
custom_theme.inactive.b.bg = "#3b4059"

--	p N   Percentage through file in lines as in |CTRL-G|.
--	P S   Percentage through file of displayed window.  This is like the
--	      percentage described for 'ruler'.  Always 3 in length, unless
--	      translated.

require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = custom_theme,
        component_separators = '|',
        section_separators   = '',
        globalstatus = false,
        refresh = {
            statusline = 1000,
            tabline    = 1000,
            winbar     = 1000,
        }
    },
    sections = {
        lualine_a = {"mode"},
        lualine_b = {"branch", "diff", "diagnostics"},
        lualine_c = {"filename"},
        lualine_x = {"fileformat", "encoding", "filetype"},
        lualine_y = {"%3p%%"},
        lualine_z = {"location"},
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {"filename"},
        lualine_x = {"location"},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {}
})

-- [MODE] [FNAME] >> [unix] [utf-8] [no ft] [100%]

-- ayu_mirage
-- dracula
-- moonfly
-- nightfly
-- palenight
