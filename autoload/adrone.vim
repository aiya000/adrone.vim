scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim
"-------------------"


function! adrone#open_say_buffer()
	execute 'botright split' 'adrone_say'
	execute '5 wincmd _'
	let &filetype = 'adrone_say'

	call s:define_default_buffer_key_mappings()
endfunction


function! s:define_default_buffer_key_mappings()
	nmap <silent><buffer> <CR> <Plug>(adrone_say_post)
endfunction


function! adrone#post_say()
	throw 'NotImplementedException'
endfunction


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
