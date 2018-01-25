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

" Color Scheme
Plugin 'altercation/vim-colors-solarized'
" Plugin 'sickill/vim-monokai'

" Remeber to run :PluginInstall
" OR vim +PluginInstall +qall from the terminal!

call vundle#end()
filetype plugin indent on
" Vundle End

" Automatic Reloading of the .vimrc file
autocmd! BufWritePost .vimrc source %

syntax on

" Make copy/paste work properly in tmux/iterm2
set clipboard=unnamed

" Color set up
set t_Co=256
set term=xterm-256color

" Color scheme Set up
syntax enable

" Color scheme options
colorscheme solarized

" 80 line marker
let &colorcolumn=join(range(80,81),",")

" Make Backspace kill indents and tabs in one press
set bs=2

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

map <Leader>cp ciw<C-R>0<Esc>

" C-N twice goes to next tab
:nmap <C-N><C-N> :tabn<CR>

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

:set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
:set list

" Set line numbers on
set number

" Date time stamp by pressing F5
:nnoremap <F5> "=strftime("%c")<CR>P
:inoremap <F5> <C-R>=strftime("%c")<CR>

" Configuration for Syntastic
" Recommended Configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Syntastic won't check html files unless you manually :SyntasticCheck
" This is cause most html files take some form of template engine/scripting
let syntastic_mode_map = { 'passive_filetypes': ['html', 'java'] }

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" let g:ycm_filetype_blacklist = { 'ruby': 1 }

" Ask once per ycm_extra_conf.py file
let g:ycm_extra_conf_globlist = ['~/code/cpp/network_test/*']

" Nerdtree config
" Maps nerd tree toggle
map <C-t> :NERDTreeToggle<CR>

" Show hidden files by default, this can be toggled with I. (Uppercase i)
let NERDTreeShowHidden=1

" Opens NERDTree automagically when vim starts with no specified files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Closes vim if nerdtree is only tab open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" OS specific configurations
if has('mac')
  " Adds a command <SPACE>op to generate the .md file out to a .pdf file using
  " pandoc and LaTex. The function will add a folder in the same directory as
  " the file called ./pdf if it isn't there, delete any existing pdf files with
  " the same name and then generate and open the file in preview.
  let mapleader = " " " Binds <Leader> to SPACE
  function! OpenMarkdownPreview()
    if !isdirectory('./pdf')
      :silent !mkdir './pdf'
    endif

    :silent !clear
    if filereadable(./pdf/'%:r'.pdf)
      :silent !rm '%:r'.pdf
    endif

    :silent !pandoc --filter pandoc-citeproc '%:p' --biblio ./bib.bib --csl=ieee.csl -o ./pdf/'%:r'.pdf --latex-engine=xelatex --toc --variable fontsize=12pt --variable linestretch=1.5 --variable geometry:margin=1in
    :silent !open ./pdf/'%:r'.pdf
    :redraw!
  endfunction

  function! PandocNoToc()
    if !isdirectory('./pdf')
      :silent !mkdir './pdf'
    endif

    :silent !clear
    if filereadable(./pdf/'%:r'.pdf)
      :silent !rm '%:r'.pdf
    endif

    :silent !pandoc '%:p' -o ./pdf/'%:r'.pdf --variable fontsize=12pt --variable linestretch=1.5 --variable geometry:margin=1in
    :silent !open ./pdf/'%:r'.pdf
    :redraw!
  endfunction

  map <Leader>op :call OpenMarkdownPreview()<CR>
  map <Leader>nt :call PandocNoToc()<CR>

  let g:syntastic_python_python_exec="/usr/local/Cellar/python3/3.5.0/bin/python3"
  let g:syntastic_python_checkers = ['python']
elseif has('unix')

endif

