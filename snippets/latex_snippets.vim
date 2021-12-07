"marking
inoremap <leader>mk \mk{}<++><esc>F{a

"sections and similar
""""""""""""""""""""""
inoremap <leader>section \section{}<cr><++><esc>k0f{a

inoremap <leader>subsection \subsection{}<cr><++><esc>k0f{a
inoremap <leader>subsubsection \subsubsection{}<cr><++><esc>k0f{a
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
	if getline('.') =~# "\*}$"
		if exists('*vimtex#env#toggle_star()')
			call vimtex#env#toggle_star()
		else
			echom 'Could not toggle align'
		end
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

function! s:LabelSection()
	" store cursor position
	let save_pos = getpos(".")	
	" Capture current line
	let line_string = getline('.')
	" Extract section type and section title
	let pattern = '^\s*\\\([^{]*sec\)tion{\([^}]*\)}\s*$'
	let section_type = substitute(line_string,pattern,'\1','')
	let section_title = substitute(getline('.'),pattern,'\2','')	
	" Check whether substitution happened
	" if not abort
	if (section_type ==# line_string) || (section_title ==# line_string)
		echom "Could not resolve section"
		return
	end
	" Format section_title
	let section_title = substitute(section_title, '\s\+','_','g')
	let section_title = substitute(section_title, '\c[^a-z_]','','g')
	let section_title = substitute(section_title,'_\{2,\}','_','g')
	let section_title = substitute(section_title,'^\(.*\)$','\L\1','')
	" append label
	execute 'normal! o\label{' . section_type . ":" . section_title . '}'
	" restore position
	call setpos('.', save_pos)
endfunction

nnoremap <silent> <leader>ö :call <SID>LabelSection()<cr>

" citing
""""""""""""""
inoremap <leader>cite \cite{}<++><esc>F}i

"math
""""""""

inoremap $$ $$<++><esc>F$i
inoremap <leader>align* \begin{align*}<cr><cr><esc>I\end{align*}<esc>kI
inoremap <leader>align \begin{align}<cr><cr><esc>I\end{align}<esc>kI
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
			\<esc>I
			\\end{figure}<cr>
			\<++><esc>4k$F{a
"} (for syntax)

inoremap <leader>wrapfigure \begin{wrapfigure}{l}{0.5\textwidth}<cr>
			\\includegraphics[width=0.48\textwidth]{}<cr>
			\\caption{<++>}<cr>
			\\label{<++>}<cr>
			\<esc>I
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
			\<esc>I
			\\end{figure}<cr><++><esc>14k$F{a
"} (for syntax)

"minipage
"""""""""""
inoremap <leader>minipage \begin{minipage}{0.49\textwidth}<cr>
			  \<cr>
			  \% e.g. \captionof{figure}{caption text...}<cr>
			  \<esc>I
			  \\end{minipage}<cr><++><esc>3k0S


"lists
""""""""""""

inoremap <leader>itemize \begin{itemize}<cr>
			\\item <cr>
			\<esc>I
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

" tabular
""""""""""
inoremap <leader>tabular \begin{tabular}{l\|ll}<cr>
			\<++> & <++> & <++> \\<cr>
			\\hline<cr>
			\<++>  & <++> & <++> <cr>
			\\end{tabular}<esc>4kA

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
inoremap <leader>beamer <esc>dd:r ~/.config/nvim/snippets/beamer_latex_template.tex<cr>kdd_27jzzo
