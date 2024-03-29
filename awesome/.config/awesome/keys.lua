local M = {}

-- Libs
local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")
local beautiful = require("beautiful")

local sharedconf = require("shared")
local modkey   = sharedconf.modkey
local Tags     = sharedconf.tags
local terminal = sharedconf.terminal
local xobsock  = sharedconf.xobsock

local globalkey_modes = {}
local clientkey_modes = {}

-- Apply key sets globally and to clients
function M.set_mode(mode) -- {{{
    naughty.notify{ title = "Mode: " .. mode }

    if globalkey_modes[mode] == nil or clientkey_modes[mode] == nil then
        naughty.notify{ title = "Mode not set/incomplete, bailing out!" }
        return
    end
    M.mode = mode

    -- Global keys
    root.keys(globalkey_modes[mode])

    -- Client keys
    M.clientkeys = clientkey_modes[mode]
    for _, c in ipairs(client.get()) do
        c.keys = clientkey_modes[mode]
    end
end -- }}}
local set_mode = M.set_mode

-- Generate tag bindings
local function gen_tag_keys(tag_num, tag_key) -- {{{
    return gears.table.join(
        -- View tag only.
        awful.key({ modkey }, tag_key,
            function()
                local tag = awful.screen.focused().tags[tag_num]
                if tag then tag:view_only() end
            end,
            {description = "view tag " .. Tags[tag_num], group = "tag"}
        ),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, tag_key,
            function()
                local tag = awful.screen.focused().tags[tag_num]
                if tag then awful.tag.viewtoggle(tag) end
            end,
            {description = "toggle tag " .. Tags[tag_num], group = "tag"}
        ),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, tag_key,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[tag_num]
                    if tag then client.focus:move_to_tag(tag) end
                end
            end,
            {description = "move focused client to tag " .. Tags[tag_num], group = "tag"}
        ),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, tag_key,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[tag_num]
                    if tag then client.focus:toggle_tag(tag) end
                end
            end,
            {description = "toggle focused client on tag " .. Tags[tag_num], group = "tag"}
        )
    )
end -- }}}

