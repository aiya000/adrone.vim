scriptencoding utf-8

if exists('g:loaded_adrone')
  finish
endif
let g:loaded_adrone = 1

let s:save_cpo = &cpo
set cpo&vim
"-------------------"

augroup adrone
	autocmd!
augroup END


let g:adrone_say_output_filepath  = get(g:, 'adrone_say_output_filepath', expand('~/.adrone_say_log'))
let g:adrone_say_separator_string = get(g:, 'adrone_say_separator_string', repeat('-', 40))



command! AdroneSay call adrone#open_say_buffer()


nnoremap <silent> <Plug>(adrone_say_post) :<C-u>call adrone#post_say()<CR>


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
