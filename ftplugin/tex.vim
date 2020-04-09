" LaTeX configuration
" In order for everything to work you need to install mupdf and (for synchronization) xdotools

colorscheme Atelier_LakesideDark

normal zR
set foldmethod=manual
let g:vimtex_view_method = 'mupdf'
let g:vimtex_fold_enabled=0

nnoremap <C-Space> /<cr>:noh<cr>c4l
inoremap <C-Space> <Esc>/<++><cr>:noh<cr>c4l

function! LoadTexFile()
	"incomplete still
	"check if file exists somewhere (or vairable empty)
	"scroll if there is a name under the curor
	"make it a vim internal function
	"determine bib file
	let l:currentword = expand('<cword>')
	let l:bibfile = system('sed -nE "0,/^\\\\bibliography\{(\w*)\}/ s/^\\\\bibliography\{(\w*)\}/\1.bib/p" '.expand('%'))
	"open file
	echom "looking for " . l:currentword
	execute 'vsplit ' . l:bibfile
	"look for word
	execute 'silent! normal gg/' . l:currentword . "\<cr>"
	nohlsearch
endfunction

nnoremap <leader>eb :call LoadTexFile()<cr>

"load snippets
source ~/.config/nvim/snippets/latex_snippets.vim
