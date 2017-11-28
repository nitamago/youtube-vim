scriptencoding utf-8

if exists('g:loaded_youtubevim')
    finish
endif
let g:loaded_youtubevim = 1

let s:save_cpo = &cpo
set cpo&vim

command! YoutubeStart call youtubevim#start()
command! YoutubeStop call youtubevim#stop()

let &cpo = s:save_cpo
unlet s:save_cpo
