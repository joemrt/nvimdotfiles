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
"Plug 'davidhalter/jedi-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'davidhalter/jedi-vim'
" Plug 'kassio/neoterm'
" Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug '/home/martin09/.fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

filetype plugin indent on

"Variables and options

let mapleader=","
let g:deoplete#enable_at_startup = 1
let g:jedi#completions_enabled = 0
let g:jedi#use_splits_not_buffers = "right"
let g:neoterm_default_mod = 'rightbelow'
let g:neoterm_autoscroll = 1

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

augroup loadvimrc
autocmd!
autocmd BufWritePost $MYVIMRC :source $MYVIMRC
augroup END

nnoremap <leader>k :call jedi#show_documentation()<cr><C-w>=
"appearance
colorscheme elflord

" set directory=.


" Old commands
"nnoremap <leader>ä :TREPLSendLine<cr>j
"vnoremap <leader>ä :TREPLSendSelection<cr>
"vnoremap <leader>Ä :s/\v^\s*$/#/g<cr>:'<,'>TREPLSendSelection<cr>:'<,'>s/\v^#\s*$//g<cr>
" vnoremap <leader>ä :w !sed -E 's/^\s*$/\#/g' > ~/tmp/.tmuxpipe && send_tmux1<cr><cr>
" nnoremap <leader>ä :.w !sed -E 's/^\s*$/\#/g' > ~/tmp/.tmuxpipe && send_tmux1<cr><cr>j
" inoremap <leader>ä <Esc>:.w !sed -E 's/^\s*$/\#/g' > ~/tmp/.tmuxpipe && send_tmux1<cr><cr>li
