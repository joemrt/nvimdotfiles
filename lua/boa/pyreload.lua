local return_table = {}

local mio=require('mio')
local HeadSize=100

function return_table.ScanHeadForPackages()
	-- Scanes HeadSize of py Module	
	-- and returns string of imported modules
	local HeadString = table.concat(
		vim.api.nvim_buf_get_lines(
			0,0,HeadSize,false), "\n")
	local piped_string = mio.pipe(HeadString, 
			"sed -nE 's/^(import|from)" ..
			"[[:space:]]+([[:alnum:]]+).*$/" ..
			"\\2/p'")
	return piped_string
end

function return_table.ReloadString()
	-- Turns imported modules in a
	-- string to launch reloading 
	-- within python
	local PackageString = return_table.ScanHeadForPackages()
	PackageString = string.gsub(PackageString,
		'(%w+)','import %1; reload(%1)' )
	local ReloadString = "from importlib import reload\n" .. PackageString
	return ReloadString
end

return return_table
