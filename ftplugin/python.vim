" execute via tmux
if exists('g:python_tmux_window')==#0
	let g:python_tmux_window=1
endif
source ~/.config/nvim/scripts/pythonsendtmux.vim

" function to popule quickfix window
function! PyPopulateQuickfixWindow()
	let l:path_to_script = expand('~') . '/.config/nvim/scripts/ipdbquickfix.sh'
	cexpr systemlist(l:path_to_script . ' ' . g:python_tmux_window)
endfunction

command! PyPop call PyPopulateQuickfixWindow()

set colorcolumn=80

nnoremap <silent> gä :set operatorfunc=SendTmux<cr>g@
nnoremap <silent> gää :execute('silent! .w !tmux send-keys -t ' . string(g:python_tmux_window) .  ' i C-c "$(cat)" Enter')<cr>j
vnoremap <silent> gä :<C-u>call SendTmux(visualmode())<cr>
nnoremap <silent> gÄ :<C-u>call SendTmux('full')<cr>

augroup checkforjk
	autocmd!
	autocmd BufEnter *.py :call CheckForjk()
augroup END

" print document string
source ~/.config/nvim/scripts/pythondoc.vim
nnoremap <silent> <leader>ö :call GetDocString()<cr>

" load coc.vim settings
source ~/.config/nvim/scripts/partial_coc.vim

"Save and load folds
augroup pythonfolds
	autocmd!
	autocmd BufWinLeave *.py mkview
	autocmd BufWinEnter *.py silent! loadview
augroup END
