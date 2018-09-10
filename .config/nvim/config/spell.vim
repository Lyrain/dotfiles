
set spelllang=en_gb

augroup markdownSpell
  autocmd!
  autocmd FileType markdown setlocal spell 
  autocmd BufRead,BufNewFile *.Rmd setlocal spell
augroup END

