--[[
Lua configuration for python files.
Will be loaded after python.vim
--]]


-- DAP settings 
function find_python_interpreters()
	local python_interpreters = {}
	-- get interpreter via which
	python_interpreters.env_int = vim.fn.substitute(vim.fn.system('which python'),"\n","","g")
	-- take debugpy env if local (i.e. if path includes "home")
	if string.find(python_interpreters.env_int, "home") then
		python_interpreters.debugpy_int = vim.fn.substitute(python_interpreters.env_int, "[^/]*/bin/python", "debugpy/bin/python", "g") 
	end
	return python_interpreters
end

local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = find_python_interpreters().debugpy_int;
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    -- The first three options are required by nvim-dap
    type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
    request = 'launch';
    name = "Launch file";

    -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

    program = "${file}"; -- This configuration will launch the current file if used.
    pythonPath = function()
    	return find_python_interpreters().env_int
    end;
  },
}

function open_debugger()
	debugged_file = vim.fn.expand('%:p')
	-- start/continue debugging
	require("dap").continue()
end

function close_debugger()
	-- close debugger
	require('dap').close()
	-- return
	if debugged_file ~= nil then
		vim.api.nvim_command('edit ' ..
		    debugged_file)
	end
	debugged_file = nil
	print('Debugging closed')
end

-- set mappings
vim.api.nvim_set_keymap('n', '<Leader>dd', ':lua open_debugger()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dc', ':lua close_debugger()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>db', ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dx', ':lua require"dap".repl.toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dn', ':lua require"dap".down()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dp', ':lua require"dap".up()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dj', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })
