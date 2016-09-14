" http://learnvimscriptthehardway.stevelosh.com/
" http://ricostacruz.com/cheatsheets/vimscript.html
" http://www.ibm.com/developerworks/library/l-vim-script-1/

function! GlobalCreateMyChannel()
    let g:mychannel = CreateMyChannel()
endfunction

function! GlobalSendToMyChannel(msg)
    call SendToMyChannel(g:mychannel,a:msg)
endfunction

function! s:Handle(channel, msg)
  echo 'Received: ' . a:msg
endfunction

function! CreateMyChannel()
    let channel = ch_open("127.0.0.1:7777", {"callback":"s:Handle"})
    return l:channel
endfunction

function! SendToMyChannel(chan,msg)
    call ch_sendexpr(a:chan,a:msg)
endfunction
