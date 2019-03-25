
" Opens NERDTree automagically when vim starts with no specified files
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

nnoremap <C-t> :NERDTreeToggle<CR>

