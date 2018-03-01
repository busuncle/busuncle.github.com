local socket = require("socket")

local RECV_MAX = 1024


local sock = assert(socket.connect("127.0.0.1", 1234))
print("connect success")


function receive(conn)
    conn:settimeout(0)
    local recv, status, partial = conn:receive(RECV_MAX)
    if status == "timeout" then
        coroutine.yield(conn)
    end

    return status, recv or partial
end


threads = {}

cnt = 0

while true do
    --local x = io.read()
    local x = ""
    if cnt > 180 then
        x = "send x at " .. socket.gettime()
        cnt = 0
    end 

    if #x > 0 then
        sock:send(x)
        local co = coroutine.create(function(conn)
            local status, recv = receive(conn)             
            if #recv > 0 then
                print("recv: " .. recv)
            end
        end)
        table.insert(threads, co)
    end

    for i, co in pairs(threads) do
        local status, res = coroutine.resume(co, sock)
        if not status then
            threads[i] = nil
        end
    end

    cnt = cnt + 1

    socket.sleep(1/60) -- 60FPS
end
