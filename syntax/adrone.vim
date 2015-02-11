scriptencoding utf-8

if exists('b:current_syntax')
  finish
endif
"-------------------"

syntax case match

syntax cluster adrone_home_syn contains=adrone_saparator


"TODO: correspond g:adrone_say_separator_string
syntax match adrone_saparator '^----------*$'
highlight default adrone_saparator guifg=#444444


" ???
syntax region adrone_syn contains=adrone_syn,@adrone_home_syn start="^" end="$"

highlight def link adrone_syn


"-------------------"
let b:current_syntax = 'adrone_home'
