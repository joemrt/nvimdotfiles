normal zR
set foldmethod=manual
let g:vimtex_view_method = 'mupdf'
let g:vimtex_fold_enabled=0

nnoremap <C-Space> /<++><cr>:noh<cr>c4l
inoremap <C-Space> <Esc>/<++><cr>:noh<cr>c5l

inoremap $$ $$<++><esc>F$i
inoremap <leader>mk \mk{}<++><esc>F{a


" load in files
nnoremap <leader>tex dd:r ~/.config/nvim/snippets/pure_latex_template.tex<cr>kdd_
nnoremap <leader>mex dd:r ~/.config/nvim/snippets/math_latex_template.tex<cr>kdd_
