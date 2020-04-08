colorscheme Atelier_DuneDark

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


function! SendTmux(type)
	if a:type ==# 'line' 
		execute ':silent ''[,'']w !tr -d ''\r'' | sed -E ''s/^\s*$/\#/g''  | tmux send-keys -t 1 Escape  "O" Escape  "i" "$(cat)" Enter Enter'
	elseif a:type ==# 'char'
		execute ":silent .w !tmux send-keys -t 1 \"$(cat)\" Enter"
	elseif a:type ==# 'V'
		execute ':silent ''<,''>w !tr -d ''\r'' | sed -E ''s/^\s*$/\#/g''  | tmux send-keys -t 1 Escape "O" Escape  "i" "$(cat)" Enter Enter ' 
	elseif a:type ==# 'v'
		execute ":silent \'<,\'>w !tmux send-keys -t 1 \"$(cat)\" Enter"
	elseif a:type ==# 'full'
		execute ':silent w !tr -d ''\r'' | sed -E ''s/^\s*$/\#/g''  | tmux send-keys -t 1 Escape  "O" Escape  "i" "$(cat)" Enter Enter'
	endif
endfunction

nnoremap gä :set operatorfunc=SendTmux<cr>g@
nnoremap gää :.w !tmux send-keys -t 1 "$(cat)" Enter<cr>j
vnoremap gä :<C-u>call SendTmux(visualmode())<cr>
nnoremap gÄ :<C-u>call SendTmux('full')<cr>

nnoremap <leader>ö :.!doc_python<cr>
vnoremap <leader>ö :!doc_python<cr>

source ~/.config/nvim/scripts/partial_coc.vim

"Save and load folds
augroup pythonfolds
	autocmd!
	autocmd BufWinLeave *.py mkview
	autocmd BufWinEnter *.py silent! loadview
augroup END
