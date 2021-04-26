"init.vim file for neovim 
""""""""""""""""""""""""""
""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""
"To install neovim as AppImage: 
" 0.) cd ~/local/ 
" 1.) curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
" 2.) chmod u+x nvim.appimage
" 3.) ln -s nvim.appimage ~/bin/nvim 

"To install vim-plug (for Plugins)
" 1.) Install(in the venv) pynvim, e.g. conda install -c conda-forge pynvim
" 2.) curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Run :PlugInstall after placing the corresponding Plug below

"Place this file under ~/.config/nvim/init.vim
""""""""""""""""""""""""""""""""""""""""""""""""

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
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': 'python'}
Plug 'ap/vim-css-color', {'for' : 'python'}
Plug 'tpope/vim-vinegar'
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()

filetype plugin indent on

"Variables and options

let mapleader=","

set number relativenumber
set completeopt-=preview

let g:airline_theme='violet'

let g:matchup_override_vimtex=1 
let g:matchup_matchparen_deferred=1


"Mappings
inoremap jk <Esc>l
noremap <M-h> 0
noremap <M-l> $
noremap <M-k> H
noremap <M-j> L
noremap <C-j> gj
noremap <C-k> gk
nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> [q :cprev<cr>
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>er :vsplit ~/.config/nvim/README.md<cr>
nnoremap <silent> <leader>ep :vsplit ~/.config/nvim/ftplugin/python.vim<cr>
nnoremap <silent> <leader>et :vsplit ~/.config/nvim/ftplugin/tex.vim<cr>
nnoremap <silent> <leader>l :set number! relativenumber!<cr>
nnoremap <silent> <leader><space> :noh<cr>
nnoremap <silent> <leader>, ,
noremap <silent> ]b :call searchpair('\[','','\]')<cr>
noremap <silent> [b :call searchpair('\[','','\]','b')<cr>

nnoremap <C-x><C-f> :FZF -m<cr>
nnoremap <C-x><C-b> :Buffers <cr>
nnoremap <C-x><C-g> :GFiles <cr>
nnoremap <C-x><C-o> :FZF 

nnoremap <C-x><C-s> :w<cr>

"Terminal settings
tnoremap <Esc> <C-\><C-n>
augroup TerminalSettings
	autocmd!
	autocmd TermOpen * setlocal nonumber norelativenumber
augroup END


"Added to avoid confusion between Windows(fzf) and writing
command! W write
command! Wq :wq

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
augroup END

" put localsettings
" like colorschemes in this file
let localsettingsfile = expand('~/.config/nvim/scripts/localsettings.vim')
if filereadable(localsettingsfile)
	execute " source " . localsettingsfile
endif

function! DeleteSwap()
	call system('rm ' . $HOME . '/.local/share/nvim/swap/*' . expand('%:t') . '*')
endfunction

let g:tex_flavor = "latex"
