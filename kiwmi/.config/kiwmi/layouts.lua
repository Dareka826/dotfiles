local ret = { layouts = {} }

--[[
-- Layout functions
--
-- Each function gets a list of views, which view index is focused and
-- ???. Based on that, it returns the positions and sized of windows to apply.
--]]

-- Hide all views except the focused one
function ret.layouts.maximized(views, idx, config)
    -- TODO: assert
    local ret = { hide = {}, show = {}, geometry = {} }

    -- Which views to hide
    for i,v in pairs(views) do
        if i ~= idx then
            table.insert(ret.hide, v)
        end
    end

    -- Which views to show
    table.insert(ret.show, views[idx])

    local ss = config.screen_size
    local sp = config.screen_padding
    -- local wm = config.window_margin

    -- Size & pos
    for i,_ in ipairs(views) do
        ret.geometry[i] = {
            x = sp.left,
            y = sp.top,
            w = ss.width  - (sp.left + sp.right),
            h = ss.height - (sp.top  + sp.bottom),
        }
    end

    return ret
end

function ret.layouts.tiling_left(views, idx, config)
end

return ret
