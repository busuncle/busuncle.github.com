local producer, consumer
local socket = require("socket")

local function receieve()
    local status, value = coroutine.resume(producer)
    return value
end

local function send(x)
    coroutine.yield(x)
end

producer = coroutine.create(
    function ()
        while true do
            local x = io.read()
            send(x)
        end
    end
)

consumer = coroutine.create(
    function ()
        while true do
            local x = receieve()
            if #x > 0 then
                socket.sleep(1) -- simulate a calculating time
                print("receieve " .. x)
            end
        end
    end
)

-- call consumer to start the program
coroutine.resume(consumer)
