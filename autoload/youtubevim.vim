scriptencoding utf-8

if !exists('g:loaded_youtubevim')
    finish
endif
let g:loaded_youtubevim = 1

let s:save_cpo = &cpo
set cpo&vim

function! youtubevim#start()
    if executable('mplayer')
        if executable('youtube-dl')
            let s:url = 'https://www.youtube.com/watch?v=DK-lBi5r6Jk'
            let fetch_command = 'youtube-dl ' . s:url . ' -o /tmp/youtubevim-tmp'
            let play_command = 'mplayer /tmp/youtubevim-tmp'
            call youtubevim#stop()
            let s:fp = Execcmd(fetch_command)
            let s:pp = Execcmd(play_command)
        else
            echo "Error: no youtube-dl"
        endif
    else
        echo 'Error: Please install mplayer to listen streaming radio.'
    endif
endfunction

function! youtubevim#stop()
    if youtubevim#is_playing()
        if !vimproc#kill(s:fp.pid, 0)
            call vimproc#kill(s:fp.pid, 9)
        endif
        if !vimproc#kill(s:pp.pid, 0)
            call vimproc#kill(s:pp.pid, 9)
        endif
        return 0
    endif
endfunction

function! youtubevim#is_playing()
    if !vimproc#kill(s:fp.pid, 0)
        return 1
    elseif !vimproc#kill(s:pp.pid, 0)
        return 1
    else
        return 0
    endif
endfunction

function! Execcmd(cmd)
    let l:proc = vimproc#plineopen2(a:cmd)
    let l:response = ''
    return l:proc
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
