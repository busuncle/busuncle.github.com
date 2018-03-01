-- first line, create this table, name it what you want, _M is good
local _M = {}

_M.sub_module_a = {}
function _M.function_a()
    return "this is a function of the module"
end

-- the last line, return this table
return _M


--[[
--  usage: 
--  local m = require "my_module"
--  print(m.function_a())
--]]
