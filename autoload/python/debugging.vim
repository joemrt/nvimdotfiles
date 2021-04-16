" function to popule quickfix window
function! python#debugging#PyPopulateQuickfixWindow(currentfilename)
	let l:path_to_script = expand('~') . '/.config/nvim/scripts/ipdbquickfix.sh'
	cexpr systemlist(l:path_to_script . ' ' . g:python_tmux_window . ' ' . shellescape(a:currentfilename))
endfunction

" open ipdb in g:python_tmux_window
function! python#debugging#PyOpenDebugger()
	execute("silent !tmux send-keys -t " . string(g:python_tmux_window) . " 'from ipdb import pm ' Enter 'pm()' Enter 'w' Enter")
endfunction

" jump to previous quickfix error and update ipdb
function! python#debugging#PyPreviousError()
	execute("silent !tmux send-keys -t " . string(g:python_tmux_window) . " d Enter") 
	cprevious
endfunction

" jump to next quickfix error and update ipdb
function! python#debugging#PyNextError()
	execute("silent !tmux send-keys -t " . string(g:python_tmux_window) . " u Enter") 
	cnext 
endfunction


