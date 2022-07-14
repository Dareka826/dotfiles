local ret = {}

function ret.bind_keybindings(kbd, keys) -- {{{
    kbd:on("key_down", function(data)
        if data.raw == true then

            local modifiers = kbd:modifiers()
            -- Check all keybindings
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
            end

        end
    end)
end -- }}}

return ret
