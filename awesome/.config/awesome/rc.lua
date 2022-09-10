-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Variables shared between config files
local sharedconf = require("shared")
-- Keybindings configuration
local keyconf = require("keys")

local modkey = sharedconf.modkey

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Notifications
naughty.config.padding = 5 -- 10
naughty.config.spacing = 5
naughty.config.defaults.margin = 5
naughty.config.defaults.border_width = 2

naughty.config.presets.critical.bg = nil
naughty.config.presets.critical.fg = "#ff0000"
naughty.config.presets.critical.border_color = "#ff0000"
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme.lua")

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    awful.layout.suit.max,
    awful.layout.suit.floating,
}
-- }}}

-- {{{ Wibar
-- Widgets

-- CMUS {{{
mycmus = wibox.widget.textbox(" [ cmus ??? ] ")
gears.timer {
    timeout   = 1,
    call_now  = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async_with_shell(
            [[cmus-remote -C status | awk '
$1=="file" { $1=""; sub(/.*\//,""); title = $0 }
$1=="tag" && $2=="title" { sub("tag title ",""); title = $0 }
$1=="tag" && $2=="tracknumber" { tracknum = $3 }
$1=="duration" { dur = $2 }
$1=="position" { pos = $2 }
function stohms(t) {
    s = t%60
    m = ((t-s)/60)%60
    h = (t-m*60-s)/3600
    if(h<10) h = "0"h
    if(m<10) m = "0"m
    if(s<10) s = "0"s
    return h ":" m ":" s
}
END {
    if(dur!=0)
    {
        if(tracknum == 0) tracknum = "?"
        lef = dur-pos
        printf("%s. %s\342\200\255 | -%s/%s", tracknum, title, stohms(lef), stohms(dur))
    }
    else
        printf("cmus off")
}']],
            function(cmus)
                mycmus.text = " " .. cmus:sub(1,-2) .. " "
            end
        )
    end
} -- }}}
mycmus:buttons(
    awful.button({}, 1, function() awful.spawn("cmus-remote -u") end)
)

-- Cpu and ram {{{
mycpuram = {
    widget = wibox.widget.textbox(" C:??% R:??%+??%"),
    last_cpu_total_time = 0,
    last_cpu_busy_time = 0
}
gears.timer {
    timeout   = 1,
    call_now  = true,
    autostart = true,
    callback  = function()
        awful.spawn.easy_async_with_shell(
            "grep '^cpu ' /proc/stat | tr -s ' '",
            -- Cpu usage
            function(cpu)
                cpu = cpu:gsub("^cpu ", "")
                local cpu_total_time = 0
                local cpu_busy_time  = 0

                local index = 1
                for word in string.gmatch(cpu, "%S+") do
                    cpu_total_time = cpu_total_time + tonumber(word)

                    if index ~= 4 and index ~= 5 then
                        cpu_busy_time = cpu_busy_time + tonumber(word)
                    end
                    index = index + 1
                end

                local cpu_usage = math.floor(100 * (cpu_busy_time - mycpuram.last_cpu_busy_time) / (cpu_total_time - mycpuram.last_cpu_total_time) + 0.5)
                if cpu_usage < 10 then cpu_usage = " " .. tostring(cpu_usage) end

                mycpuram.last_cpu_total_time = cpu_total_time
                mycpuram.last_cpu_busy_time  = cpu_busy_time

                -- Ram and swap usage
                awful.spawn.easy_async_with_shell(
                    [[grep -E "(Mem|Swap)" /proc/meminfo | tr -s ' :' ' ' | awk '
/MemTotal/     { mem_total  = $2 }
/MemAvailable/ { mem_free   = $2 }
/SwapTotal/    { swap_total = $2 }
/SwapFree/     { swap_free  = $2 }

END {
    if(swap_total == 0) {
        swap_total = 1;
        swap_used  = 1;
    }

    mem_usage  = (mem_total  - mem_free ) / mem_total;
    swap_usage = (swap_total - swap_free) / swap_total;

    printf("%d %d\n", mem_usage * 100 + 0.5, swap_usage * 100 + 0.5);
}']],
                    function(memory)
                        memory = memory:sub(1,-2)

                        local ram_usage  = 0
                        local swap_usage = 0

                        local index = 1
                        for word in string.gmatch(memory, "%S+") do
                            if index == 1 then ram_usage  = tonumber(word) end
                            if index == 2 then swap_usage = tonumber(word) end
                            index = index + 1
                        end

                        mycpuram.widget.text = " C:" .. cpu_usage .. "% R:" .. ram_usage .. "%+" .. swap_usage .. "%"
                    end
                )
            end
        )
    end
} -- }}}

-- Volume {{{
myvolume = wibox.widget.textbox(" V:??% ")
gears.timer {
    timeout   = 1,
    call_now  = true,
    autostart = true,
    callback = function()
        awful.spawn.easy_async(
            {"pamixer", "--get-volume"},
            function(volume)
                awful.spawn.easy_async(
                    {"pamixer", "--get-mute"},
                    function(mute)
                        if mute:sub(1,-2) == "true" then
                            myvolume.text = " V:M" .. volume:sub(1,-2) .. "%M"
                        else
                            myvolume.text = " V:" .. volume:sub(1,-2) .. "%"
                        end
                    end
                )
            end
        )
    end
} -- }}}

-- Battery {{{
mybattery = wibox.widget.textbox(" B:??% ")
if gears.filesystem.is_dir("/sys/class/power_supply/BAT0") then
    gears.timer {
        timeout   = 5,
        call_now  = true,
        autostart = true,
        callback  = function()
            awful.spawn.easy_async(
                {"cat", "/sys/class/power_supply/BAT0/capacity"},
                function(cap)
                    awful.spawn.easy_async(
                        {"cat", "/sys/class/power_supply/BAT0/status"},
                        function(status)
                            status = status:sub(1,-2)
                            cap = cap:sub(1,-2)

                            local color = "<span>"
                            if tonumber(cap) < 20 then
                                color = "<span foreground='#ee0000'>"
                            end

                            local indicator = ""
                            if status == "Charging" then
                                indicator = "^"
                            elseif status == "Discharging" then
                                indicator = "v"
                            end

                            mybattery.markup = " B:" .. color .. cap .. "%</span>" .. indicator .. " "
                        end
                    )
                end
            )
        end
    }
end -- }}}

-- Clock
mytextclock = wibox.widget.textclock(" %Y-%m-%d %H:%M:%S ", 1)

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
    awful.button({ }, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then
            client.focus:move_to_tag(t)
        end
    end),
    awful.button({ }, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then
            client.focus:toggle_tag(t)
        end
    end),
    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
    awful.button({ }, 3, awful.menu.client_list)
)

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    else
        awful.spawn("nitrogen --restore")
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

-- Update layout text with current layout and number of clients
local function update_layout_text(scr)
    local layout_name = awful.layout.getname(awful.layout.get(scr))

    local clients_count = 0
    -- Sum client count across selected tags
    local ts = awful.screen.focused().selected_tags
    for _,tag in ipairs(ts) do
        local clients = tag:clients()
        clients_count = clients_count + #clients
    end

    local txt = (beautiful["layout_text_" .. layout_name] or ("[" .. layout_name .. "]")) .. " :" .. clients_count
    scr.mylayouttext:get_children_by_id("layout_text")[1]:set_text(txt)
end

local function taglist_custom_filter(t)
    return #t:clients() > 0 or t.selected or tonumber(t.name) <= 6
end

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag(sharedconf.tags, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = taglist_custom_filter,
        widget_template = {
            {
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                },
                left   = 9,
                right  = 9,
                widget = wibox.container.margin
            },
            id     = 'background_role',
            widget = wibox.container.background,
        },
        buttons = taglist_buttons
    }

    -- Create layout text
    s.mylayouttext = wibox.widget {
        {
            {
                text   = "[]",
                id     = "layout_text",
                widget = wibox.widget.textbox,
            },
            left   = 9,
            right  = 9,
            widget = wibox.container.margin,
        },
        bg     = beautiful.bg_dark2,
        widget = wibox.container.background
    }
    update_layout_text(s)

    -- Update layout text
    awful.tag.attached_connect_signal(s, "property::selected", function() update_layout_text(s) end)
    awful.tag.attached_connect_signal(s, "property::layout",   function() update_layout_text(s) end)
    awful.tag.attached_connect_signal(s, "untagged",           function() update_layout_text(s) end)
    s.mylayouttext:buttons(gears.table.join(
                           awful.button({}, 1, function() awful.layout.inc( 1) end),
                           awful.button({}, 3, function() awful.layout.inc(-1) end)))

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.focused,
        widget_template = {
            {
                {
                    id     = 'text_role',
                    widget = wibox.widget.textbox,
                },
                left   = 9,
                widget = wibox.container.margin,
            },
            color  = beautiful.bg_dark1,
            widget = wibox.container.background,
        },
        buttons = tasklist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = beautiful.wibar_height })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mylayouttext, -- [<layout symbol>]:<number of clients>
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            {
                mycmus,
                bg     = beautiful.bg_dark3,
                widget = wibox.container.background,
            },
            {
                {
                    {
                        text   = " ",
                        widget = wibox.widget.textbox,
                    },
                    bg     = beautiful.bg_dark2,
                    widget = wibox.container.background,
                },
                wibox.widget.systray(),
                {
                    mycpuram.widget,
                    bg     = beautiful.bg_dark2,
                    widget = wibox.container.background,
                },
                {
                    myvolume,
                    bg     = beautiful.bg_dark2,
                    widget = wibox.container.background,
                },
                {
                    mybattery,
                    bg     = beautiful.bg_dark2,
                    widget = wibox.container.background,
                },
                widget = wibox.layout.fixed.horizontal,
            },
            {
                mytextclock,
                bg     = beautiful.bg_focus,
                widget = wibox.container.background,
            },
        },
    }
end)
-- }}}

-- {{{ Key bindings

-- Set keys
local clientbuttons = gears.table.join(
    awful.button({ }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c, "bottom_right")
    end)
)

root.keys(keyconf.globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = keyconf.clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true, above = true }},

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    -- Make all floating windows also above
    if c.floating then
        c.above = true
        c:raise()
    end

    -- Update number of clients on creation
    update_layout_text(c.screen)
end)

-- Update number of clients on destruction
client.connect_signal("unmanage", function(c)
    update_layout_text(c.screen)
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Title
            align  = "center",
            widget = awful.titlebar.widget.titlewidget(c)
        },
        buttons = buttons,
        layout  = wibox.layout.flex.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("focus",   function(c) c.border_color = beautiful.border_focus  end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
