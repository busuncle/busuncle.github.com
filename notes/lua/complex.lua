-- a module for testing "module" function
module("complex", package.seeall)

function new(r, i) 
    return {r=r, i=i}
end

i = new(0, 1)

function add(c1, c2)
    return new(c1.r + c2.r, c1.i + c2.i)
end

function sub(c1, c2)
    return new(c1.r - c2.r, c1.i - c2.i)
end


--[[ 
    usage: 
    require "module_name"
    c = complex.new(1,2)
    print(c.r)  -- 1
    print(c.i)  -- 2
--]]
