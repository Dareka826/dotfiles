
-- Imports
local layout   = require("layouts")
local keyboard = require("keyboard")
local graphics = require("graphics")

-- Global state
local all_keyboards = {}
local all_outputs   = {}
local all_views     = {}

-- BG color
kiwmi:bg_color("#222222")

local config = {
    screen_padding = { top = 20+10, left =  0+10, bottom =  0+10, right =  0+10 },
    -- window_margin  = { top =  0, left =  0, bottom =  0, right =  0 },
    border_width = 2,
    border_color = "#6600ff",
    layouts = {
        layout.layouts.maximized,
        layout.layouts.tiling_left,
    },
    selected_layout = 1,
    view_idx = 1,
}

-- Recalculate the positions of all windows and focus
local function update_layout()
    -- Chek if view_idx valid
    if #all_views < 1 then return end
    if config.view_idx > #all_views then config.view_idx = #all_views end
    if config.view_idx < 1 then config.view_idx = 1 end

    -- A view was added/destroyed
    local sel = config.layouts[config.selected_layout]
    local scr_w, scr_h = all_outputs[1]:size()

    local cfg = sel(all_views, config.view_idx, {
        screen_size = { width = scr_w, height = scr_h },
        screen_padding = config.screen_padding,
        -- window_margin = {},
    })

    for _,v in pairs(cfg.hide) do v:hide() end
    for _,v in pairs(cfg.show) do v:show() end

    local bw = config.border_width
    for i,g in pairs(cfg.geometry) do
        all_views[i]:move(
            g.x + bw,
            g.y + bw
        )
        all_views[i]:resize(
            g.w - 2 * bw,
            g.h - 2 * bw
        )
    end

    if #all_views >= config.view_idx then
        all_views[config.view_idx]:focus()
    end
end

-- Keybindings
local global_keys = {
    { mods = { super = true, shift = true }, key = "q",      action = function() kiwmi:quit() end },
    { mods = { super = true },               key = "d",      action = function() kiwmi:spawn("bemenu-run -l 10 -i --nb '#111111' --nf '#ffffff' --ab '#111111' --af '#ffffff' --hb '#6600ff' --hf '#ffffff' --tb '#6600ff' --tf '#ffffff' --fb '#111111' --ff '#ffffff'") end },
    { mods = { super = true },               key = "Return", action = function() kiwmi:spawn("foot") end },
    { mods = { super = true },               key = "j",      action = function()
        if config.view_idx > 1 then
            config.view_idx = config.view_idx - 1
            update_layout()
        end
    end },
    { mods = { super = true },               key = "k",      action = function()
        if config.view_idx < #all_views then
            config.view_idx = config.view_idx + 1
            update_layout()
        end
    end },
}

-- Handle arrays with stuff {{{
-- Handle keyboards array {{{
kiwmi:on("keyboard", function(kbd)
    print("[I]: New keyboard!")
    -- Add keyboard
    table.insert(all_keyboards, kbd)
    keyboard.bind_keybindings(kbd, global_keys)

    kbd:on("destroy", function()
        print("[I]: Destroying a keyboard!")
        -- Find keyboard in list and remove
        for i,k in pairs(all_keyboards) do
            if k == kbd then
                table.remove(all_keyboards, i)
                break
            end
        end
    end)
end) -- }}}

-- Handle outputs array {{{
kiwmi:on("output", function(out)
    print("[I]: New output!")
    -- Add output
    table.insert(all_outputs, out)

    out:on("destroy", function()
        print("[I]: Destroying an output!")
        -- Find output in list and remove
        for i,o in pairs(all_outputs) do
            if o == out then
                table.remove(all_outputs, i)
                break
            end
        end
    end)
end) -- }}}

-- Handle views array {{{
kiwmi:on("view", function(view)
    print("[I]: New view!")
    -- Add view
    table.insert(all_views, view)

    -- Focus newest view
    config.view_idx = #all_views

    update_layout()

    view:on("destroy", function()
        print("[I]: Destroying a view!")
        -- Find view in list and remove
        for i,v in pairs(all_views) do
            if v == view then
                table.remove(all_views, i)
                break
            end
        end

        update_layout()
    end)

    view:on("post_render", function(data)
        local bw = config.border_width
        local g = {}
        g.x, g.y = view:pos()
        g.w, g.h = view:size()

        graphics.draw_border(data.renderer, {
            x = g.x - bw,
            y = g.y - bw,
            w = g.w + 2 * bw,
            h = g.h + 2 * bw,
        }, config.border_color, bw)
    end)
end) -- }}}
-- }}}

-- kiwmi:on("request_active_output", nil)
