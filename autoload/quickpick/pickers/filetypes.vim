function! quickpick#pickers#filetypes#show(...) abort
    let id = quickpick#create({
        \   'on_change': function('s:on_change'),
        \   'on_accept': function('s:on_accept'),
        \   'items': s:get_filetypes(0),
        \ })
    call quickpick#show(id)
    return id
endfunction

function! s:get_filetypes(refresh) abort
    if !exists('s:filetypes') || a:refresh
        let s:filetypes = uniq(sort(map(split(globpath(&rtp, 'syntax/*.vim'), '\n'), 'fnamemodify(v:val, ":t:r")')))
    endif
    return s:filetypes
endfunction

function! s:on_change(id, action, searchterm) abort
    let searchterm = tolower(a:searchterm)
    let items = empty(trim(searchterm)) ? s:get_filetypes(0) : filter(copy(s:get_filetypes(0)), {index, item-> stridx(tolower(item), searchterm) > -1})
    call quickpick#set_items(a:id, items)
endfunction

function! s:on_accept(id, action, data) abort
    call quickpick#close(a:id)
    execute 'set filetype=' . a:data['items'][0]
endfunction
