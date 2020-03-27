inoremap $$ $$<++><esc>F$i
inoremap <leader>mk \mk{}<++><esc>F{a
inoremap <leader>section \section{}<cr><++><esc>k0f{a
inoremap <leader>subsection \subsection{}<cr><++><esc>k0f{a
inoremap <leader>title \title{}<cr><++><esc>k0f{a
inoremap <leader>al* \begin{align*}<cr><cr>\end{align*}<esc>kI
inoremap <leader>al \begin{align}<cr><cr>\end{align}<esc>kI

" load in files
nnoremap <leader>tex dd:r ~/.config/nvim/snippets/pure_latex_template.tex<cr>kdd_ nnoremap <leader>mex dd:r ~/.config/nvim/snippets/math_latex_template.tex<cr>kdd_
