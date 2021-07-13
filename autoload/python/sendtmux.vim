
function! python#sendtmux#CheckForjk()
	" Checks if jk is used in file
	" as this migth cause conflict
	" with the ipython shell
	if search('jk') !=# 0
		echom 'jk was found, before using tmux edit ~/.ipython/profile_default/startup/keybindings.py!'
	endif
endfunction


function! python#sendtmux#SendTmux(type)
	" send to tmux window 1
	if a:type ==# 'line' 
		execute ':silent ''[,'']w !tr -d ''\r'' | sed -E ''s/^\s*$/\#/g''  | tmux send-keys -t ' . string(g:python_tmux_window) . ' i C-c Escape  "O" Escape  "i" "$(cat)" Enter Enter'
	elseif a:type ==# 'char'
		execute ":silent .w !tmux send-keys -t " . string(g:python_tmux_window) . " i C-c \"$(cat)\" Enter"
	elseif a:type ==# 'V'
		execute ':silent ''<,''>w !tr -d ''\r'' | sed -E ''s/^\s*$/\#/g''  | tmux send-keys -t ' . string(g:python_tmux_window) . ' i C-c Escape "O" Escape  "i" "$(cat)" Enter Enter ' 
	elseif a:type ==# 'v'
		execute ":silent \'<,\'>w !tmux send-keys -t " . string(g:python_tmux_window) . " i C-c \"$(cat)\" Enter"
	elseif a:type ==# 'full'
		execute ':silent w !tr -d ''\r'' | sed -E ''s/^\s*$/\#/g''  | tmux send-keys -t ' . string(g:python_tmux_window) . ' C-c Escape  "O" Escape  "i" "$(cat)" Enter Enter'
	endif
endfunction


function! python#sendtmux#SendWholeFile()
	let l:filename = expand('%:p')
	let l:python_command = 'exec(open("' . l:filename . '").read())'
	execute ':silent !tmux send-keys -t ' . string(g:python_tmux_window) . ' i C-c ' . string(l:python_command) . ' Enter'
endfunction




