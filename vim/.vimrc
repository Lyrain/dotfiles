" =========================
" ~/.vimrc - Myles Offord
" =========================

" Vundle Start
set nocompatible " Required
filetype plugin indent on

" Automatic Reloading of the .vimrc file
autocmd! BufWritePost .vimrc source %

" Should-be defaults
syntax on
set encoding=utf-8
set clipboard=unnamed
set number
set bs=2

" Splits open at the bottom and right, not the default silly settings.
set splitbelow
set splitright

" Split Navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Color set up
set t_Co=256
set term=xterm-256color
" colorscheme dracula

" 80 line marker
let &colorcolumn=join(range(80,81),",")

" Display Airline linestatus ALL the time
set laststatus=2

set background=dark

" Clears the white space from the specified file types when :w is issued
" Can list multiple files types inside of { *.md, *.txt  } I think.
autocmd BufWritePre *.md :%s/\s\+$//e

" Bind <Leader> to SPACE
let mapleader = " "

" Overwrite the word at the cursor with what is in the clipboard
map <Leader>ow ciw<C-R>0<Esc>

" C-t for new tab
nnoremap <C-t> :tabnew<CR>

" C-N twice goes to next tab
" nmap <C-N><C-N> :tabn<CR>

set spell spelllang=en_gb

" size of a hard tab stop
set tabstop=2

"size of an indent
set shiftwidth=2

" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard) tab stop
set softtabstop=2

set expandtab " Always uses spaces instead of tab chars
set smarttab " Inserts indents instead of tabs at the start of the line

autocmd FileType python setlocal shiftwidth=4 tabstop=4

set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set list

" Date time stamp by pressing F5
nnoremap <F5> "=strftime("%c")<CR>P
inoremap <F5> <C-R>=strftime("%c")<CR>

" Adds a command <SPACE>op to generate the .md file out to a .pdf file using
" pandoc and LaTex. The function will add a folder in the same directory as
" the file called ./pdf if it isn't there, delete any existing pdf files with
" the same name and then generate and open the file in preview.
function! Pandoc()
  if !isdirectory('./pdf')
    silent !mkdir './pdf'
  endif

  silent !clear
  if filereadable(./pdf/'%:r'.pdf)
    silent !rm '%:r'.pdf
  endif

  silent !pandoc --filter pandoc-citeproc '%:p' -o ./pdf/'%:r'.pdf
        \ --pdf-engine=xelatex
        \ --toc
        \ --variable fontsize=12pt
        \ --variable linestretch=1.5
        \ --variable geometry:margin=1in
  " silent !evince ./pdf/'%:r'.pdf
  redraw!
endfunction

function! PandocNoToc()
  if !isdirectory('./pdf')
    silent !mkdir './pdf'
  endif

  silent !clear
  if filereadable(./pdf/'%:r'.pdf)
    silent !rm '%:r'.pdf
  endif

  silent !pandoc '%:p' -o ./pdf/'%:r'.pdf
        \ --variable fontsize=12pt
        \ --variable linestretch=1.5
        \ --variable geometry:margin=1in
  " silent !evince ./pdf/'%:r'.pdf
  redraw!
endfunction

map <Leader>op :call Pandoc()<CR>
map <Leader>nt :call PandocNoToc()<CR>

