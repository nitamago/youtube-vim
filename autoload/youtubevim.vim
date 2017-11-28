scriptencoding utf-8

if !exists('g:loaded_youtubevim')
    finish
endif
let g:loaded_youtubevim = 1

let s:save_cpo = &cpo
set cpo&vim

function! youtubevim#start()
    echo "start"
endfunction

function! youtubevim#stop()
    echo "stop"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
