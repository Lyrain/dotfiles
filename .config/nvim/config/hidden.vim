" Hidden

" Make hidden characters visible
set listchars=eol:¬,tab:>-,trail:~,extends:>,precedes:<
set list

" Remove whitespace from the end of the line for all filetypes
autocmd BufWritePre * :%s/\s\+$//e

