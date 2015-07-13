scriptencoding utf-8

if exists('b:current_syntax')
  finish
endif
"-------------------"

syntax match AdroneSeparator "^--*$" display
highlight default link AdroneSeparator ErrorMsg

"-------------------"
let b:current_syntax = 'adrone_home'
