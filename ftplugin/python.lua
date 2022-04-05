--[[
Lua configuration for python files.
Will be loaded after python.vim
--]]





-- DAP settings 
-- ----------
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
vim.api.nvim_set_keymap('n', '<Leader>df', ':lua require"dap".continue()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dc', ':lua close_debugger()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dx', ':lua require"dap".close()<CR>:lua print("Debugging closed") <cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>db', ':lua require"dap".toggle_breakpoint()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>di', ':lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dB', ':lua require"dap".clear_breakpoints()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dL', ':lua require"dap".list_breakpoints()<CR>:copen <CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>ds', ':lua require"dap".repl.toggle()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dn', ':lua require"dap".down()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dp', ':lua require"dap".up()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>dj', ':lua require"dap".step_over()<CR>', { noremap = true, silent = true })

-- Reloading modules
-- -----------------

-- for tmux integration
local tmux = require('tmux_interaction')


-- first HeadSize lines will be considered
local HeadSize=100

-- scan head and return a string with reload statements
function CreateReloadString()
	-- Scans HeadSize of py Module	
	-- and returns string of imported modules
	local HeadString = vim.api.nvim_buf_get_lines(
		0,0,HeadSize,false)
	local ImportString = {}	
	table.insert(ImportString, "from importlib import reload")
	for key, value in pairs(HeadString) do
		if value:match("^import ") or value:match("^from ") then
			import_value = vim.fn.substitute(value,
			"^\\(import\\|from\\)\\s\\+\\(\\S*\\).*$","import \\2; reload(\\2)","")
			table.insert(ImportString, import_value)
		end
	end
	ImportString = table.concat(ImportString, '\n')
	return ImportString
end

-- combine with tmux integration
function SendReloadToTmux()
	-- Send string with reloading of modules
	-- to g:python_tmux_window
	tmux.SendStringToTmux(CreateReloadString())
end