-- MODE: default {{{
globalkey_modes["default"] = gears.table.join(
    -- WM commands
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,    {description="quit awesome",   group="awesome"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart, {description="reload awesome", group="awesome"}),

    -- Standard programs
    awful.key({ modkey, }, "Return", function() awful.spawn(terminal) end, {description="open a terminal", group="launcher"}),
    awful.key({ modkey, }, "d",      function() awful.spawn("/home/rin/.local/bin/dmenu_hisfreq") end, {description="open dmenu",      group="launcher"}),

    -- Focus/swap clients
    awful.key({ modkey,         }, "j", function() awful.client.focus.byidx( 1) end, {description="focus next by index",     group="client"}),
    awful.key({ modkey,         }, "k", function() awful.client.focus.byidx(-1) end, {description="focus previous by index", group="client"}),
    awful.key({ modkey, "Shift" }, "j", function()  awful.client.swap.byidx( 1) end, {description="swap with next client by index",     group="client"}),
    awful.key({ modkey, "Shift" }, "k", function()  awful.client.swap.byidx(-1) end, {description="swap with previous client by index", group="client"}),

    -- Manipulate master stack config
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incmwfact( 0.05)          end, {description="increase master width factor",          group="layout"}),
    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incmwfact(-0.05)          end, {description="decrease master width factor",          group="layout"}),
    awful.key({ modkey, "Shift" }, "i", function() awful.tag.incnmaster( 1, nil, true) end, {description="increase the number of master clients", group="layout"}),
    awful.key({ modkey, "Shift" }, "d", function() awful.tag.incnmaster(-1, nil, true) end, {description="decrease the number of master clients", group="layout"}),

    -- Relative tag movement
    awful.key({ modkey, }, "n",   awful.tag.viewnext,        {description="view next",             group="tag"}),
    awful.key({ modkey, }, "b",   awful.tag.viewprev,        {description="view previous",         group="tag"}),
    awful.key({ modkey, }, "Tab", awful.tag.history.restore, {description="view last visited tag", group="tag"}),

    -- Screens
    awful.key({ modkey, }, ",", function() awful.screen.focus_relative(-1) end, {description="focus the previous screen", group="screen"}),
    awful.key({ modkey, }, ".", function() awful.screen.focus_relative( 1) end, {description="focus the next screen",     group="screen"}),

    -- Layouts
    awful.key({ modkey, }, "t", function() awful.layout.set(awful.layout.suit.tile)     end, {description="set to tile layout",        group="layout"}),
    awful.key({ modkey, }, "f", function() awful.layout.set(awful.layout.suit.floating) end, {description="set to floating layout",    group="layout"}),
    awful.key({ modkey, }, "m", function()
        awful.layout.set(awful.layout.suit.max)
        -- Raise the focused window when switching
        if client.focus then client.focus:raise() end
    end, {description="set to monocle layout",     group="layout"}),

    --awful.key({ modkey,           }, "space", function() awful.layout.inc( 1) end, {description="select next",     group="layout"}),
    --awful.key({ modkey, "Control" }, "space", function() awful.layout.inc(-1) end, {description="select previous", group="layout"}),

    --awful.key({ modkey, "Shift" }, "b",
    --    function()
    --        local myscreen = awful.screen.focused()
    --        myscreen.mywibox.visible = not myscreen.mywibox.visible
    --    end, {description="toggle statusbar", group="layout"}),

    -- Prompt
    awful.key({ modkey }, "x",
              function()
                  awful.prompt.run {
                    prompt       = " Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end, {description="lua execute prompt", group="awesome"}),

    -- Volume
    awful.key({ modkey, "Control" }, "Up",   function() awful.spawn.with_shell("pamixer --allow-boost --increase 5 && pamixer --get-volume > \""..xobsock.."\"") end, {description="increase volume", group="volume"}),
    awful.key({ modkey, "Control" }, "Down", function() awful.spawn.with_shell("pamixer --allow-boost --decrease 5 && pamixer --get-volume > \""..xobsock.."\"") end, {description="decrease volume", group="volume"}),
    awful.key({ modkey, "Control" }, "m",    function() awful.spawn.with_shell("pamixer --toggle-mute && { [ \"$(pamixer --get-mute)\" = \"true\" ] && echo 0 >\""..xobsock.."\"; } || pamixer --get-volume >\""..xobsock.."\"") end,              {description="toggle mute",     group="volume"}),

    -- Music control
    awful.key({ modkey, }, "c", function() awful.spawn("cmus-remote -u") end, {description="toggle cmus playback", group="misc"}),

    -- XF86
    awful.key({ }, "XF86AudioRaiseVolume", function() awful.spawn.with_shell("pamixer --allow-boost --increase 5 && pamixer --get-volume > \""..xobsock.."\"") end, {description="increase volume", group="volume"}),
    awful.key({ }, "XF86AudioLowerVolume", function() awful.spawn.with_shell("pamixer --allow-boost --decrease 5 && pamixer --get-volume > \""..xobsock.."\"") end, {description="decrease volume", group="volume"}),
    awful.key({ }, "XF86AudioMute",        function() awful.spawn.with_shell("pamixer --toggle-mute && { [ \"$(pamixer --get-mute)\" = \"true\" ] && echo 0 >\""..xobsock.."\"; } || pamixer --get-volume >\""..xobsock.."\"") end,              {description="toggle mute",     group="volume"}),

    awful.key({ }, "XF86MonBrightnessUp",   function() awful.spawn.with_shell("xbacklight -inc 5 && xbacklight -get >\""..xobsock.."\"") end, {description="increase brightness"}),
    awful.key({ }, "XF86MonBrightnessDown", function() awful.spawn.with_shell("xbacklight -dec 5 && xbacklight -get >\""..xobsock.."\"") end, {description="decrease brightness"}),

    awful.key({ }, "XF86AudioPlay",  function() awful.spawn("cmus-remote --pause") end),
    awful.key({ }, "XF86AudioStop",  function() awful.spawn("cmus-remote --stop" ) end),
    awful.key({ }, "XF86AudioPrev",  function() awful.spawn("cmus-remote --prev" ) end),
    awful.key({ }, "XF86AudioNext",  function() awful.spawn("cmus-remote --next" ) end),

    -- Modes
    awful.key({ modkey, "Shift" }, "m",   function() set_mode("move")        end, {description="enter move mode",    group="mode"}),
    awful.key({ modkey, "Shift" }, "r",   function() set_mode("resize")      end, {description="enter resize mode",  group="mode"}),
    awful.key({ modkey, "Shift" }, "t",   function() set_mode("moretag")     end, {description="enter moretag mode", group="mode"}),
    awful.key({ modkey, "Shift" }, "x",   function() set_mode("mouse")       end, {description="enter mouse mode",   group="mode"}),
    awful.key({ "Mod4"          }, "F11", function() set_mode("passthrough") end, {description="enter passthrough mode", group="mode"})
)

clientkey_modes["default"] = gears.table.join(
    -- Close
    awful.key({ modkey, "Shift" }, "c",      function(c) c:kill()                           end, {description="close client",        group="client"}),

    -- Move screens/top of stack
    awful.key({ modkey, "Shift" }, "Return", function(c) c:swap(awful.client.getmaster())   end, {description="move to master",      group="client"}),
    awful.key({ modkey, "Shift" }, ",",      function(c) c:move_to_screen(c.screen.index-1) end, {description="move to prev screen", group="client"}),
    awful.key({ modkey, "Shift" }, ".",      function(c) c:move_to_screen(c.screen.index+1) end, {description="move to next screen", group="client"}),

    -- Toggle properties
    awful.key({ modkey, "Shift" }, "space",  function(c)
            awful.client.floating.toggle(c)
            c.above = c.floating
        end, {description="toggle floating", group="client"}),
    awful.key({ modkey, "Shift" }, "f", function(c) c.fullscreen = not c.fullscreen; c:raise() end, {description="toggle fullscreen", group="client"}),
    -- awful.key({ modkey, "Control", "Shift" }, "t", function(c) c.ontop = not c.ontop end, {description="toggle keep on top", group="client"}),

    -- Move between neighboring tags
    awful.key({ modkey, "Control", "Shift" }, "b",
        function()
            -- get current tag
            local t = client.focus and client.focus.first_tag or nil
            if t == nil then return end

            -- get previous tag
            local tag = client.focus.screen.tags[(t.name - 2) % #Tags + 1]
            awful.client.movetotag(tag)
        end, {description = "move client to previous tag", group = "layout"}),

    awful.key({ modkey, "Control", "Shift" }, "n",
        function()
            -- get current tag
            local t = client.focus and client.focus.first_tag or nil
            if t == nil then return end

            -- get next tag
            local tag = client.focus.screen.tags[(t.name % #Tags) + 1]
            awful.client.movetotag(tag)
        end, {description = "move client to next tag", group = "layout"})
)
-- }}}

-- MODE: move {{{
globalkey_modes["move"] = gears.table.join(
    awful.key({ modkey, "Shift" }, "m",      function() set_mode("default") end, {description="exit move mode", group="mode"}),
    awful.key({                 }, "Escape", function() set_mode("default") end, {description="exit move mode", group="mode"})
)

clientkey_modes["move"] = gears.table.join(
    awful.key({ modkey            }, "h", function(c) c:relative_move(-10,   0, 0, 0) end, {description="move client left by 20px",  group="client"}),
    awful.key({ modkey            }, "j", function(c) c:relative_move(  0,  10, 0, 0) end, {description="move client down by 20px",  group="client"}),
    awful.key({ modkey            }, "k", function(c) c:relative_move(  0, -10, 0, 0) end, {description="move client up by 20px",    group="client"}),
    awful.key({ modkey            }, "l", function(c) c:relative_move( 10,   0, 0, 0) end, {description="move client right by 20px", group="client"}),

    awful.key({ modkey, "Control" }, "h", function(c) c:relative_move(-1,  0, 0, 0) end, {description="move client left by 1px",  group="client"}),
    awful.key({ modkey, "Control" }, "j", function(c) c:relative_move( 0,  1, 0, 0) end, {description="move client down by 1px",  group="client"}),
    awful.key({ modkey, "Control" }, "k", function(c) c:relative_move( 0, -1, 0, 0) end, {description="move client up by 1px",    group="client"}),
    awful.key({ modkey, "Control" }, "l", function(c) c:relative_move( 1,  0, 0, 0) end, {description="move client right by 1px", group="client"}),

    awful.key({ modkey, "Shift"   }, "h", function(c) c:relative_move(-100,    0, 0, 0) end, {description="move client left by 100px",  group="client"}),
    awful.key({ modkey, "Shift"   }, "j", function(c) c:relative_move(   0,  100, 0, 0) end, {description="move client down by 100px",  group="client"}),
    awful.key({ modkey, "Shift"   }, "k", function(c) c:relative_move(   0, -100, 0, 0) end, {description="move client up by 100px",    group="client"}),
    awful.key({ modkey, "Shift"   }, "l", function(c) c:relative_move( 100,    0, 0, 0) end, {description="move client right by 100px", group="client"})
)
-- }}}

-- MODE: resize {{{
globalkey_modes["resize"] = gears.table.join(
    awful.key({ modkey, "Shift" }, "r",      function() set_mode("default") end, {description="exit resize mode", group="mode"}),
    awful.key({                 }, "Escape", function() set_mode("default") end, {description="exit resize mode", group="mode"})
)

local function resize_window(c, height_change) -- {{{
    local c_idx_data = awful.client.idx(c)

    -- Check if more than one client in column (else terminate early)
    if c_idx_data.num <= 1 then return end

    local other_c = nil
    -- Find client to steal/give space from/to {{{
    do
        local c_last_win = (c_idx_data.idx == c_idx_data.num)

        for _, oc in ipairs(client.get()) do
            local oc_idx_data = awful.client.idx(oc)

            -- Check if same column
            if oc_idx_data.col == c_idx_data.col then
                -- If last window, find previous client
                -- else find next client
                if c_last_win then
                    if oc_idx_data.idx == c_idx_data.idx - 1 then
                        other_c = oc
                        break
                    end
                else
                    if oc_idx_data.idx == c_idx_data.idx + 1 then
                        other_c = oc
                        break
                    end
                end
            end
        end
    end -- }}}

    local wa = c.screen.workarea
    local cg = c:geometry()
    local og = other_c:geometry()

    -- Make sure windows after resize are at least 1px in height {{{
    if height_change > 0 then
        if og.height - height_change < 1 then
            return
        end
    else
        if cg.height + height_change < 1 then
            return
        end
    end -- }}}

    local heights = {}
    -- Read client heights in current column
    for _, oc in ipairs(client.get()) do
        local idx_data = awful.client.idx(oc)
        if idx_data and idx_data.col == c_idx_data.col then
            local g = oc:geometry()
            heights[idx_data.idx] = g.height
        end
    end

    local oc_idx_data = awful.client.idx(other_c)
    -- Set heights
    for _, oc in ipairs(client.get()) do
        local idx_data = awful.client.idx(oc)
        if idx_data and idx_data.col == c_idx_data.col then
            local h = heights[idx_data.idx]

            if idx_data.idx ==  c_idx_data.idx then h = h + height_change end
            if idx_data.idx == oc_idx_data.idx then h = h - height_change end

            h = h + beautiful.border_width * 2

            awful.client.setwfact(h / wa.height, oc)
        end
    end
end -- }}}

local function reset_wfact(c) -- {{{
    local c_idx_data = awful.client.idx(c)
    local wfact = 1 / c_idx_data.num

    for _, oc in ipairs(client.get()) do
        local idx_data = awful.client.idx(oc)

        if idx_data and idx_data.col == c_idx_data.col then
            awful.client.setwfact(wfact, oc)
        end
    end
end -- }}}

clientkey_modes["resize"] = gears.table.join(
    -- Floating window
    awful.key({ modkey            }, "h", function(c) c:relative_move( 0, 0, -10,   0) end, {description="resize client left by 10px",  group="client"}),
    awful.key({ modkey            }, "j", function(c) c:relative_move( 0, 0,   0,  10) end, {description="resize client down by 10px",  group="client"}),
    awful.key({ modkey            }, "k", function(c) c:relative_move( 0, 0,   0, -10) end, {description="resize client up by 10px",    group="client"}),
    awful.key({ modkey            }, "l", function(c) c:relative_move( 0, 0,  10,   0) end, {description="resize client right by 10px", group="client"}),

    awful.key({ modkey, "Control" }, "h", function(c) c:relative_move( 0, 0, -1,  0) end, {description="resize client left by 1px",  group="client"}),
    awful.key({ modkey, "Control" }, "j", function(c) c:relative_move( 0, 0,  0,  1) end, {description="resize client down by 1px",  group="client"}),
    awful.key({ modkey, "Control" }, "k", function(c) c:relative_move( 0, 0,  0, -1) end, {description="resize client up by 1px",    group="client"}),
    awful.key({ modkey, "Control" }, "l", function(c) c:relative_move( 0, 0,  1,  0) end, {description="resize client right by 1px", group="client"}),

    awful.key({ modkey, "Shift"   }, "h", function(c) c:relative_move( 0, 0, -100,    0) end, {description="resize client left by 100px",  group="client"}),
    awful.key({ modkey, "Shift"   }, "j", function(c) c:relative_move( 0, 0,    0,  100) end, {description="resize client down by 100px",  group="client"}),
    awful.key({ modkey, "Shift"   }, "k", function(c) c:relative_move( 0, 0,    0, -100) end, {description="resize client up by 100px",    group="client"}),
    awful.key({ modkey, "Shift"   }, "l", function(c) c:relative_move( 0, 0,  100,    0) end, {description="resize client right by 100px", group="client"}),

    -- Tiled window
    awful.key({ modkey            }, "i", function(c) resize_window(c,   10) end, {description="increase client window factor by 10px", group="client"}),
    awful.key({ modkey            }, "d", function(c) resize_window(c,  -10) end, {description="decrease client window factor by 10px", group="client"}),

    awful.key({ modkey, "Control" }, "i", function(c) resize_window(c,    1) end, {description="increase client window factor by 1px", group="client"}),
    awful.key({ modkey, "Control" }, "d", function(c) resize_window(c,   -1) end, {description="decrease client window factor by 1px", group="client"}),

    awful.key({ modkey, "Shift"   }, "i", function(c) resize_window(c,  100) end, {description="increase client window factor by 100px", group="client"}),
    awful.key({ modkey, "Shift"   }, "d", function(c) resize_window(c, -100) end, {description="decrease client window factor by 100px", group="client"}),

    awful.key({ modkey,           }, "r", function(c) reset_wfact(c) end, {description="decrease client window factor by 100px", group="client"})
)
-- }}}

-- MODE: passthrough {{{
globalkey_modes["passthrough"] = gears.table.join(
    awful.key({ "Mod4" }, "F11", function() set_mode("default") end, {description="exit passthrough mode", group="mode"})
)

clientkey_modes["passthrough"] = {}
-- }}}

-- MODE: moretag {{{
globalkey_modes["moretag"] = gears.table.join(
    awful.key({ modkey, "Shift" }, "t",      function() set_mode("default") end, {description="exit moretag mode", group="mode"}),
    awful.key({                 }, "Escape", function() set_mode("default") end, {description="exit moretag mode", group="mode"})
)

clientkey_modes["moretag"] = {}

-- Tags 11-32
for i = 11, 32 do
    local keys = gen_tag_keys(i, string.char(string.byte("a") + (i - 11)))
    globalkey_modes["moretag"] = gears.table.join(globalkey_modes["moretag"], keys)
end

-- }}}

-- MODE: mouse {{{
globalkey_modes["mouse"] = gears.table.join(
    awful.key({ modkey, "Shift" }, "x",      function() set_mode("default") end, {description="exit mouse mode", group="mode"}),
    awful.key({                 }, "Escape", function() set_mode("default") end, {description="exit mouse mode", group="mode"}),

    awful.key({ }, "h", function() awful.spawn("ydotool mousemove -- -20   0") end, {description="move mouse left by 20px",  group="mouse"}),
    awful.key({ }, "j", function() awful.spawn("ydotool mousemove --   0  20") end, {description="move mouse down by 20px",  group="mouse"}),
    awful.key({ }, "k", function() awful.spawn("ydotool mousemove --   0 -20") end, {description="move mouse up by 20px",    group="mouse"}),
    awful.key({ }, "l", function() awful.spawn("ydotool mousemove --  20   0") end, {description="move mouse right by 20px", group="mouse"}),

    awful.key({ "Control" }, "h", function() awful.spawn("ydotool mousemove -- -5  0") end, {description="move mouse left by 5px",  group="mouse"}),
    awful.key({ "Control" }, "j", function() awful.spawn("ydotool mousemove --  0  5") end, {description="move mouse down by 5px",  group="mouse"}),
    awful.key({ "Control" }, "k", function() awful.spawn("ydotool mousemove --  0 -5") end, {description="move mouse up by 5px",    group="mouse"}),
    awful.key({ "Control" }, "l", function() awful.spawn("ydotool mousemove --  5  0") end, {description="move mouse right by 5px", group="mouse"}),

    awful.key({ "Shift"   }, "h", function() awful.spawn("ydotool mousemove -- -100    0") end, {description="move mouse left by 100px",  group="mouse"}),
    awful.key({ "Shift"   }, "j", function() awful.spawn("ydotool mousemove --    0  100") end, {description="move mouse down by 100px",  group="mouse"}),
    awful.key({ "Shift"   }, "k", function() awful.spawn("ydotool mousemove --    0 -100") end, {description="move mouse up by 100px",    group="mouse"}),
    awful.key({ "Shift"   }, "l", function() awful.spawn("ydotool mousemove --  100    0") end, {description="move mouse right by 100px", group="mouse"}),

    awful.key({ "Control", "Shift" }, "h", function() awful.spawn("ydotool mousemove -- -1  0") end, {description="move mouse left by 1px",  group="mouse"}),
    awful.key({ "Control", "Shift" }, "j", function() awful.spawn("ydotool mousemove --  0  1") end, {description="move mouse down by 1px",  group="mouse"}),
    awful.key({ "Control", "Shift" }, "k", function() awful.spawn("ydotool mousemove --  0 -1") end, {description="move mouse up by 1px",    group="mouse"}),
    awful.key({ "Control", "Shift" }, "l", function() awful.spawn("ydotool mousemove --  1  0") end, {description="move mouse right by 1px", group="mouse"}),

    awful.key({ }, "1", function() awful.spawn("xdotool click --clearmodifiers 1") end, {description="click left mouse button",   group="mouse"}),
    awful.key({ }, "2", function() awful.spawn("xdotool click --clearmodifiers 2") end, {description="click middle mouse button", group="mouse"}),
    awful.key({ }, "3", function() awful.spawn("xdotool click --clearmodifiers 3") end, {description="click right mouse button",  group="mouse"}),
    awful.key({ }, "4", function() awful.spawn("xdotool click --clearmodifiers 5") end, {description="scroll down", group="mouse"}),
    awful.key({ }, "5", function() awful.spawn("xdotool click --clearmodifiers 4") end, {description="scroll up",   group="mouse"}),

    awful.key({ }, "d", function() awful.spawn.with_shell("xdotool mousedown 1") end, {description="press down left mouse button", group="mouse"}),
    awful.key({ }, "u", function() awful.spawn.with_shell("xdotool mouseup 1")   end, {description="release left mouse button",    group="mouse"}),

    -- Allow client switching for convienience
    awful.key({ modkey, }, "j", function() awful.client.focus.byidx( 1) end, {description="focus next by index",     group="client"}),
    awful.key({ modkey, }, "k", function() awful.client.focus.byidx(-1) end, {description="focus previous by index", group="client"})
)

clientkey_modes["mouse"] = {}
-- }}}

-- Tags 1-10
for i = 1, 10 do
    local keys = gen_tag_keys(i, tostring(i % 10))
    globalkey_modes["default"] = gears.table.join(globalkey_modes["default"], keys)
    globalkey_modes["moretag"] = gears.table.join(globalkey_modes["moretag"], keys)
    globalkey_modes["mouse"]   = gears.table.join(globalkey_modes["mouse"],   keys)
end

-- Lock screen
local lock_modes = { "default", "moretag" }
for _,m in ipairs(lock_modes) do
    globalkey_modes[m] = gears.table.join(
        globalkey_modes[m],
        awful.key({ modkey, }, "l", function()
            set_mode("default")
            awful.spawn("dash " .. os.getenv("HOME") .. "/.local/bin/lock.sh")
        end, {description="lock screen", group="lock"})
    )
end

M.globalkeys = globalkey_modes["default"]
M.clientkeys = clientkey_modes["default"]
M.mode = "default"

return M
