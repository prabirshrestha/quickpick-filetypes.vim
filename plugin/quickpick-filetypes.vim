if exists('g:quickpick_filetypes_loaded')
    finish
endif
let g:quickpick_filetypes_loaded = 1

command! Pfiletypes call quickpick#pickers#filetypes#open()
