" Vim compiler file
" Language:		gbtest
" Maintainer:		Tim Pope <vimNOSPAM@tpope.org>
" URL:			https://github.com/vim-ruby/vim-ruby
" Release Coordinator:	Doug Kearns <dougkearns@gmail.com>

if exists("current_compiler")
  finish
endif
let current_compiler = "gbtest"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=gbtest

CompilerSet errorformat=
    \%f:%l:\ %tarning:\ %m,
    \%E%.%#:in\ `load':\ %f:%l:%m,
    \%E%f:%l:in\ `%*[^']':\ %m,
    \%-Z\ \ \ \ \ \#\ %f:%l:%.%#,
    \%E\ \ %\\d%\\+)%.%#,
    \%C\ \ \ \ \ %m,
    \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save
