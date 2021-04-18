local return_table = {}

function return_table.pipe(input, cmd)
	local tmpname = os.tmpname()
	local inhandle = io.popen(cmd .. ' |  cat > ' .. tmpname, 'w')
	inhandle:write(input)
	inhandle:close()
	outputhandle = io.open(tmpname)
	output = outputhandle:read('*a')
	outputhandle:close()
	os.remove(tmpname)
	return output
end

function return_table.halfpipe(cmd)
	local outputhandle = io.popen(cmd, 'r')
	output = outputhandle:read('*a')
	outputhandle:close()
	return output
end

return return_table
