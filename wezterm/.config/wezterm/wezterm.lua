local M = {}

local wezterm = require("wezterm")

-- Hide tab bar
M.enable_tab_bar = false

-- Stop cursor fade
M.animation_fps = 1
M.cursor_blink_ease_in  = "Constant"
M.cursor_blink_ease_out = "Constant"
M.cursor_blink_rate = 0

-- Colorscheme {{{
M.colors = {
    foreground = "#FFFFFF",
    background = "#111111",

    cursor_fg = "#111111",
    cursor_bg = "#EEEEEE",

    selection_fg = "#111111",
    selection_bg = "#EEEEEE",

    scrollbar_thumb = "#222222",

    ansi = {
        "#111111",
        "#FF0066",
        "#00FF66",
        "#FF6600",
        "#006FFF",
        "#7422FF",
        "#33EFCF",
        "#EEEEEE",
    },
    brights = {
        "#444444",
        "#FF0066",
        "#00FF66",
        "#FF6600",
        "#006FFF",
        "#7422FF",
        "#33EFCF",
        "#FFFFFF",
    },
    indexed = {},

    compose_cursor = "#FFCC33",

    copy_mode_active_highlight_bg = { AnsiColor = 'White' },
    copy_mode_active_highlight_fg = { AnsiColor = 'Black' },
    copy_mode_inactive_highlight_bg = { AnsiColor = 'Grey' },
    copy_mode_inactive_highlight_fg = { AnsiColor = 'White' },

    quick_select_label_bg = { AnsiColor = 'Lime'  },
    quick_select_label_fg = { AnsiColor = 'White' },
    quick_select_match_bg = { AnsiColor = 'Navy'  },
    quick_select_match_fg = { AnsiColor = 'White' },
} -- }}}
M.window_background_opacity = 0.9
M.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}
M.enable_scroll_bar = true

M.font = wezterm.font("Source Code Pro", { weight = "Regular" })
M.font_size = 12
M.adjust_window_size_when_changing_font_size = false

-- Keys config
M.disable_default_key_bindings = true

-- Global keys
M.keys = { -- {{{
    -- Font size
    { key = ')', mods = 'CTRL|SHIFT', action = wezterm.action.ResetFontSize },
    { key = '0', mods = 'CTRL|SHIFT', action = wezterm.action.ResetFontSize },

    { key = '+', mods = 'CTRL|SHIFT', action = wezterm.action.IncreaseFontSize },
    { key = '=', mods = 'CTRL|SHIFT', action = wezterm.action.IncreaseFontSize },

    { key = '-', mods = 'CTRL|SHIFT', action = wezterm.action.DecreaseFontSize },
    { key = '_', mods = 'CTRL|SHIFT', action = wezterm.action.DecreaseFontSize },

    -- Copy/paste + unicode
    { key = 'c', mods = 'CTRL|SHIFT', action = wezterm.action.CopyTo("Clipboard")    },
    { key = 'v', mods = 'CTRL|SHIFT', action = wezterm.action.PasteFrom("Clipboard") },
    { key = 'e', mods = 'CTRL|SHIFT', action = wezterm.action.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }) },

    -- Scroll
    { key = 'k', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollByLine(-1) },
    { key = 'u', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollByPage(-1) },

    { key = 'j', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollByLine( 1) },
    { key = 'd', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollByPage( 1) },

    { key = 'g', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollToBottom },

    { key = 'l', mods = 'CTRL|SHIFT', action = wezterm.action.ClearScrollback("ScrollbackOnly") },

    -- Misc
    { key = 'r', mods = 'CTRL|SHIFT', action = wezterm.action.ReloadConfiguration },
    { key = 'f', mods = 'CTRL|SHIFT', action = wezterm.action.Search("CurrentSelectionOrEmptyString") }, -- TODO: Regex
    { key = 'y', mods = 'CTRL|SHIFT', action = wezterm.action.ActivateCopyMode },
    { key = 's', mods = 'CTRL|SHIFT', action = wezterm.action.QuickSelect },
} -- }}}

