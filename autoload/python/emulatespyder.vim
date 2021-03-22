" Emulate the behavior of the spyder IDE w.r.t execution of code
" For using define for instance the following mappings
" nnoremap <silent> ]# :call cursor([python#emulatespyder#SpyderSearch('nW'),1])<cr>
" nnoremap <silent> [#  :call cursor([python#emulatespyder#SpyderSearch('bWn'),1])<cr>
" nnoremap <silent> g# :call python#emulatespyder#SpyderExecute()<cr>

function! python#emulatespyder#SpyderSearch(flags)
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

function! python#emulatespyder#SpyderExecute()
	let l:start=SpyderSearch('nWbc')
	let l:end=SpyderSearch('Wn')
	execute ':silent '. string(l:start) .','. string(l:end) .'w !tr -d ''\r'' | sed -E ''s/^\s*$/\#/g''  | tmux send-keys -t ' . string(g:python_tmux_window) . ' i C-c Escape  "O" Escape  "i" "$(cat)" Enter Enter'
endfunction
