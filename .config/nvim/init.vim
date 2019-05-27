
call plug#begin('~/.vim/plugged')

" General Editing

" PlugInstall and PlugUpdate will clone fzf in ~/.fzf and run install script
Plug 'airblade/vim-rooter'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Colors & Theming
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat' " Enables repeat of vim-surround

" Linter & LSP
Plug 'w0rp/ale'

" Language Server
Plug 'autozimu/LanguageClient-neovim', {
  \ 'branch' : 'next',
  \ 'do' : 'bash install.sh',
  \ }

" Autocompleation
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'sebastianmarkow/deoplete-rust'
Plug 'carlitux/deoplete-ternjs'

" ##################
" #### Language ####
" ##################

" Markdown
Plug 'tpope/vim-markdown'
" Rust
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml' " config format used frequenly in the rust toolchain
" Erlang / Elixir
Plug 'elixir-editors/vim-elixir'
" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" JVM based
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-fireplace' " Clojure, uses vim-classpath
" Web
Plug 'mattn/emmet-vim'
Plug 'elmcast/elm-vim'

" Plaintext Accounting
Plug 'ledger/vim-ledger'

call plug#end()

for fpath in split(globpath('~/.config/nvim/config', '*.vim'), '\n')
  exe 'source' fpath
endfor

