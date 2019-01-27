
call plug#begin('~/.vim/plugged')

" General Editing
Plug 'neomake/neomake' " Asyc replacement for syntastic
" Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " Enables repeat of vim-surround

" Language
Plug 'tpope/vim-markdown'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml' " config format used frequenly in the rust toolchain
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-fireplace' " Clojure, uses vim-classpath
Plug 'ledger/vim-ledger' " For bookkeeping
" Haskell
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
Plug 'pbrisbin/vim-syntax-shakespeare'
" PHP
Plug 'stanangeloff/php.vim' " syntax hilighting
Plug 'shawncplus/phpcomplete.vim' " omnicompleation

" Web
Plug 'mattn/emmet-vim'
Plug 'elmcast/elm-vim'

" Autocompleation
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugs' }
Plug 'sebastianmarkow/deoplete-rust'
Plug 'carlitux/deoplete-ternjs'
" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run install script
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Git
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Colors & Theming
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

for fpath in split(globpath('~/.config/nvim/config', '*.vim'), '\n')
  exe 'source' fpath
endfor

