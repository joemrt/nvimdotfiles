--[[
This file will be required in init.vim as "general"
package. Put here any lua configuration that 
should apply for various filetypes and that ought to be
loaded on startup
--]]

-- Will be returned when requiring the "general"
-- package
return_table = {}


function return_table.update_cwd(changing_command)
	-- Change to the directory of current file
	-- `changing_command`: either "cd" or "lcd"
	local current_filetype = vim.api.nvim_buf_get_option(0,'filetype')
	-- for netrw do not remove head
	if current_filetype == 'netrw'
	then
		vim.api.nvim_command(changing_command .. vim.fn.expand('%:p'))
	else
		vim.api.nvim_command(changing_command .. vim.fn.expand('%:p:h'))
	end
end

return return_table
