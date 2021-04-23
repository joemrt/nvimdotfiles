local return_table = {}

local pyreload = require('boa.pyreload')

function return_table.SendStringToTmux(input)
	-- Send string 
	-- to g:python_tmux_window
	local python_window = vim.api.nvim_get_var('python_tmux_window')
	os.execute('tmux send-keys -t ' .. python_window ..
	' C-c Escape "O" Escape "i" "' .. input ..  '" Enter Enter')
end


function return_table.SendReloadToTmux()
	-- Send string with reloading of modules
	-- to g:python_tmux_window
	local ReloadString = pyreload.ReloadString()
	return_table.SendStringToTmux(ReloadString)
end

return return_table
