" Emulate the behavior of the spyder IDE

function! SpyderSearch(flags)
	let l:linenumber=search('^#%%',a:flags)
	if l:linenumber ==# 0
		if matchstr(a:flags,'b') ==# 'b'
			let l:linenumber = 1
		else
			let l:linenumber = line('$')
		endif
	endif
	return l:linenumber
endfunction

function! SpyderExecute()
	let l:start=SpyderSearch('nWbc')
	let l:end=SpyderSearch('Wn')
	execute ':silent '. string(l:start) .','. string(l:end) .'w !tr -d ''\r'' | sed -E ''s/^\s*$/\#/g''  | tmux send-keys -t ' . string(g:python_tmux_window) . ' i C-c Escape  "O" Escape  "i" "$(cat)" Enter Enter'
endfunction


nnoremap <silent> ]# :call cursor([SpyderSearch('nW'),1])<cr>
nnoremap <silent> [#  :call cursor([SpyderSearch('bWn'),1])<cr>
nnoremap <silent> g# :call SpyderExecute()<cr>
