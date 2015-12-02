" =========================
" ~/.vimrc - Myles Offord
" =========================

" Automatic Reloading of the .vimrc file
autocmd! BufWritePost .vimrc source %

" Make copy/paste work properly in tmux/iterm2
set clipboard=unnamed

" Plugin infection
execute pathogen#infect()
syntax on
filetype plugin indent on

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

" Set Toggle Line number to Ctrl-N twice
:nmap <C-N><C-N> :set invnumber<CR>
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
let syntastic_mode_map = { 'passive_filetypes': ['html'] }

" Ignore ng- attributes in html
" Ignore meteor:blaze errors
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_html_tidy_inline_tags=["ui-view, template"]

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" Table mode Config
let g:table_mode_corner_corner="+"
let g:table_mode_header_fillchar="="

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

    :silent !pandoc '%:p' -o ./pdf/'%:r'.pdf --toc --variable fontsize=12pt --variable linestretch=1.5 --variable geometry:margin=1in
    :silent !open ./pdf/'%:r'.pdf
    :redraw!
  endfunction

  map <Leader>op :call OpenMarkdownPreview()<CR>

  let g:syntastic_python_python_exec="/usr/local/Cellar/python3/3.5.0/bin/python3"
elseif has('unix')

endif

