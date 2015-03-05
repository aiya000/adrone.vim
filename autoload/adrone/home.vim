scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim
"-------------------"

let s:AT_DAILY_PAGE = -2
let s:AT_LAST_PAGE  = -1

"-------------------"


"" Open home buffer
function! adrone#home#open_buffer() "{{{
	" Get page adlog file list
	let g:adrone_private_field['pages'] = s:get_page_list()
	"let g:adrone_private_field['page_at'] = 0

	" Open view buffer
	call s:open_frame()
	call s:adrone_home_option_setting()
	call s:define_default_buffer_key_mappings()
endfunction "}}}


"" Read adrone log 'adlog' to abstract frame
function! adrone#home#read_adlog(adlog_file) "{{{
	setl modifiable
	"TODO: if opened another buffer, not deleting
	%d

	try
		let l:adlog = readfile(a:adlog_file)
	catch /E484/
		" if not exists target adlog file
		execute 'normal! a' . g:adrone_say_separator_string . "\n"
		\                   . 'nothing say log'             . "\n"
		\                   . g:adrone_say_separator_string . "\n"
		setl nomodifiable
		return
	endtry

	for l:line in l:adlog
		execute 'normal! a' . l:line . "\n"
	endfor
	execute 'normal! ddgg'

	setl nomodifiable
endfunction "}}}


"" Read next adlog
function! adrone#home#next_adlog() "{{{
	let l:pages   = g:adrone_private_field['pages']
	let l:current = g:adrone_private_field['page_at']   " for readability
	let g:adrone_private_field['page_at'] = l:current == s:AT_DAILY_PAGE
	\                                     ?   len(l:pages) - 1
	\                                     : l:current == (len(l:pages) - 1)
	\                                     ?   (len(l:pages) - 1)
	\                                     :   l:current + 1

	call adrone#home#read_adlog(l:pages[g:adrone_private_field['page_at']])
endfunction "}}}


"" Read previous adlog
function! adrone#home#prev_adlog() "{{{
	let l:pages   = g:adrone_private_field['pages']
	let l:current = g:adrone_private_field['page_at']   " for readability
	let g:adrone_private_field['page_at'] = l:current == s:AT_DAILY_PAGE
	\                                     ?   (len(l:pages) - 1)
	\                                     : (l:current - 1) == s:AT_LAST_PAGE
	\                                     ?   0
	\                                     :   l:current - 1

	call adrone#home#read_adlog(l:pages[g:adrone_private_field['page_at']])
endfunction "}}}


"#-=- -=- -=- -=- -=- -=- -=- -=- -=-#"


" Return paths of adrog file
function! s:get_page_list() "{{{
	return split(glob(g:adrone_say_output_dir . '/*'), '\n')
endfunction "}}}


" Open abstract frame with default page (home)
function! s:open_frame() "{{{
	let l:daily_name = strftime('%Y-%m-%d_adrone_say.adlog', localtime())
	let l:daily_file = g:adrone_say_output_dir . '/' . l:daily_name

	call adrone#home#read_adlog(l:daily_file)
endfunction "}}}


" Optimize options in buffer
function! s:adrone_home_option_setting() "{{{
	setl nomodifiable
	setl noswapfile
	setl buftype=nofile

	setl nonumber
	setl statusline=[adrone_home]

	setf adrone_home
endfunction "}}}


" Defining plugin buffer keymappings
function! s:define_default_buffer_key_mappings() "{{{
	nmap <silent><buffer> <C-r> <Plug>(adrone_home_reload)
	nmap <silent><buffer> bb    <Plug>(adrone_home_next)
	nmap <silent><buffer> ff    <Plug>(adrone_home_prev)
	nmap <silent><buffer> s     <Plug>(adrone_home_open_say)
endfunction "}}}


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
