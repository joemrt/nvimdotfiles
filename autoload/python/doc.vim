let s:maximial_trial_of_brace_resolval = 20
let s:arguments_to_ignore = ["self"]

function! python#doc#GetDocString()
	" Print a docstring below python function
	" Returns 1 if failed and 0 if succeded
	let currentpos = getpos('.')
	let currentline = getline('.')
	" Get intendation with
	let intendation = matchstr(currentline,'^\s*\w\+\s\+')
	let intendation = system('sed -E "s/\w/ /g"', intendation)
	" Get arguments
	let value_of_braces = system('sed -nE "s/^[^(]*\((.*)\):\s*$/\1/p"', currentline)
	" loop to resolve braces
	let while_counter = 0
	while match(value_of_braces, '[(){}\[\]]') !=# -1 && while_counter <# s:maximial_trial_of_brace_resolval
		let value_of_braces = system('sed -E "s/[({[][^][(){}]*[]})]//g"', value_of_braces)
		let while_counter = while_counter +1
	endwhile
	" check if we reached limit
	if while_counter ==# s:maximial_trial_of_brace_resolval
		echom 'Could not resolve braces'
		return 1
	endif
	" delete unwanted elements
	let list_of_value_of_braces = split(value_of_braces,',')
	for arg in s:arguments_to_ignore
		let i = index(list_of_value_of_braces, arg)
		if i !=# -1
			call remove(list_of_value_of_braces, i)
		endif
	endfor
	" process arguments to form :param: list
	let doc = join(list_of_value_of_braces,"\n")
	let doc = system('sed -E "s/=\s*(\w|\.|-|\/|\+)*\s*//g"', doc)
	let doc = system('sed -E "s/\s*//g"', doc)
	let doc = system('sed -E "s/(\w*)/' . intendation .  ':param \1:/"', doc)
	if strlen(doc) !=# 0
		let doc = doc. "\<cr>"
	endif
	set paste
	execute "normal! A\<cr>" . intendation . "\"\"\"\<cr>" . doc . intendation . "\"\"\""
	"restore
	set nopaste
	call setpos('.', currentpos)
endfunction
