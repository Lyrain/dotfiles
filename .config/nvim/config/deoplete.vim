" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Use smart case
let g:deoplete#smart_case = 1

let g:deoplete#max_abbr_width = 0
let g:deoplete#max_menu_width = 0

inoremap <expr><C-h>
      \ deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS>
      \ deoplete#smart_close_popup()."\<C-h>"

