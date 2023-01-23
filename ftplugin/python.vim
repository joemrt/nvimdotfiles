" execute via tmux
if exists('g:python_tmux_window')==#0
	let g:python_tmux_window=1
endif

command! PyPop call python#debugging#PyPopulateQuickfixWindow(escape(expand('%:p'), '/'))

nnoremap <silent> <leader>ee :call python#debugging#PyOpenDebugger()<cr>

nnoremap <silent> [e :call python#debugging#PyPreviousError()<cr>

nnoremap <silent> ]e :call python#debugging#PyNextError()<cr>

set colorcolumn=80


nnoremap <silent> gä :set operatorfunc=python#sendtmux#SendTmux<cr>g@
nnoremap <silent> gää :execute('silent! .w !tmux send-keys -t ' . string(g:python_tmux_window) .  ' i C-c "$(cat)" Enter')<cr>j
vnoremap <silent> gä :<C-u>call python#sendtmux#SendTmux(visualmode())<cr>
nnoremap <silent> gÄ :<C-u>call python#sendtmux#SendWholeFile()<cr>

" Send reload string to ipython in tmux
command! PyReloadModules lua SendReloadToTmux()


augroup checkforjk
	autocmd!
	autocmd BufEnter *.py :call python#sendtmux#CheckForjk()
augroup END

" print document string
nnoremap <silent> <leader>ö :call python#doc#GetDocString()<cr>

" insert f-string
inoremap f' f''<Esc>i


" load coc.vim settings
source ~/.config/nvim/scripts/partial_coc.vim

" needed to keep cursor in block shape when searching references
let g:coc_disable_transparent_cursor = 1

"Save and load folds
augroup pythonfolds
	autocmd!
	autocmd BufWinLeave *.py mkview
	autocmd BufWinEnter *.py silent! loadview
augroup END
