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
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
--require("awful.hotkeys_popup.keys")

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
    awesome.connect_signal("debug::error", function (err)
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

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
--beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(os.getenv("HOME") .. "/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "alacritty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
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
        printf("%s. %s | -%s/%s", tracknum, title, stohms(lef), stohms(dur))
    }
    else
        printf("cmus off")
}']],
            function(cmus)
                mycmus.text = " [ " .. cmus:sub(1,-2) .. " ] "
            end
        )
    end
} -- }}}

-- Cpu and ram {{{
mycpuram = {
    widget = wibox.widget.textbox(" C:??% R:??%+??% "),
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

                        mycpuram.widget.text = " C:" .. cpu_usage .. "% R:" .. ram_usage .. "%+" .. swap_usage .. "% "
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
                            myvolume.text = " V:M" .. volume:sub(1,-2) .. "M% "
                        else
                            myvolume.text = " V:" .. volume:sub(1,-2) .. "% "
                        end
                    end
                )
            end
        )
    end
} -- }}}

-- Battery {{{
mybattery = wibox.widget.textbox(" B:??% ")
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
} -- }}}

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
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

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

    local txt = (beautiful["layout_text_" .. layout_name] or ("[" .. layout_name .. "]")) .. ":" .. clients_count
    scr.mylayouttext:get_children_by_id("layout_text")[1]:set_text(txt)
end

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
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
            text   = "[]",
            id     = "layout_text",
            widget = wibox.widget.textbox,
        },
        left   = 9,
        right  = 9,
        widget = wibox.container.margin,
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
            id     = 'background_role',
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
            mycmus,
            {
                text = "| ",
                widget = wibox.widget.textbox,
            },
            wibox.widget.systray(),
            {
                text = " |",
                widget = wibox.widget.textbox,
            },
            mycpuram.widget,
            {
                text = "|",
                widget = wibox.widget.textbox,
            },
            myvolume,
            {
                text = "|",
                widget = wibox.widget.textbox,
            },
            mybattery,
            {
                text = "|",
                widget = wibox.widget.textbox,
            },
            mytextclock,
        },
    }
