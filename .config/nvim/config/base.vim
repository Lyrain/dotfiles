" Base

" General
set nocompatible
filetype plugin indent on " filetype detection(on) plugin(on) indent(on)
syntax enable " Enable sytax highlighting

" Cursor & Line
set number
let &colorcolumn=join(range(80,81),",")
set cursorline

" set tab key to insert 4 spaces
set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab

" Files
set autoread " autoreload files changed on disk

" Vim diff
set diffopt=filler,vertical

" Wrapping
set nowrap

" Leader
let mapleader = "\<Space>"

" Clipboard
set clipboard+=unnamedplus

" quick save
nmap <leader>w :w<CR>
" Toggle buffers
nnoremap <leader><leader> <c-^>
" Use ,t for 'jump to tag'.
nnoremap <Leader>] <C-]>

" Removes highlighting until the next search is made
nnoremap <Leader>n :noh<CR>

" Removes the last char from the current word
nnoremap <Leader>x exb

nnoremap <Leader>m :make<CR><CR>

