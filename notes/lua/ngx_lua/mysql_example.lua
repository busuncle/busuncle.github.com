local cjson = require "cjson"
local mysql = require "resty.mysql"

local db, err = mysql:new()
if not db then
    ngx.say("failed to init mysql: ", err)
    return
end

db:set_timeout(10000)
local ok, err, errno, sqlstate = db:connect{
    host = "127.0.0.1",
    port = 3306,
    database = "test",
    user = "test",
    password = "abcd1234",
    max_packet_size = 1024 * 1024}

if not ok then
    ngx.say("failed to connect: ", err, ": ", errno, " ", sqlstate)
    return
end

local res, err, errno, sqlstate = db:query("select * from user")
ngx.say("result: ", cjson.encode(res))
