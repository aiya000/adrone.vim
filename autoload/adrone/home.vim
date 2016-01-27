scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim
"-------------------"

" Default page number on started up
let s:AT_DAILY_PAGE = -2 | lockvar s:AT_DAILY_PAGE

" Oldest page number
let s:AT_LAST_PAGE  = -1 | lockvar s:AT_LAST_PAGE

"-------------------"

"" Open home buffer
function! adrone#home#open_buffer() "{{{
	" Get page adlog file list
	let g:adrone#pages = s:get_page_list()

	" Open view buffer
	call s:open_frame()

	if g:adrone_home_default_keymappings
		call s:define_default_buffer_key_mappings()
	endif
endfunction "}}}

"" Read adrone log 'adlog' to abstract frame
function! adrone#home#read_adlog(adlog_file) "{{{
	" Unlock temporary
	setl modifiable
	" Clean up screen
	%d

	" Open adlog file or message screen
	try
		let l:adlog = readfile(a:adlog_file)
	catch /E484/
		" If not exists target adlog file
		execute 'normal! a' . g:adrone_say_separator_string . "\n"
		\                   . 'nothing say log'             . "\n"
		\                   . g:adrone_say_separator_string . "\n"
		setl nomodifiable
		return
	endtry

	" Read adlog detail
	for l:line in l:adlog
		execute 'normal! a' . l:line . "\n"
	endfor

	" Delete brank line and Move to top
	execute 'normal! ddgg'
	" Lock screen
	setl nomodifiable
endfunction "}}}

"" Read back page adlog
function! adrone#home#future_adlog() "{{{
	let l:pages        = g:adrone#pages
	let l:current_page = g:adrone#page_at   " for readability
	let l:newest_page  = len(l:pages) - 1
	let g:adrone#page_at =
	\		  l:current_page == s:AT_DAILY_PAGE ? l:newest_page
	\		: l:current_page == l:newest_page   ? l:newest_page
	\		                                    : l:current_page + 1

	call adrone#home#read_adlog(l:pages[g:adrone#page_at])
endfunction "}}}

"" Read next page adlog
function! adrone#home#past_adlog() "{{{
	let l:pages        = g:adrone#pages
	let l:current_page = g:adrone#page_at   " for readability
	let l:newest_page  = len(l:pages) - 1
	let g:adrone#page_at =
	\		  l:current_page     == s:AT_DAILY_PAGE ? l:newest_page - 1
	\		: l:current_page - 1 == s:AT_LAST_PAGE  ? l:current_page
	\		                                        : l:current_page - 1

	call adrone#home#read_adlog(l:pages[g:adrone#page_at])
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

	" If opened another buffer, Open new scratch buffer
	if expand('%') !=# ''
		new
	endif
	setl nomodifiable
	setl noswapfile
	setl buftype=nofile
	setl nonumber
	setl statusline=[adrone_home]
	setf adrone_home

	" Read detail for abstract frame
	call adrone#home#read_adlog(l:daily_file)
endfunction "}}}

" Define plugin buffer keymappings
function! s:define_default_buffer_key_mappings() "{{{
	nmap <silent><buffer> <C-r> <Plug>(adrone_home_reload)
	nmap <silent><buffer> b     <Plug>(adrone_home_future)
	nmap <silent><buffer> f     <Plug>(adrone_home_past)
	nmap <silent><buffer> s     <Plug>(adrone_home_open_say)
endfunction "}}}

"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
