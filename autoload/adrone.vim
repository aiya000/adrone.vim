scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim
"-------------------"


function! adrone#open_view_buffer()
	call adrone#view#open_buffer()
endfunction


function! adrone#reload_view()
	" Same as Open
	call adrone#view#open_buffer()
endfunction


function! adrone#open_say_buffer()
	call adrone#say#open_buffer()
endfunction


function! adrone#post_say()
	call adrone#say#post()

	" Reload View
	call adrone#view#open_buffer()
endfunction


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
