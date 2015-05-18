scriptencoding utf-8

if exists('g:loaded_adrone')
  finish
endif
let g:loaded_adrone = 1

let s:save_cpo = &cpo
set cpo&vim
"-------------------"
"Private

let s:AT_DAILY_PAGE = -2
let g:adrone_private_field = {}
let g:adrone_private_field['pages']   = []
let g:adrone_private_field['page_at'] = s:AT_DAILY_PAGE

"-------------------"

let s:adrone_version = '0.0.17'

augroup AdroneSay
	autocmd!
augroup END


let g:adrone_say_output_dir           = get(g:, 'adrone_say_output_dir', expand('~/.adrone'))
let g:adrone_say_separator_string     = get(g:, 'adrone_say_separator_string', repeat('-', 120))
let g:adrone_say_buffer_size          = get(g:, 'adrone_say_buffer_size', 2)
let g:adrone_home_default_keymappings = get(g:, 'adrone_home_default_keymappings', 1)



command! AdroneOpen    call adrone#open_home_buffer()
command! AdroneSay     call adrone#open_say_buffer()
command! AdroneVersion echo s:adrone_version



" Home key mappings
nnoremap <silent> <Plug>(adrone_home_reload)   :<C-u>call adrone#reload_home()<CR>
nnoremap <silent> <Plug>(adrone_home_future)   :<C-u>call adrone#load_future_adlog()<CR>
nnoremap <silent> <Plug>(adrone_home_past)     :<C-u>call adrone#load_past_adlog()<CR>
nnoremap <silent> <Plug>(adrone_home_open_say) :<C-u>call adrone#open_say_buffer()<CR>

" Say key mappings
nnoremap <silent> <Plug>(adrone_say_post) :<C-u>call adrone#post_say()<CR>


"-------------------"
let &cpo = s:save_cpo
unlet s:save_cpo
