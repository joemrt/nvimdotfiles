"""""""""""""""""""""""""""""""
"Configuration file for Neovim"
"""""""""""""""""""""""""""""""


silent! call plug#begin('~/.local/share/nvim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'plasticboy/vim-markdown', {'for': 'md'}
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'andymass/vim-matchup'
Plug 'tpope/vim-fugitive'
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'flazz/vim-colorschemes'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': 'python'}
Plug 'ap/vim-css-color', {'for' : 'python'}
Plug 'tpope/vim-vinegar'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()

filetype plugin indent on

"Variables and options

let mapleader=","

set number relativenumber
set completeopt-=preview

let g:airline_theme='violet'

let g:matchup_override_vimtex=1 
let g:matchup_matchparen_deferred=1

"" Disables table-mode keybindings
let g:table_mode_map_prefix = '<F13>'

" general lua package
lua general = require('general')


"Mappings
inoremap jk <Esc>
" noremap <M-j> L
" noremap <M-k> H
" noremap <M-h> 0
" noremap <M-l> $ 

" emacs like keybindings
nnoremap <C-x><C-s> :w<cr>
inoremap <silent> <C-x><C-s> <Esc>:w<cr>a
nnoremap <M-x> :
nnoremap <M-q> gq0
inoremap <M-q> <esc>gq0i
" nnoremap <C-g> <C-c>
" cnoremap <C-g> <C-c>
"

noremap <C-j> gj
noremap <C-k> gk
nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> [q :cprev<cr>
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>er :vsplit ~/.config/nvim/README.md<cr>
nnoremap <silent> <leader>ep :vsplit ~/.config/nvim/ftplugin/python.vim<cr>
nnoremap <silent> <leader>elp :vsplit ~/.config/nvim/ftplugin/python.lua<cr>
nnoremap <silent> <leader>et :vsplit ~/.config/nvim/ftplugin/tex.vim<cr>
nnoremap <silent> <leader>elt :vsplit ~/.config/nvim/ftplugin/tex.lua<cr>
nnoremap <silent> <leader>elv :vsplit ~/.config/nvim/lua/general/init.lua<cr>
nnoremap <silent> <leader>l :set number! relativenumber!<cr>
nnoremap <silent> <leader><space> :noh<cr>
nnoremap <silent> <leader>, ,
noremap <silent> ]b :call searchpair('\[','','\]')<cr>
noremap <silent> [b :call searchpair('\[','','\]','b')<cr>
" open first line of current file in a horizontal split
nnoremap <silent> <leader>eh  :split \| normal! gg<cr>
nnoremap <silent> <leader>gf :vsplit \| normal! gf<cr>

nnoremap <C-x><C-f> :FZF -m<cr>
nnoremap <C-x><C-b> :Buffers <cr>
nnoremap <C-x><C-g> :GFiles <cr>
nnoremap <C-x>/ :BLines <cr> 
nnoremap <C-x><C-o> :FZF 


"Terminal settings
tnoremap <Esc> <C-\><C-n>
augroup TerminalSettings
	autocmd!
	autocmd TermOpen * setlocal nonumber norelativenumber
augroup END

"Added to avoid confusion between Windows(fzf) and writing
command! W write
command! Wq :wq
command! Wqall :wqall

" switch working directory to the one of the current file 
command! Gohere lua general.update_cwd('cd')
" window local
command! Lohere lua general.update_cwd('lcd')

let g:goyo_width=80
let g:goyo_height=90
nnoremap <F2> :Goyo<cr>
nnoremap <silent> <F3> :set number! relativenumber!<cr>

augroup Goyo
	autocmd!
	autocmd VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
augroup END

augroup loadvimrc
	autocmd!
	autocmd BufWritePost $MYVIMRC :source $MYVIMRC
augroup END

augroup loadscripts
	autocmd!
	autocmd BufWritePost ~/.config/nvim/*/*.vim :source %
	autocmd BufWritePost ~/.config/nvim/*/*.lua :source %
augroup END

" put localsettings
" like colorschemes in this file
let localsettingsfile = expand('~/.config/nvim/scripts/localsettings.vim')
if filereadable(localsettingsfile)
	execute " source " . localsettingsfile
endif
let localluafile = expand('~/.config/nvim/scripts/locallua.lua')
if filereadable(localluafile)
	execute " source " . localluafile
endif

nnoremap <silent> <leader>ea :execute(':vsplit' . localsettingsfile)<cr>
nnoremap <silent> <leader>ela :execute(':vsplit' . localluafile)<cr>


function! DeleteSwap()
	call system('rm ' . $HOME . '/.local/share/nvim/swap/*' . expand('%:t') . '*')
endfunction

function! DeleteView()
	call system('rm ' . $HOME . '/.local/share/nvim/view/*')
endfunction

let g:tex_flavor = "latex"