end)
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,   {description="show help",     group="awesome"}),

    awful.key({ modkey,           }, "b",   awful.tag.viewprev,        {description="view previous",         group="tag"}),
    awful.key({ modkey,           }, "n",   awful.tag.viewnext,        {description="view next",             group="tag"}),
    awful.key({ modkey,           }, "Tab", awful.tag.history.restore, {description="view last visited tag", group="tag"}),

    awful.key({ modkey,           }, "j", function() awful.client.focus.byidx( 1) end, {description="focus next by index",     group="client"}),
    awful.key({ modkey,           }, "k", function() awful.client.focus.byidx(-1) end, {description="focus previous by index", group="client"}),

    awful.key({ modkey, "Shift"   }, "j", function() awful.client.swap.byidx( 1)     end, {description="swap with next client by index",     group="client"}),
    awful.key({ modkey, "Shift"   }, "k", function() awful.client.swap.byidx(-1)     end, {description="swap with previous client by index", group="client"}),

    awful.key({ modkey,           }, ",", function() awful.screen.focus_relative(-1) end, {description="focus the previous screen",          group="screen"}),
    awful.key({ modkey,           }, ".", function() awful.screen.focus_relative( 1) end, {description="focus the next screen",              group="screen"}),

    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto, {description="jump to urgent client", group="client"}),
    awful.key({ modkey,           }, "Escape",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end, {description="focus last selected client", group="client"}),

    awful.key({ modkey, "Shift" }, "b",
        function()
            local myscreen = awful.screen.focused()
            myscreen.mywibox.visible = not myscreen.mywibox.visible 
        end, {description="toggle statusbar", group="layout"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function() awful.spawn(terminal)    end, {description="open a terminal", group="launcher"}),
    awful.key({ modkey,           }, "d",      function() awful.spawn("dmenu_run") end, {description="open dmenu",      group="launcher"}),

    awful.key({ modkey, "Control" }, "r", awesome.restart, {description="reload awesome", group="awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,    {description="quit awesome",   group="awesome"}),

    awful.key({ modkey, "Shift"   }, "l", function() awful.tag.incmwfact( 0.05)          end, {description="increase master width factor",          group="layout"}),
    awful.key({ modkey, "Shift"   }, "h", function() awful.tag.incmwfact(-0.05)          end, {description="decrease master width factor",          group="layout"}),
    awful.key({ modkey, "Shift"   }, "i", function() awful.tag.incnmaster( 1, nil, true) end, {description="increase the number of master clients", group="layout"}),
    awful.key({ modkey, "Shift"   }, "d", function() awful.tag.incnmaster(-1, nil, true) end, {description="decrease the number of master clients", group="layout"}),

    awful.key({ modkey,           }, "space", function() awful.layout.inc( 1) end, {description="select next",     group="layout"}),
    --awful.key({ modkey, "Control" }, "space", function() awful.layout.inc(-1) end, {description="select previous", group="layout"}),

    awful.key({ modkey,           }, "t", function() awful.layout.set(awful.layout.suit.tile)           end, {description="set to tile layout",        group="layout"}),
    awful.key({ modkey,           }, "m", function() awful.layout.set(awful.layout.suit.max)            end, {description="set to monocle layout",     group="layout"}),
    --awful.key({ modkey, "Shift"   }, "m", function() awful.layout.set(awful.layout.suit.max.fullscreen) end, {description="set to monocle max layout", group="layout"}),
    awful.key({ modkey,           }, "f", function() awful.layout.set(awful.layout.suit.floating)       end, {description="set to floating layout",    group="layout"}),

    -- Prompt
    awful.key({ modkey }, "x",
              function()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end, {description="lua execute prompt", group="awesome"}),

    -- Volume
    awful.key({ modkey, "Control" }, "Up",   function() awful.spawn("pamixer --allow-boost --increase 5") end, {description="increase volume", group="volume"}),
    awful.key({ modkey, "Control" }, "Down", function() awful.spawn("pamixer --allow-boost --decrease 5") end, {description="decrease volume", group="volume"}),

    -- Misc
    awful.key({ modkey,           }, "c", function() awful.spawn("cmus-remote -u") end, {description="toggle cmus playback", group="misc"}),

    -- Lockscreen
    awful.key({ modkey,           }, "l", function() awful.spawn("dash " .. os.getenv("HOME") .. "/.local/bin/lock.sh") end, {description="lock screen", group="lock"}),
    awful.key({ modkey, "Control", "Shift" }, "l", function() awful.spawn("slock") end, {description="lock screen (slock)", group="lock"}),

    -- Tmux
    awful.key({ modkey, "Control", "Shift" }, "Return", function() awful.spawn(terminal .. " -e tmux") end,
        {description="spawn a terminal with tmux",          group="launcher"}),
    awful.key({ modkey, "Control", "Shift" }, "a",      function() awful.spawn(terminal .. " -e tmux attach") end,
        {description="spawn a terminal and attach to tmux", group="launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey, "Shift"   }, "f",
        function(c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end, {description="toggle fullscreen", group="client"}),

    awful.key({ modkey, "Shift"   }, "c",      function(c) c:kill()                           end, {description="close client",        group="client"}),
    awful.key({ modkey, "Shift"   }, "space",  function(c)
            awful.client.floating.toggle(c)
            c.above = c.floating
        end, {description="toggle floating", group="client"}),
    awful.key({ modkey, "Shift"   }, "Return", function(c) c:swap(awful.client.getmaster())   end, {description="move to master",      group="client"}),
    awful.key({ modkey, "Shift"   }, ",",      function(c) c:move_to_screen(c.screen.index-1) end, {description="move to prev screen", group="client"}),
    awful.key({ modkey, "Shift"   }, ".",      function(c) c:move_to_screen(c.screen.index+1) end, {description="move to next screen", group="client"}),
    awful.key({ modkey, "Shift"   }, "t",      function(c) c.ontop = not c.ontop              end, {description="toggle keep on top",  group="client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
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
                     keys = clientkeys,
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
