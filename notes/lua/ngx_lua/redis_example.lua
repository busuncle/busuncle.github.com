local constant = require("constant")
local setting = require("setting")
local cjson = require "cjson"
local cfg = require("config")
local redis = require "resty.redis"


local red = redis:new()
local ok, err = red:connect(cfg.REDIS.HOST, cfg.REDIS.PORT)
if not ok then
    ngx.log(ngx.ERR, "fail to connect redis: " .. err)
    return
end


local app, udid, source = ngx.var.arg_app, ngx.var.arg_udid, ngx.var.arg_source 

if app == nil or udid == nil or source == nil then
    ngx.exit(ngx.HTTP_NOT_FOUND)
    return
end

local source_id = setting.SOURCE[source]
if source_id == nil then
    ngx.exit(ngx.HTTP_NOT_FOUND)
    return
end

local app_id = setting.APP[app]
if app_id == nil then
    ngx.exit(ngx.HTTP_NOT_FOUND)
    return
end


red:select(setting.USER_DB)
local key = udid
local access_time, err = red:hget(key, "access_time")
if not access_time or access_time == ngx.null then
    red:multi()
    red:hmset(key,
        "source", source,
        "access_time", ngx.localtime(),
        "ip", ngx.var.remote_addr,
        "app", app)
    red:expire(key, setting.ACCESS_EXPIRE_TIME)
    red:exec()
end

