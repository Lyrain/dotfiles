
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'

" Binds ctrl-p to bring up fzf file finder
nnoremap <leader>p :Files<CR>
" FZF the list of open buffers
nnoremap <leader>; :Buffer<CR>

