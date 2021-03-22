" function to popule quickfix window
function! python#debugging#PyPopulateQuickfixWindow(currentfilename)
	let l:path_to_script = expand('~') . '/.config/nvim/scripts/ipdbquickfix.sh'
	cexpr systemlist(l:path_to_script . ' ' . g:python_tmux_window . ' ' . shellescape(a:currentfilename))
endfunction

