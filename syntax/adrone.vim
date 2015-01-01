scriptencoding utf-8

if exists('b:current_syntax')
  finish
endif
"-------------------"


syntax match adrone_saparator '^----------*$'
hi def link adrone_saparator Boolean
"highlight default adrone_saparator guifg=#444444


let b:current_syntax = 'adrone_home'
