local _M = {}

_M.urlopen = function(url)
	--[[ 
		a very simple urlopen function used in ngx_lua.
		add "resolver 8.8.8.8;" to http block in nginx.conf before using this.
		usage:
		local res, err = urllib.urlopen("http://www.baidu.com/s?wd=openresty")
		if not res then
			ngx.say(err)
			return
		end
		ngx.say(res)
	--]]

	local req, get_file, host, port, raw_req
	local from, to, err = ngx.re.find(url, "^http://")
	if from then
		raw_req = string.sub(url, to + 1, #url)
	else 
		raw_req = url
	end

	from, to, err = ngx.re.find(raw_req, "/")
	if from then
		req = string.sub(raw_req, 1, from - 1)
		get_file = string.sub(raw_req, to, #raw_req)
	else
		req = raw_req
		get_file = "/"
	end

	from, to, err = ngx.re.find(req, ":")
	if from then
		host = string.sub(req, 1, from - 1)
		port = string.sub(req, to + 1, #req)
	else
		host = req
		port = 80
	end

	local sock = ngx.socket.tcp()
	sock:settimeout(1000)
	local ok, err = sock:connect(host, port)
	if not ok then
		return nil, "failed to connect: " .. err
	end

	sock:send(string.format("GET %s HTTP/1.0\r\nHost: %s\r\n\r\n", get_file, host))
	local read_headers = sock:receiveuntil("\r\n\r\n")
	headers, err = read_headers()
	if not headers then
		return nil, "failed to read response headers: " .. err
	end

	local body, err = sock:receive("*a")
	if not body then
		return nil, "failed to read response body: " .. err
	end	

	return body, nil
end

_M.urlopen2 = function(url, params)
	--[[
		a wrapper for urlopen
		usage: local res, err = urllib.urlopen("http://www.baidu.com/s", {wd="openresty"})
		return the same as urlopen
	--]]
	if #params > 0 then
		local params_string = (function()
			local arr = {}
			table.foreach(params, function(k, v)
				arr[#arr + 1] = string.format("%s=%s", k, v)
			end)
			return table.concat(arr, "&")
		end)()
		return _M.urlopen(string.format("%s?%s", url, params_string))
	else
		return _M.urlopen(url)
	end
end

return _M
