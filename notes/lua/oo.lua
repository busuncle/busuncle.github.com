Hero = {}

function Hero:new(p)
    local hero = p or {name="hero", hp=100, att=20}
    self.__index = self
    return setmetatable(hero, self)
end

function Hero:to_string()
    return "name: " .. self.name .. " hp: " .. self.hp .. " att: " .. self.att
end


Renne = Hero:new{name="renne", hp=300, att=30}

function Renne:new()
    local renne = {age=12}
    self.__index = self
    return setmetatable(renne, self)
end

function Renne:to_string()
    return "name: " .. self.name .. " hp: " .. self.hp .. " att: " .. self.att .. " age: " .. self.age
end


local h1 = Hero:new()
print(h1:to_string())

local h2 = Hero:new{name="busuncle", hp=300, att=100}
print(h2:to_string())

local renne = Renne:new()
print(renne:to_string())
