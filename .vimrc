" =========================
" ~/.vimrc - Myles Offord
" =========================

" Vundle Start
set nocompatible " Required
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself.
Plugin 'gmarik/Vundle.vim'

" Plugins
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat' " Enables repeat of vim-surround
Plugin 'mattn/emmet-vim'
Plugin 'rust-lang/rust.vim'
Plugin 'tpope/vim-fireplace'
Plugin 'tpope/vim-classpath'

" Color Scheme
" Plugin 'altercation/vim-colors-solarized'
" Plugin 'dylanaraps/wal.vim'
" Plugin 'sickill/vim-monokai'
Plugin 'dracula/vim'

" Remeber to run :PluginInstall
" OR vim +PluginInstall +qall from the terminal!

call vundle#end()
filetype plugin indent on
" Vundle End

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
colorscheme dracula

" 80 line marker
let &colorcolumn=join(range(80,81),",")

" Display Airline linestatus ALL the time
set laststatus=2

" Airline Config
" let g:airline#extensions#tabline#enabled = 1

set background=dark
let g:airline_solarized_bg = "dark"
let g:airline_theme = "solarized"

let g:vim_markdown_folding_disabled=1

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

" Configuration for Syntastic
" Recommended Configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" let g:syntastic_rust_checkers = ['cargo']

" Syntastic won't check html files unless you manually :SyntasticCheck
" This is cause most html files take some form of template engine/scripting
let syntastic_mode_map = { 'passive_filetypes': ['html', 'java'] }

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Ask once per ycm_extra_conf.py file
" let g:ycm_extra_conf_globlist = ['~/code/cpp/network_test/*']

" Nerdtree config
" Maps nerd tree toggle
map <C-n> :NERDTreeToggle<CR>

" Show hidden files by default, this can be toggled with I. (Uppercase i)
let NERDTreeShowHidden=1

" Opens NERDTree automagically when vim starts with no specified files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Closes vim if nerdtree is only tab open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"
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

let g:syntastic_python_python_exec="/usr/local/Cellar/python3/3.5.0/bin/python3"
let g:syntastic_python_checkers = ['python']

