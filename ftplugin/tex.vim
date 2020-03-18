normal zR
set foldmethod=manual

nnoremap <C-Space> /<++><cr>c4l
inoremap <C-Space> <Esc>/<++><cr>c4l

inoremap $$ $$<++><esc>F$i

" load in files
nnoremap <leader>tex dd:r ~/.config/nvim/snippets/pure_latex_template.tex<cr>kdd_
nnoremap <leader>mex dd:r ~/.config/nvim/snippets/math_latex_template.tex<cr>kdd_
