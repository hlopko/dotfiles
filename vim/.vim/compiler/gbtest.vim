" Vim compiler file
" Language:		gbtest
" Maintainer:		Tim Pope <vimNOSPAM@tpope.org>
" URL:			https://github.com/vim-ruby/vim-ruby
" Release Coordinator:	Doug Kearns <dougkearns@gmail.com>

" if exists("current_compiler")
"   finish
" endif
let current_compiler = "gbtest"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=gbtest

CompilerSet errorformat=
    \%E%f:%l:in\ `%*[^']':\ %m,
    \%-Z\ \ \ \ \ \#\ %f:%l:%.%#,
    \%E\ \ %\\d%\\+)\ %m,
    \%-G%\\s%#(compared\ using\ ==),
    \%C\ \ \ \ \ Failure/Error:\ %m\,
    \%C\ \ \ \ \ %m,
    \%+GDuration\ %.%#,
    \%-GFailures:,
    \%-GRandomized\ with\ seed\ %\\d%\\+,
    \%-GFailed\ examples:,
    \%-G\ examples:,
    \%+G%\\d%\\+\ examples%\\,\ 0\ failures,
    \%-G%\\d%\\+\ examples%\\,\ %\\d%\\+\ failures,
    \%-GFinished\ in%.%#,
    \%-Grspec\ %./spec%.%#,
    \%-G%[%.F%\\*]%#,
    \%-G%[%\\s]%#,
    \%-G%.%#

CompilerSet efm+=%-G%.%#,.

let &cpo = s:cpo_save
unlet s:cpo_save
