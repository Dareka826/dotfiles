local ret = {}

-- Draw a border
function ret.draw_border(renderer, geometry, color, width) -- {{{
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

return ret
