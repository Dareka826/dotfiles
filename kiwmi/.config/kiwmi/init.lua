kiwmi:bg_color("#222222")
-- kiwmi:spawn("foot")

-- Keybindings
local global_keys = {
    { mods = { super = true, shift = true }, key = "q",      action = function() kiwmi:quit() end },
    { mods = { super = true },               key = "d",      action = function() kiwmi:spawn("bemenu-run") end },
    { mods = { super = true },               key = "Return", action = function() kiwmi:spawn("foot") end }
}

-- Utils {{{

-- Bind the global_keys to a keyboard
local function bind_keybindings(kbd, keys) -- {{{
    kbd:on("key_down", function(data)
        if data.raw == true then

            local modifiers = kbd:modifiers()
            -- Check all keybindings {{{
            for _,keybinding in pairs(keys) do
                -- Check key
                if keybinding.key == data.key then
                    local is_valid = true

                    -- Check modifier keys
                    for mod,state in pairs(modifiers) do
                        if (keybinding.mods[mod] or false) ~= state then
                            is_valid = false
                            break
                        end
                    end

                    -- This is the one
                    if is_valid == true then
                        keybinding.action()
                        return true -- Prevent propagation
                    end
                end
            end -- }}}

        end
    end)
end -- }}}

-- Draw a border
local function draw_border(renderer, geometry, color, width) -- {{{
    -- Top
    renderer:draw_rect(
        color,
        geometry.x, geometry.y,
        geometry.w, width
    )
    -- Left
    renderer:draw_rect(
        color,
        geometry.x, geometry.y,
        width,      geometry.h
    )
    -- Bottom
    renderer:draw_rect(
        color,
        geometry.x, geometry.y + geometry.h - width,
        geometry.w, width
    )
    -- Right
    renderer:draw_rect(
        color,
        geometry.x + geometry.w - width, geometry.y,
        width,                           geometry.h
    )
end -- }}}

-- }}}

-- Global state
local all_keyboards = {}
local all_outputs   = {}
local all_views     = {}

local config = {
    screen_padding = { top = 20, left =  0, bottom =  0, right =  0 },
    window_margin  = { top =  0, left =  0, bottom =  0, right =  0 },
    border_width = 2,
    border_color = "#6600ff",
}

-- Handle arrays with stuff {{{
-- Handle keyboards array {{{
kiwmi:on("keyboard", function(kbd)
    print("[I]: New keyboard!")
    -- Add keyboard
    table.insert(all_keyboards, kbd)
    bind_keybindings(kbd, global_keys)

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

    if all_outputs[1] ~= nil then
        local screen_w, screen_h = all_outputs[1]:size()

        if view:hidden() == true then
            view:show()
            view:focus()

            local win_geometry = {
                x = config.screen_padding.left,
                y = config.screen_padding.top,
                w = screen_w - (config.screen_padding.left + config.screen_padding.right),
                h = screen_h - (config.screen_padding.top  + config.screen_padding.bottom)
            }

            -- Draw a border after the window
            view:on("post_render", function(data)
                draw_border(data.renderer, win_geometry, config.border_color, config.border_width)
            end)

            view:move(
                win_geometry.x + config.border_width,
                win_geometry.y + config.border_width
            )
            view:resize(
                win_geometry.w - 2 * config.border_width,
                win_geometry.h - 2 * config.border_width
            )
        end
    end

    view:on("destroy", function()
        print("[I]: Destroying a view!")
        -- Find view in list and remove
        for i,v in pairs(all_views) do
            if v == view then
                table.remove(all_views, i)
                break
            end
        end

        if #all_views > 0 then
            all_views[#all_views]:focus()
        end
    end)
end) -- }}}
-- }}}

-- kiwmi:on("request_active_output", nil)
