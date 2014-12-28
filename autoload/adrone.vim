scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim
"-------------------"


" Open say buffer
function! adrone#open_say_buffer()
	execute 'botright split' 'adrone_say'
	execute '5 wincmd _'
	setl nonumber
	let &filetype = 'adrone_say'

	call s:define_default_buffer_key_mappings()
endfunction


" Defining Plugin keymappings
function! s:define_default_buffer_key_mappings()
	nmap <silent><buffer> <CR> <Plug>(adrone_say_post)
endfunction


" Say to output file
function! adrone#post_say()
	let l:say_text    = s:get_format_text()
	let l:output_file = g:adrone_say_output_filepath

	call writefile(l:say_text, l:output_file)
	throw 'Not Implemented for append file'

	bdelete!
	echo 'Sending OK'
endfunction


" Read and Format say_buffer text
function! s:get_format_text()
	let l:separator   = g:adrone_say_separator_string
	let l:date_string = strftime('%x %H:%m', localtime())
	let l:lines       = getbufline('%', 0, '$')
	call map(l:lines, "'    ' . v:val")

	let l:with_date = insert(l:lines, l:date_string, 0)
	let l:text      = insert(l:with_date, l:separator, 0)

	return l:text
endfunction


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
