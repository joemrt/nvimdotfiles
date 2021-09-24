--[[
Lua configuration for latex files.
Will be loaded after tex.vim
--]]

-- create item/itemize list
function print_item_of_line()
	local current_line_number = vim.fn.line('.')
	local current_line = vim.fn.getline('.')
	-- check if line contains item
	if vim.fn.match(current_line, "\\s*\\\\item") ~= -1
	then
		-- strip off everyting after the item
		-- and append to the next line
		local item_of_line = vim.fn.substitute(
				current_line,
				"\\\\item.*$",
				"\\\\item ", "g")   
		vim.fn.append(current_line_number,
		item_of_line)
		-- move after the new item
		vim.cmd('normal! jA')
	else
		-- create itemize environment
		vim.fn.append(current_line_number,
		{"\\begin{itemize}",
					"	\\item ",
					"\\end{itemize}"})
		-- move after the first item
		vim.cmd('normal! 2jA')
	end
end

-- mappings
vim.api.nvim_set_keymap('i','<Leader>#', '<esc>:lua print_item_of_line()<cr>A', {noremap=true, silent=true})
vim.api.nvim_set_keymap('n','<Leader>#', ':lua print_item_of_line()<cr>A', {noremap=true, silent=true})
