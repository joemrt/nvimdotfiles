" LaTeX configuration
" In order for everything to work you need to install mupdf and (for synchronization) xdotools

normal zR
set foldmethod=manual
let g:vimtex_view_method = 'mupdf'
let g:vimtex_fold_enabled=0

nnoremap <C-Space> /<++><cr>:noh<cr>c4l
inoremap <C-Space> <Esc>/<++><cr>:noh<cr>c4l
nnoremap <silent> <F6> :setlocal spell! spelllang=en_us<cr>

nnoremap <silent> <leader>eb :call tex#loadbib#LoadBibFile()<cr>


"Save and load folds
augroup texfolds
	autocmd!
	autocmd BufWinLeave *.tex mkview
	autocmd BufWinEnter *.tex silent! loadview
augroup END

"load snippets
source ~/.config/nvim/snippets/latex_snippets.vim
