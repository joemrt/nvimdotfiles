" init.vim file for neovim
" -------------------------
"
" "To install neovim as AppImage: 
"0.) cd ~/local/
"1.) curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
"2.) chmod u+x nvim.appimage
"3.) ln -s nvim.appimage ~/bin/nvim 
"
"To install vim-plug (for Plugins)
"1.) Install(in the venv) pynvim, e.g. conda install -c conda-forge pynvim
"2:) curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
"https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"Run :PlugInstall after placing the corresponding Plug below

"Place this file under ~/.config/nvim/init.vim

"--------------------

"Deactivate this if you want to use the local python interpreter
"If activated pynvim should be installed in the venv (using pip)
"let g:python3_host_prog = '/home/martin09/anaconda3/envs/neovim/bin/python'
"let g:python_host_prog = '/home/martin09/anaconda3/envs/neovim/bin/python'


"Plugins

call plug#begin('~/.local/share/nvim/plugged')
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'SirVer/ultisnips'
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug '/home/martin09/.fzf'
Plug 'junegunn/fzf.vim'
Plug 'flazz/vim-colorschemes'
Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': 'python'}
call plug#end()

filetype plugin indent on

"Variables and options

let mapleader=","

set number relativenumber
set completeopt-=preview
let g:airline_theme='murmur'

"Mappings


"inoremap <leader>d <Esc>:pclose<cr>i
inoremap jk <Esc>l
nnoremap <M-h> 0
nnoremap <M-l> $
nnoremap <M-k> H
nnoremap <M-j> L
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>l :set number! relativenumber!<cr>
tnoremap <Esc> <C-\><C-n>
nnoremap <leader><space> :noh<cr>
nnoremap <leader>ö :.!doc_python<cr>
vnoremap <leader>ö :!doc_python<cr>

nnoremap <C-p><C-p> :FZF -m<cr>
nnoremap <C-p><C-b> :Buffers <cr>
nnoremap <C-p><C-g> :GFiles <cr>
nnoremap <C-p><C-l> :Lines <cr>
nnoremap <C-p><C-o> :FZF 
nnoremap <C-p><C-h> :History <cr>

let g:goyo_width=80
let g:goyo_height=90
nnoremap <F2> :Goyo<cr>
nnoremap <F3> :set number! relativenumber!<cr>
augroup Goyo
autocmd!
autocmd VimResized * if exists('#goyo') | exe "normal \<c-w>=" | endif
augroup END

augroup loadvimrc
autocmd!
autocmd BufWritePost $MYVIMRC :source $MYVIMRC
augroup END

"appearance
colorscheme Tomorrow-Night-Eighties


