" LaTeX configuration
" In order for everything to work you need to install mupdf and (for synchronization) xdotools

colorscheme Atelier_LakesideDark

normal zR
set foldmethod=manual
let g:vimtex_view_method = 'mupdf'
let g:vimtex_fold_enabled=0

nnoremap <C-Space> /<cr>:noh<cr>c4l
inoremap <C-Space> <Esc>/<++><cr>:noh<cr>c4l

function! s:LoadBibFile()
	"TODO: check if file exists somewhere (or vairable empty)
	let l:currentword = expand('<cword>')
	let l:bibfile = system('sed -nE "0,/^\\\\bibliography\{(\w*)\}/ s/^\\\\bibliography\{(\w*)\}/\1.bib/p" ', bufnr('%'))
	if l:bibfile !=# ''
		execute 'vsplit ' . l:bibfile
		"look for word
		execute 'silent! normal gg/' . l:currentword . "\<cr>"
		nohlsearch
	else
		echom "No bibliography detected!"
	endif
endfunction

nnoremap <silent> <leader>eb :call <SID>LoadBibFile()<cr>

"load snippets
source ~/.config/nvim/snippets/latex_snippets.vim
