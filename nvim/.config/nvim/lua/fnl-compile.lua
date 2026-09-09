local confdir = vim.fn.stdpath('config')
local fnldir = confdir .. '/fnl'
local compiledir = confdir .. '/lua/fnl'

local fennelpath = os.getenv("HOME") .. '/.local/pkg/fennel/current/fennel.lua'

if not vim.uv.fs_stat(fnldir) then
  return nil
end

local files_string = vim.fn.system({
  'find', fnldir, '-type', 'f', '-iname', '*.fnl'
})
if vim.v.shell_error ~= 0 then
  vim.api.nvim_echo({
    { "`find' failed while searching for `*.fnl' in `" .. fnldir .. "'.", "ErrorMsg" },
    { "\nPress any key to exit..." },
  }, true, {})
  vim.fn.getchar()
  os.exit(1)
end

local files = {}
for path in files_string:gmatch('(.-)\n') do
  table.insert(files, path)
end

local function escape_pattern(str)
  return (str:gsub('[%^%$%(%)%%%.%[%]%*%+%-%?]', '%%%1'))
end
local function escape_repl(str)
  return (str:gsub('%%', '%%%%'))
end

local fennel = nil

for _, fnl_path in ipairs(files) do
  local lua_path = fnl_path:gsub('^' .. escape_pattern(fnldir), escape_repl(compiledir))
  local lua_stat = vim.uv.fs_stat(lua_path)

  local do_compile = false

  if not lua_stat then
    do_compile = true
  else
    local fnl_stat = vim.uv.fs_stat(fnl_path)

    if not fnl_stat then
      vim.api.nvim_echo({
        { "Failed to stat `" .. fnl_path .. "'.", "ErrorMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end

    if ((fnl_stat.mtime.sec > lua_stat.mtime.sec) or (fnl_stat.mtime.sec == lua_stat.mtime.sec and fnl_stat.mtime.nsec > lua_stat.mtime.nsec)) then
      do_compile = true
    end
  end

  if do_compile then
    if not vim.uv.fs_stat(compiledir) then
      if not vim.uv.fs_mkdir(compiledir, tonumber('755', 8)) then
        vim.api.nvim_echo({
          { "Failed to mkdir `" .. compiledir .. "'.", "ErrorMsg" },
          { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
      end
    end

    if not fennel then
      package.path = package.path .. ';' .. fennelpath
      fennel = require('fennel')
    end

    vim.print("Compiling `" .. fnl_path:gsub('^' .. escape_pattern(confdir .. '/'), '') .. "'...")

    local lua_out = fennel.compile(fnl_path)
    if not lua_out then
      vim.api.nvim_echo({
        { "Failed to compile `" .. fnl_path .. "'.", "ErrorMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end

    local lua_fh = io.open(lua_path, "w")
    if not lua_fh then
      vim.api.nvim_echo({
        { "Failed to open `" .. lua_path .. "'.", "ErrorMsg" },
        { "\nPress any key to exit..." },
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end

    lua_fh:write(lua_out)
    lua_fh:close()
  end
end
