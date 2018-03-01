print("test_c_call_lua.lua has been loaded")


function no_param_print()
	print("this is no_param_print")
end


function print_str(str)
	print("str input: " .. str)
end


function add(x, y)
	return x + y
end

function two_return_values(x)
	return x + 1, x - 1
end
