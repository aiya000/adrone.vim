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


function! adrone#load_next_adlog()
	call adrone#home#next_adlog()
endfunction


function! adrone#load_prev_adlog()
	call adrone#home#prev_adlog()
endfunction


function! adrone#post_say()
	call adrone#say#post()

	if s:adrone_home_window_exists()
		" Reload home
		call adrone#home#open_buffer()
	endif
endfunction


function! s:adrone_home_window_exists()
	for l:w in range(1, winnr('$'))
		let l:buf_filetype = getwinvar(w, '&filetype')

		if l:buf_filetype ==# 'adrone_home'
			return 1
		endif
	endfor

	return 0
endfunction


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
