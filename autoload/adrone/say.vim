scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim
"-------------------"


" Open say buffer
function! adrone#say#open_buffer()
	let l:buf_size = g:adrone_say_buffer_size

	execute 'botright split' 'adrone_say'
	execute l:buf_size . ' wincmd _'

	call s:define_default_buffer_key_mappings()
	call s:adrone_say_option_setting()
	call s:adrone_say_action_setting()

	startinsert
endfunction


" Defining plugin buffer keymappings
function! s:define_default_buffer_key_mappings()
	nmap <silent><buffer> <CR> <Plug>(adrone_post_say)
endfunction


" Optimize options in buffer
function! s:adrone_say_option_setting()
	setf adrone_say

	setl bufhidden=hide
	setl nobuflisted

	setl nomodified
	setl modifiable

	setl nonumber
	setl statusline=[adrone_say]
endfunction


" Setting for say buffer
function! s:adrone_say_action_setting()
	augroup AdroneSay
		autocmd!
		autocmd BufWriteCmd <buffer> echohl Error | echo 'please enter to say' | echohl None
	augroup END
endfunction


" Say to output file
function! adrone#say#post()
	let l:output_file = g:adrone_say_output_filepath
	call s:if_absent_make(l:output_file)

	try
		" Getting details
		let l:say_text  = s:get_format_text()

		" Apply to output file
		call writefile([l:say_text], l:output_file, 'a')

		echo 'Output OK'
		bdelete!
	catch
		" If happened the errors, don't close say buffer
		echoerr v:exception
	endtry
endfunction


" If not exists outputfile, make it
function! s:if_absent_make(filepath)
	if !filereadable(a:filepath)
		let l:separator = g:adrone_say_separator_string
		call writefile([l:separator], a:filepath)
	endif
endfunction


" Read and Format say_buffer text
function! s:get_format_text()
	let l:separator   = g:adrone_say_separator_string
	let l:date_string = strftime('%x %H:%M', localtime())
	let l:lines       = getbufline('%', 0, '$')

	let l:head_line_head = '[[' . l:date_string . ']]' . '  '
	let l:text_head = l:head_line_head . l:lines[0]

	let l:line_head_len  = strwidth(l:head_line_head)
	let l:tail_line_head = repeat(' ', l:line_head_len)
	let l:text_tail      = map(l:lines[1:], "'" . l:tail_line_head . "' . v:val")
	let l:text = [l:separator] + [l:text_head] + l:text_tail
	return l:text
endfunction


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
