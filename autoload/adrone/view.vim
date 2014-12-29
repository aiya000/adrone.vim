scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim
"-------------------"


" Open view buffer
function! adrone#view#open_buffer()
	let l:adrone_file = g:adrone_say_output_filepath
	execute ':edit' l:adrone_file

	call s:adrone_view_option_setting()
	call s:define_default_buffer_key_mappings()
endfunction


" Optimize options in buffer
function! s:adrone_view_option_setting()
	setf adrone_view

	setl nomodifiable
	setl noswapfile
	setl buftype=nofile

	setl nonumber
	setl statusline=adrone_view
endfunction


" Defining plugin buffer keymappings
function! s:define_default_buffer_key_mappings()
	nmap <silent><buffer> <C-r> <Plug>(adrone_reload_view)
	nmap <silent><buffer> s     <Plug>(adrone_open_say)
endfunction


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
