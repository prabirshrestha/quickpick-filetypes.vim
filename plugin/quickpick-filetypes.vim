if exists('g:quickpick_filetypes')
    finish
endif
let g:quickpick_filetypes = 1

command! Pfiletypes call quickpick#pickers#filetypes#show()
