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

function! s:NewAlignLabel()
	" read in name of equation label
	let label = input('label: ')
	" insert at current position
	execute "normal! a\\eqref{eq:" . label . "}"
	" remember position
	normal! m'
	" jump to last align environment
	?^\s*\\begin{align
	" Check is starred and if so toggle 
	" using vimtex
	if getline('.')=~#"\*}$"
		execute "normal \<Plug>(vimtex-env-toggle-star)"
	end
	" enter newcommand
	execute "normal! o\\label{eq:" . label . "}"
	" jump back
	normal! ``
	" append
	if col('.') ==# col('$')-1
		" if at end of line, take 'A'
		startinsert!
	else
		" else move to right and take 'i'
		normal! l
		startinsert
	end
endfunction

inoremap <leader>neq <esc>:call <SID>NewAlignLabel()<cr>
" citing
""""""""""""""
inoremap <leader>cite \cite{}<++><esc>F}i

"math
""""""""

inoremap $$ $$<++><esc>F$i
inoremap <leader>align* \begin{align*}<cr><cr>\end{align*}<esc>kI
inoremap <leader>align \begin{align}<cr><cr>\end{align}<esc>kI
"{ 
inoremap <leader>frac \frac{}{<++>}<++><esc>2F}i
inoremap <leader>< \langle\rangle<++><esc>2Fea

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

inoremap <leader>wrapfigure \begin{wrapfigure}{l}{0.5\textwidth}<cr>
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

"quoting
""""""""""
inoremap <leader>" ``''<++><esc>F`a

"newcommands
inoremap <leader>newcommand \newcommand{}{<++>}<++><esc>2F}i

function! s:NewCommand()
	" read in name of command
	let command = input('newcommand: ')
	" insert at current position
	execute "normal! a" . command
	" remember position
	normal! m'
	" jump to newcommand definitions
	?^\s*\\newcommand
	" enter newcommand
	execute "normal! o\\newcommand{" . command . "}{}"
endfunction

inoremap <leader>nco <esc>:call <SID>NewCommand() \| startinsert<cr>


"load in files
"""""""""""""""
inoremap <leader>tex <esc>dd:r ~/.config/nvim/snippets/pure_latex_template.tex<cr>kdd_9jzzo
inoremap <leader>mex <esc>dd:r ~/.config/nvim/snippets/math_latex_template.tex<cr>kdd_21jzzo
