scriptencoding utf-8

if exists('g:loaded_adrone')
  finish
endif
let g:loaded_adrone = 1

let s:save_cpo = &cpo
set cpo&vim
"-------------------"

let s:adrone_version = '0.0.15'

augroup AdroneSay
	autocmd!
augroup END


let g:adrone_say_output_dir       = get(g:, 'adrone_say_output_dir', expand('~/.adrone'))
let g:adrone_say_separator_string = get(g:, 'adrone_say_separator_string', repeat('-', 120))
let g:adrone_say_buffer_size      = get(g:, 'adrone_say_buffer_size', 2)



command! AdroneOpen    call adrone#open_home_buffer()
command! AdroneSay     call adrone#open_say_buffer()
command! AdroneVersion echo s:adrone_version



" Home key mappings
nnoremap <silent> <Plug>(adrone_home_reload) :<C-u>call adrone#reload_home()<CR>
nnoremap <silent> <Plug>(adrone_home_next)   :<C-u>call adrone#load_next_log()<CR>
nnoremap <silent> <Plug>(adrone_home_prev)   :<C-u>call adrone#load_prev_log()<CR>
nnoremap <silent> <Plug>(adrone_home_open_say)    :<C-u>call adrone#open_say_buffer()<CR>

" Say key mappings
nnoremap <silent> <Plug>(adrone_say_post)    :<C-u>call adrone#post_say()<CR>


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
