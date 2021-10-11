local return_table = {}

function return_table.SendStringToTmux(input)
	-- Send string 
	-- to g:python_tmux_window
	local python_window = vim.api.nvim_get_var('python_tmux_window')
	os.execute('tmux send-keys -t ' .. python_window ..
	' C-c Escape "O" Escape "i" "' .. input ..  '" Enter Enter')
end

return return_table
