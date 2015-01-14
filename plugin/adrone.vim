scriptencoding utf-8

if exists('g:loaded_adrone')
  finish
endif
let g:loaded_adrone = 1

let s:save_cpo = &cpo
set cpo&vim
"-------------------"

let s:adrone_version = '0.0.1'

augroup AdroneSay
	autocmd!
augroup END


let g:adrone_say_output_filepath  = get(g:, 'adrone_say_output_filepath', expand('~/.adrone_say_log'))
let g:adrone_say_separator_string = get(g:, 'adrone_say_separator_string', repeat('-', 120))
let g:adrone_say_buffer_size      = get(g:, 'adrone_say_buffer_size', 2)



command! AdroneOpen    call adrone#open_home_buffer()
command! AdroneSay     call adrone#open_say_buffer()
command! AdroneVersion echo s:adrone_version


nnoremap <silent> <Plug>(adrone_open_say)    :<C-u>call adrone#open_say_buffer()<CR>
nnoremap <silent> <Plug>(adrone_post_say)    :<C-u>call adrone#post_say()<CR>
nnoremap <silent> <Plug>(adrone_reload_home) :<C-u>call adrone#reload_home()<CR>


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