-- Key tables
M.key_tables = { -- {{{
    -- Search mode keys
    search_mode = { -- {{{
        { key = 'Escape', mods = 'NONE', action = wezterm.action.CopyMode('Close') },
        { key = 'c',      mods = 'CTRL', action = wezterm.action.CopyMode('Close') },

        { key = 'Enter', mods = 'NONE', action = wezterm.action.CopyMode('PriorMatch') },
        { key = 'n', mods = 'CTRL', action = wezterm.action.CopyMode('NextMatch')  },
        { key = 'p', mods = 'CTRL', action = wezterm.action.CopyMode('PriorMatch') },

        { key = 'u', mods = 'CTRL', action = wezterm.action.CopyMode('PriorMatchPage') },
        { key = 'd', mods = 'CTRL', action = wezterm.action.CopyMode('NextMatchPage')  },

        { key = 'l', mods = 'CTRL', action = wezterm.action.CopyMode('ClearPattern')   },
        { key = 'r', mods = 'CTRL', action = wezterm.action.CopyMode('CycleMatchType') },

    }, -- }}}

    -- Copy mode keys
    copy_mode = { -- {{{
        { key = 'Escape', mods = 'NONE', action = wezterm.action.CopyMode('Close') },
        { key = 'q',      mods = 'NONE', action = wezterm.action.CopyMode('Close') },
        { key = 'c',      mods = 'CTRL', action = wezterm.action.CopyMode('Close') },

        { key = 'h', mods = 'NONE', action = wezterm.action.CopyMode('MoveLeft')  },
        { key = 'j', mods = 'NONE', action = wezterm.action.CopyMode('MoveDown')  },
        { key = 'k', mods = 'NONE', action = wezterm.action.CopyMode('MoveUp')    },
        { key = 'l', mods = 'NONE', action = wezterm.action.CopyMode('MoveRight') },

        { key = 'w', mods = 'NONE', action = wezterm.action.CopyMode('MoveForwardWord')  },
        { key = 'b', mods = 'NONE', action = wezterm.action.CopyMode('MoveBackwardWord') },

        { key = '^', mods = 'NONE', action = wezterm.action.CopyMode('MoveToStartOfLineContent') },
        { key = '0', mods = 'NONE', action = wezterm.action.CopyMode('MoveToStartOfLine') },
        { key = '$', mods = 'NONE', action = wezterm.action.CopyMode('MoveToEndOfLineContent') },

        { key = 'g', mods = 'NONE', action = wezterm.action.CopyMode('MoveToScrollbackTop') },
        { key = 'G', mods = 'NONE', action = wezterm.action.CopyMode('MoveToScrollbackBottom') },

        { key = 'H', mods = 'NONE', action = wezterm.action.CopyMode('MoveToViewportTop') },
        { key = 'M', mods = 'NONE', action = wezterm.action.CopyMode('MoveToViewportMiddle') },
        { key = 'L', mods = 'NONE', action = wezterm.action.CopyMode('MoveToViewportBottom') },

        { key = 'V', mods = 'NONE', action = wezterm.action.CopyMode({ SetSelectionMode = 'Line'  }) },
        { key = 'v', mods = 'NONE', action = wezterm.action.CopyMode({ SetSelectionMode = 'Cell'  }) },
        { key = 'v', mods = 'CTRL', action = wezterm.action.CopyMode({ SetSelectionMode = 'Block' }) },

        { key = '%', mods = 'NONE', action = wezterm.action.CopyMode('MoveToSelectionOtherEnd') },

        { key = 'u', mods = 'CTRL', action = wezterm.action.CopyMode('PageUp') },
        { key = 'd', mods = 'CTRL', action = wezterm.action.CopyMode('PageDown') },

        { key = 'y', mods = 'NONE', action = wezterm.action.Multiple({ { CopyTo = 'ClipboardAndPrimarySelection' }, { CopyMode = 'Close' } }) },
    }, -- }}}
} -- }}}

return M
