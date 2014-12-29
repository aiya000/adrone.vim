scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim
"-------------------"


" Open home buffer
function! adrone#home#open_buffer()
	let l:adrone_file = g:adrone_say_output_filepath
	silent execute ':edit' l:adrone_file

	call s:adrone_home_option_setting()
	call s:define_default_buffer_key_mappings()
endfunction


" Optimize options in buffer
function! s:adrone_home_option_setting()
	setf adrone_home

	setl nomodifiable
	setl noswapfile
	setl buftype=nofile

	setl nonumber
	setl statusline=[adrone_home]
endfunction


" Defining plugin buffer keymappings
function! s:define_default_buffer_key_mappings()
	nmap <silent><buffer> <C-r> <Plug>(adrone_reload_home)
	nmap <silent><buffer> s     <Plug>(adrone_open_say)
endfunction


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
