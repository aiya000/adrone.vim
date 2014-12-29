scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim
"-------------------"


function! adrone#open_home_buffer()
	call adrone#home#open_buffer()
endfunction


function! adrone#reload_home()
	" Same as Open
	call adrone#home#open_buffer()
endfunction


function! adrone#open_say_buffer()
	call adrone#say#open_buffer()
endfunction


function! adrone#post_say()
	call adrone#say#post()

	" Reload home
	call adrone#home#open_buffer()
endfunction


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
