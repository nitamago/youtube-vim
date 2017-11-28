scriptencoding utf-8

if !exists('g:loaded_youtubevim')
    finish
endif
let g:loaded_youtubevim = 1

let s:save_cpo = &cpo
set cpo&vim

let V = vital#of('vital')
let s:PM = s:V.import('ProcessManager')

function! youtubevim#start()
    if executable('mplayer')
        if s:PM.is_available()
            let url = 'https://www.youtube.com/watch?v=DK-lBi5r6Jk'
            let play_command = 'youtube-dl ' . s:url . ' --no-progress -o - | mplayer - -novideo'
            call youtubevim#stop()
            call s:PM.touch('youtubevim', play_command)
        else
            echo 'Error: vimproc is unavailable.'
        endif
    else
        echo 'Error: Please install mplayer to listen streaming radio.'
    endif
    echo "start"
endfunction

function! youtubevim#stop()
    if jazzradio#is_playing()
        return s:PM.kill('youtubevim')
    endif
    echo "stop"
endfunction

function! youtubevim#is_playing()
    let status = 'dead'
    try
        let status = s:PM.status('youtubevim')
    catch
    endtry

    if status == 'inactive' || status == 'active'
        return 1
    else
        return 0
    endif
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
