
set spelllang=en_gb

augroup markdownSpell
  autocmd!
  autocmd FileType markdown setlocal spell
  autocmd BufRead,BufNewFile *.Rmd setlocal spell
augroup END

let g:tex_flavor = "latex"
autocmd FileType tex setlocal spell

