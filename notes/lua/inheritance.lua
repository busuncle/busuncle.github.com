Window = {}
Window.prototype = {x = 0, y = 0, width = 100, height = 100}
Window.mt = {}
function Window.new(o)
    setmetatable(o, Window.mt)
    return o
end
Window.mt.__index = Window.prototype
-- another method
--Window.mt.__index = function(table, key)
--    return Window.prototype[key]
--end

-- another example
Account = {balance = 0}
function Account:new(acct)
    acct = acct or {}
    setmetatable(acct, self)
    self.__index = self
    return acct
end

function Account:deposit(v)
    self.balance = self.balance + v
end

function Account:withdraw(v)
    if v > self.balance then
        error "insufficient funds"
    end
    self.balance = self.balance - v
end

-- a special account inherit account
SpecialAccount = Account:new()
-- rewrite some method
function SpecialAccount:withdraw(v)
    if v - self.balance > self.overdraft then
        local err = "insufficient funds, overdraft is " .. self.overdraft
        error(err)
    end
    self.balance = self.balance - v
end
--[[
    usage:
    s = SpecialAccount:new{overdraft=100}
    s:withdraw(1000)
    and then it will come up with the error written in SpecialAccount:withdraw
--]]
