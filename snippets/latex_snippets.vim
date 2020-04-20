"marking
inoremap <leader>mk \mk{}<++><esc>F{a

"sections and similar
""""""""""""""""""""""
inoremap <leader>section \section{}<cr><++><esc>k0f{a

inoremap <leader>subsection \subsection{}<cr><++><esc>k0f{a
inoremap <leader>title \title{}<cr><++><esc>k0f{a
inoremap <leader>bibliography \bibliography{}<cr>
			\\bibliographystyle{ieeetr}<esc>kF{a

inoremap <leader>label \label{}<++><esc>F}i
inoremap <leader>ref \ref{}<++><esc>F}i

"math
""""""""

inoremap $$ $$<++><esc>F$i
inoremap <leader>align* \begin{align*}<cr><cr>\end{align*}<esc>kI
inoremap <leader>align \begin{align}<cr><cr>\end{align}<esc>kI
"{ 
inoremap <leader>frac \frac{}{<++>}<++><esc>2F}i

"figures
""""""""""""
inoremap <leader>figure \begin{figure}[t]<cr>
			\\centering<cr>
			\\includegraphics[width=\textwidth]{}<cr>
			\\caption{<++>}<cr>
			\\label{<++>}<cr>
			\\end{figure}<cr>
			\<++><esc>4k$F{a
"} (for syntax)

inoremap <leader>wrapfigure \begin{wrapfigure}{l}{0.5\texwidth}<cr>
			\\includegraphics[width=0.48\textwidth]{}<cr>
			\\caption{<++>}<cr>
			\\label{<++>}<cr>
			\\end{wrapfigure}<cr>
			\<++><esc>4k$F{a
"} (for syntax)

inoremap <leader>subfigure \begin{figure}[t]
			\\centering<cr>
			\\begin{subfigure}[t]{0.49\textwidth}<cr>
			\\centering<cr>
			\\includegraphics[width=\textwidth]{}<cr>
			\\caption{<++>}<cr>
			\\label{<++>}<cr>
			\\end{subfigure}%<cr>
			\~<cr>
			\\begin{subfigure}[t]{0.49\textwidth}<cr>
			\\centering<cr>
			\\includegraphics[width=\textwidth]{<++>}<cr>
			\\caption{<++>}<cr>
			\\label{<++>}<cr>
			\\end{subfigure}<cr>
			\\caption{<++>}<cr>
			\\label{<++>}<cr>
			\\end{figure}<cr><++><esc>14k$F{a
"} (for syntax)


"lists
""""""""""""

inoremap <leader>itemize \begin{itemize}<cr>
			\\item <cr>
			\\end{itemize}<cr><++><esc>2k$a

		
"textformatting
""""""""""""""""
inoremap <leader>emph \emph{}<++><esc>F}i
inoremap <leader>textbf \textbf{}<++><esc>F}i


"load in files
"""""""""""""""
nnoremap <leader>tex dd:r ~/.config/nvim/snippets/pure_latex_template.tex<cr>kdd_ nnoremap <leader>mex dd:r ~/.config/nvim/snippets/math_latex_template.tex<cr>kdd_
