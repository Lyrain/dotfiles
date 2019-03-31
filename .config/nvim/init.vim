
call plug#begin('~/.vim/plugged')

" General Editing
Plug 'neomake/neomake' " Asyc replacement for syntastic
" Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " Enables repeat of vim-surround

" Linter & LSP
Plug 'w0rp/ale'

Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch' : 'next',
  \ 'do' : 'bash install.sh',
  \ }

" Autocompleation
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sebastianmarkow/deoplete-rust'
Plug 'carlitux/deoplete-ternjs'

" Language
Plug 'tpope/vim-markdown'
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml' " config format used frequenly in the rust toolchain
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-fireplace' " Clojure, uses vim-classpath
Plug 'ledger/vim-ledger' " For bookkeeping
Plug 'posva/vim-vue'
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

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run install script
Plug 'airblade/vim-rooter'
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

