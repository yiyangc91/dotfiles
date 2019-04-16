﻿" vim:set ft=vim et sw=2:

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
" Plug 'scrooloose/syntastic' " syntax checking
Plug 'tpope/vim-commentary' " gcc for fast commenting
Plug 'junegunn/fzf', { 'dir': '~/bin/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'stephpy/vim-yaml'
Plug 'ledger/vim-ledger'
Plug 'fatih/vim-go'
Plug 'scrooloose/nerdtree'

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
"
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1


" Auto Close
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

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

" Plugin
" let g:netrw_liststyle = 3
" let g:netrw_bufsettings='nu relativenumber nobl'
let g:dirvish_mode = ':sort ,^.*[\/],'
let g:dirvish_relative_paths = 0

" Searching
set hlsearch
set incsearch

" Keybindings
let mapleader=" "
let maplocalleader=" "

noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

noremap <silent> ]q :cn<CR>
noremap <silent> [q :cp<CR>
noremap <silent> ]b :bn<CR>
noremap <silent> [b :bp<CR>
noremap <silent> ]l :lnext<CR>
noremap <silent> [l :lprevious<CR>

nnoremap <silent> <leader>m :marks<CR>
nnoremap <silent> <leader>w :w<CR>

inoremap <C-u> <C-g>u<C-u>

" NERDTree Bindings
" Use dirvish bindings for NERDTree
nnoremap <silent> <expr> - g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

" FZF bindings
nnoremap <leader>s :Rg 
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
autocmd BufNewFile,BufRead *.journal setlocal filetype=ledger

autocmd FileType php setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType puppet setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType ruby setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2
autocmd FileType html setlocal expandtab shiftwidth=2 softtabstop=2

autocmd FileType go setlocal noexpandtab shiftwidth=4 tabstop=4
autocmd FileType go nmap <buffer> <localleader>lL <Plug>(go-decls-dir)
autocmd FileType go nmap <buffer> <localleader>lb <Plug>(go-build)
autocmd FileType go nmap <buffer> <localleader>le <Plug>(go-iferr)
autocmd FileType go nmap <buffer> <localleader>lh <Plug>(go-info)
autocmd FileType go nmap <buffer> <localleader>li <Plug>(go-implements)
autocmd FileType go nmap <buffer> <localleader>ll <Plug>(go-decls)
autocmd FileType go nmap <buffer> <localleader>lt <Plug>(go-test)
autocmd FileType go nmap <buffer> <localleader>lx <Plug>(go-run)
autocmd FileType go nmap <buffer> <localleader>lu <Plug>(go-referrers)

" d for describe
" r rename

autocmd FileType ledger setlocal noexpandtab shiftwidth=4 tabstop=4
autocmd FileType ledger nnoremap <buffer> <silent> <C-m> :call ledger#transaction_state_set(line('.'), '*')<CR>
autocmd FileType ledger nnoremap <buffer> <silent> <C-n> :call ledger#transaction_date_set(line('.'), 'primary')<CR>
autocmd FileType ledger nnoremap <buffer> <silent> <C-t> :call ledger#entry()<CR>

" Color
colorscheme apprentice
