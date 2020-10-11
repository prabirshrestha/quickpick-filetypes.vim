function! quickpick#pickers#filetypes#open() abort
  let l:initial_filetype = &filetype
  call quickpick#open({
    \ 'items': uniq(sort(map(split(globpath(&rtp, 'syntax/*.vim'), '\n'), 'fnamemodify(v:val, ":t:r")'))),
    \ 'on_accept': function('s:on_accept'),
    \ 'on_selection': function('s:on_selection', [l:initial_filetype]),
    \ 'on_cancel': function('s:on_cancel', [l:initial_filetype]),
    \ })
endfunction

function! s:on_accept(data, ...) abort
  call quickpick#close()
  execute 'set filetype=' . a:data['items'][0]
endfunction

function! s:on_selection(initial_filetype, data, ...) abort
  if empty(a:data['items'])
    execute 'set filetype=' . a:initial_filetype
  else
    execute 'set filetype=' . a:data['items'][0]
  endif
endfunction

function! s:on_cancel(initial_filetype, data, ...) abort
  if !empty(a:initial_filetype)
    execute 'set filetype=' . a:initial_filetype
  endif
endfunction

" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldmethod=marker spell:
