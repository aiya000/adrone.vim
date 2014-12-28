scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim
"-------------------"


" Open view buffer
function! adrone#view#open_buffer()
	let l:adrone_file = g:adrone_say_output_filepath
	execute ':edit' l:adrone_file

	setl nonumber
	setl nomodifiable

	call s:define_default_buffer_key_mappings()
endfunction


function! s:define_default_buffer_key_mappings()
	nmap <silent><buffer> <C-r> <Plug>(adrone_reload_view)
	nmap <silent><buffer> s     <Plug>(adrone_open_say)
endfunction


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
