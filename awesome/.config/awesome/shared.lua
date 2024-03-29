local M = {}

-- Default terminal
M.terminal = "alacritty"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
M.modkey = "Mod1"

M.tags = {}
for i = 1,32 do
    table.insert(M.tags, tostring(i))
end

M.xobsock = os.getenv("XDG_RUNTIME_DIR") .. "/xob.sock"

return M
