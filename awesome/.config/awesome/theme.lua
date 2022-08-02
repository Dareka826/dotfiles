---------------------------
-- Default awesome theme --
---------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local cairo = require("lgi").cairo

local theme = {}

theme.font          = "Source Code Pro Regular 10"

theme.bg_dark1      = "#111111"
theme.bg_dark2      = "#222222"
theme.bg_dark3      = "#333333"

theme.bg_normal     = theme.bg_dark1
theme.bg_focus      = "#6633ff"
theme.bg_urgent     = "#ff6600"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_dark2

theme.fg_normal     = "#ffffff"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = theme.bg_dark1
theme.fg_minimize   = "#bbbbbb"

theme.useless_gap   = 0
theme.border_width  = 2
theme.border_normal = "#444444"
theme.border_focus  = "#6633ff"
theme.border_marked = "#ff6600"

theme.master_width_factor = 0.6

-- Variables set for theming notifications:
theme.notification_font = "Source Code Pro Regular 10"
theme.notification_bg = "#222222"
theme.notification_fg = "#ffffff"
-- notification_[height|margin]
theme.notification_width = 350
theme.notification_border_color = "#6633ff"
theme.notification_border_width = 2
-- notification_shape
theme.notification_opacity = 0.9

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]

theme.taglist_bg_focus    = theme.bg_focus
theme.taglist_fg_focus    = "#ffffff"
theme.taglist_bg_urgent   = theme.bg_urgent
theme.taglist_fg_urgent   = "#222222"
theme.taglist_bg_occupied = theme.bg_dark3
theme.taglist_fg_occupied = "#ffffff"
theme.taglist_bg_empty    = theme.bg_dark2
theme.taglist_fg_empty    = "#eeeeee"
theme.taglist_bg_volatile = "#ff0000"
theme.taglist_fg_volatile = "#ffffff"

theme.prompt_bg = "#ee6600"

-- -- Generate taglist squares:
-- local taglist_square_size   = 5 -- Square size
-- local taglist_square_margin = 2 -- Square offset from top-left
--
-- -- Selected tag square img
-- do
--     theme.taglist_squares_sel = cairo.ImageSurface.create(
--         cairo.Format.ARGB32,
--         taglist_square_size + taglist_square_margin,
--         taglist_square_size + taglist_square_margin
--     )
--     local cr = cairo.Context(theme.taglist_squares_sel)
--
--     cr:set_source_rgb(1, 1, 1)
--     cr:set_antialias(cairo.Antialias.NONE)
--     cr:rectangle(taglist_square_margin, taglist_square_margin, taglist_square_size, taglist_square_size)
--     cr:fill()
-- end
--
-- -- Unselected tag square img
-- do
--     theme.taglist_squares_unsel = cairo.ImageSurface.create(
--         cairo.Format.ARGB32,
--         taglist_square_size + taglist_square_margin,
--         taglist_square_size + taglist_square_margin
--     )
--     local cr = cairo.Context(theme.taglist_squares_unsel)
--
--     cr:set_source_rgb(1, 1, 1)
--     cr:set_antialias(cairo.Antialias.NONE)
--     cr:rectangle(taglist_square_margin+1, taglist_square_margin+1, taglist_square_size-1, taglist_square_size-1)
--     cr:set_line_width(1)
--     cr:stroke()
-- end

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = dpi(18)
theme.menu_width  = dpi(600)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Layout text
theme.layout_text_floating = "><>"
theme.layout_text_max      = "[M]"
theme.layout_text_tileleft = "=[]"
theme.layout_text_tile     = "[]="

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

theme.tasklist_disable_icon = true

theme.wibar_height = 20

theme.tasklist_sticky    = '<b>S</b>'
theme.tasklist_ontop     = '<b>T</b>'
theme.tasklist_above     = '<b>A</b>'
theme.tasklist_below     = '<b>B</b>'
theme.tasklist_floating  = '<b>F</b>'
theme.tasklist_maximized = '<b>M</b>'
theme.tasklist_maximized_horizontal = '<b>H</b>'
theme.tasklist_maximized_vertical   = '<b>V</b>'

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
