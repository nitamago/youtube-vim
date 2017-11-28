scriptencoding utf-8

if !exists('g:loaded_youtubevim')
    finish
endif
let g:loaded_youtubevim = 1

let s:save_cpo = &cpo
set cpo&vim

let V = vital#of('vital')

function! youtubevim#start()
    if executable('mplayer')
        if executable('youtube-dl')
            let s:url = 'https://www.youtube.com/watch?v=DK-lBi5r6Jk'
            let play_command = 'youtube-dl ' . s:url . ' -o - | mplayer - -novideo &'
            echo play_comman
            call youtubevim#stop()
            "call s:PM.touch('youtubevim', play_command)
            call Execcmd(play_command)
        else
            echo "Error: no youtube-dl"
        endif
    else
        echo 'Error: Please install mplayer to listen streaming radio.'
    endif
    echo "start"
endfunction

function! youtubevim#stop()
    if youtubevim#is_playing()
        "return s:PM.kill('youtubevim')
        return 0
    endif
    echo "stop"
endfunction

function! youtubevim#is_playing()
    let status = 'dead'
    try
        "let status = s:PM.status('youtubevim')
        let status = 0
    catch
    endtry

    if status == 'inactive' || status == 'active'
        return 1
    else
        return 0
    endif
endfunction


function! Execcmd(cmd)
    let l:proc = vimproc#plineopen2(a:cmd)
    let l:response = ''
    echo "Executed"
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
