function! CheckForjk()
	if search('jk') !=# 0
		echom 'jk was found, before using tmux edit ~/.ipython/profile_default/startup/keybindings.py!'
	endif
endfunction


augroup checkforjk
	autocmd!
	" autocmd BufWritePost,BufEnter *.py :call CheckForjk()
	autocmd BufEnter *.py :call CheckForjk()
augroup END


"
function! SendTmux(type)
	if a:type ==# 'line' 
		execute ':silent ''[,'']w !tr -d ''\r'' | sed -E ''s/^\s*$/\#/g''  | tmux send-keys -t 1 Escape  "O" Escape  "i" "$(cat)" Enter Enter'
	elseif a:type ==# 'char'
		execute ":silent .w !tmux send-keys -t 1 \"$(cat)\" Enter"
	elseif a:type ==# 'V'
		execute ':silent ''<,''>w !tr -d ''\r'' | sed -E ''s/^\s*$/\#/g''  | tmux send-keys -t 1 Escape "O" Escape  "i" "$(cat)" Enter Enter ' 
	elseif a:type ==# 'v'
		execute ":silent \'<,\'>w !tmux send-keys -t 1 \"$(cat)\" Enter"
	endif
endfunction

nnoremap gä :set operatorfunc=SendTmux<cr>g@
nnoremap gää :.w !tmux send-keys -t 1 "$(cat)" Enter<cr>j
vnoremap gä :<C-u>call SendTmux(visualmode())<cr>


 " Old stuff
" nnoremap <leader>ä :.w !tmux send-keys -t 1 "$(cat)" Enter<cr>j
" vnoremap <leader>ä :w !sed -E 's/^\s*$/\#/g' \| tmux send-keys -t 1 "<C-o>" "$(cat)" Enter Enter<cr><cr> 
" vnoremap <leader>ä :w !sed -E 's/^\s*$/\#/g' \| tmux send-keys -t 1 Escape "O" "$(cat)" Enter Enter<cr><cr> 
" vnoremap <leader>ä :w !tr -d '\r' \| sed -E 's/^\s*$/\#/g' \| tmux send-keys -t 1 Escape "O" "$(cat)" Enter Enter<cr><cr> 


" execute ':silent ''[,'']w !tr -d ''\r'' | sed -E ''s/^\s*$/\#/g''  | tmux send-keys -t 1 Escape "O" "$(cat)" Enter Enter'
