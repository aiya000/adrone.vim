scriptencoding utf-8
let s:save_cpo = &cpo
set cpo&vim
"-------------------"


"" Open home buffer
function! adrone#home#open_buffer()
	call s:open_frame()
	call s:define_default_buffer_key_mappings()
endfunction


"" Read adrone log 'adlog' to abstract frame
function! adrone#home#read_adlog(adlog_file)
	enew!
	call s:adrone_home_option_setting()
	set modifiable

	try
		let l:adlog = readfile(a:adlog_file)
	catch /E484/
		" if not exists target adlog file
		execute 'normal! a' . g:adrone_say_separator_string . "\n"
		\                   . 'nothing say log'             . "\n"
		\                   . g:adrone_say_separator_string . "\n"
		return
	endtry

	for l:line in l:adlog
		execute 'normal! a' . l:line . "\n"
	endfor
	execute 'normal! ddgg'

	set nomodifiable
endfunction


"" Read next adlog
function! adrone#home#next_adlog()
	throw 'not implemented next adlog'
endfunction


"" Read previous adlog
function! adrone#home#prev_adlog()
	throw 'not implemented previous adlog'
endfunction


"#-=- -=- -=- -=- -=- -=- -=- -=- -=-#"


" Open abstract frame with default page (home)
function! s:open_frame()
	let l:daily_name = strftime('%Y-%m-%d_adrone_say.adlog', localtime())
	let l:daily_file = g:adrone_say_output_dir . '/' . l:daily_name

	call adrone#home#read_adlog(l:daily_file)
endfunction


" Optimize options in buffer
function! s:adrone_home_option_setting()
	setl nomodifiable
	setl noswapfile
	setl buftype=nofile

	setl nonumber
	setl statusline=[adrone_home]

	setf adrone_home
endfunction


" Defining plugin buffer keymappings
function! s:define_default_buffer_key_mappings()
	nmap <silent><buffer> <C-r> <Plug>(adrone_home_reload)
	nmap <silent><buffer> ff    <Plug>(adrone_home_next)
	nmap <silent><buffer> bb    <Plug>(adrone_home_prev)
	nmap <silent><buffer> s     <Plug>(adrone_home_open_say)
endfunction


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
