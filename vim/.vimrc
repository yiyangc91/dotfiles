" vim:set ft=vim et sw=2:

set nocompatible

" Vim-Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" Colorscheme
Plug 'romainl/Apprentice'

" Behaviour Changing Plugins
Plug 'scrooloose/syntastic' " syntax checking
Plug 'tpope/vim-commentary' " gcc for fast commenting
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf', { 'dir': '~/bin/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'stephpy/vim-yaml'

let vimplugins=$HOME."/.vimplugins"
if filereadable(vimplugins)
  exec 'source ' . vimplugins
endif

call plug#end()

" Plugin Configuration
packadd! matchit

" iTerm2 cursor funkyness
" let &t_SI = "\<Esc>]50;CursorShape=1\x7"
" let &t_SR = "\<Esc>]50;CursorShape=2\x7"
" let &t_EI = "\<Esc>]50;CursorShape=0\x7"

syntax on
set number
set relativenumber

" Default Tabbing
filetype plugin indent on

set autoindent
set smarttab

set expandtab
set shiftwidth=3
set softtabstop=3

" Status Line
set laststatus=2
set ruler
set showcmd

set statusline=%<
set statusline+=\ %f\ 
set statusline+=%h%m%r%w\ 
set statusline+=%#warningmsg#%*

set statusline+=%= " SPLIT

set statusline+=%{strlen(&fenc)?&fenc:'none'}[%{&ff}]\ 
set statusline+=❮\ %3(%l:\ %c%V%)\ 
set statusline+=❮\ %3(%P%)\ 

" Editor Display
set display+=lastline
set scrolloff=3

set colorcolumn=80

set listchars=tab:▸\ ,eol:¬,trail:•,nbsp:⋅

" Input Configuration
set ttimeout
set ttimeoutlen=100

set mouse=a
set backspace=indent,eol,start   " allows backspace over anything. default in vim

" Insert Mode
set nrformats-=octal             " excludes octal numbers for ^A and ^X. default in vim
set completeopt=menuone,longest  " always displays the menu, even for a single completion, and fill out the longest common word

" Command Mode
set wildmenu                     " this enables command mode autocompletion menu
set wildmode=longest:full,full   " lists the options first (longest:full) and then tab through them (full)

" Persistent Undos
set undofile
set undodir=~/.vim/undo-dir/

" Vim Behaviour
set autoread
set history=1000
set undolevels=16384
set clipboard=unnamed

" netrw
let g:netrw_liststyle = 3
let g:netrw_bufsettings='nu relativenumber nobl'

" Searching
set hlsearch
set incsearch

" Keybindings
let mapleader=" "

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <silent> <leader>j :cn<CR>
noremap <silent> <leader>k :cp<CR>
noremap <silent> <leader>l :clist<CR>

nnoremap <silent> <leader>w :w<CR>

inoremap <C-u> <C-g>u<C-u>


" FZF bindings
nnoremap <leader>s :Ag 
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>/ :BLines<CR>
nnoremap <silent> <leader>f :Lines<CR>
nnoremap <silent> <C-p> :Files<CR>

" Option toggles
nnoremap <leader>ol :setlocal list! list?<CR>
nnoremap <leader>on :setlocal number! number?<CR>
nnoremap <leader>or :setlocal relativenumber! relativenumber?<CR>
nnoremap <leader>oh :setlocal hlsearch! hlsearch?<CR>
nnoremap <leader>os :setlocal spell! spell?<CR>
nnoremap <leader>ow :setlocal wrap! wrap?<CR>
nnoremap <silent> <leader><CR> :nohlsearch<CR>

" Filetype specific commands
autocmd FileType php setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType puppet setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType html setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4

" Color
colorscheme apprentice
