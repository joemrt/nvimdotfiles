function! tex#loadbib#LoadBibFile()
	"Loads BibTex
	"and looks for word under the cursor
	let l:currentword = expand('<cword>')
	let l:bibfile = system('sed -nE "0,/^\\s*\\\\bibliography\{(\w*)\}/ s/^\\s*\\\\bibliography\{(\w*)\}/\1.bib/p" ', bufnr('%'))
	if l:bibfile !=# ''
		execute 'vsplit ' . expand('%:h') . '/' . l:bibfile
		"look for word
		execute 'silent! normal gg/' . l:currentword . "\<cr>"
		nohlsearch
	else
		echom "No bibliography detected!"
	endif
endfunction

