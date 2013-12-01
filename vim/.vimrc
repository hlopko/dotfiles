set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'vim-scripts/AutoTag'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-fugitive'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'puppetlabs/puppet-syntax-vim'
Bundle 'tpope/vim-ragtag'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle 'garbas/snipmate.vim'
Bundle "honza/vim-snippets"
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-endwise'
Bundle 'airblade/vim-gitgutter'
Bundle 'tpope/vim-markdown'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-rake'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-rvm'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'nelstrom/vim-visual-star-search'
Bundle 'thoughtbot/vim-rspec'
Bundle 'ecomba/vim-ruby-refactoring'
Bundle 'bronson/vim-trailing-whitespace'

filetype plugin indent on     " required!

let mapleader = ","
set backupdir=/tmp
set directory=/tmp
set history=10000
set undofile
set undodir=/tmp
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

syntax on
set t_Co=16
set background=dark
"let g:solarized_termcolors=256
colorscheme solarized
"colorscheme Tomorrow

if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif

  " Syntax of these languages is fussy over tabs Vs spaces
  au FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
  au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

  " Customisations based on house-style (arbitrary)
  au FileType html,css,lisp,ruby,eruby,coffee setlocal ts=2 sts=2 sw=2 expandtab
  au FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  au FileType c,cpp,java setlocal ts=4 sts=4 sw=4 expandtab

  au BufNew,BufNewFile *.rss setfiletype xml
  au BufNew,BufNewFile *.txt,*.text,*.md,*.markdown set ft=markdown
  au BufNew,BufNewFile *.stx setfiletype st
  au BufNew,BufNewFile *.stx_test setfiletype st
  au BufNew,BufNewFile *.lisp setfiletype lisp
  au BufNew,BufNewFile *.task setfiletype ruby
  au BufNew,BufNewFile *.json setfiletype javascript
  au BufNew,BufNewFile *.js setfiletype javascript
  au BufNew,BufNewFile *.prolog setfiletype prolog
  au BufNew,BufNewFile *.pp setfiletype puppet
  au BufNew,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Guardfile,config.ru} set ft=ruby
  au BufNew,BufNewFile {*.less} set ft=css
endif

"we dont need to be compatible with vi
set nocompatible

"write per file commands
set modelines=0

"indent size and stuff
set ts=4 sts=4 sw=4 noexpandtab

",l to show unprintable characters
nmap <leader>l :set list!<CR>

"set encoding to utf8
set encoding=utf-8

"set nice chars for tabs and eols
if has("multi_byte")
	set lcs=tab:▸\ ,eol:⤦
endif

"show at least 6 lines before and after cursor pos
set scrolloff=6

"automatically indent on newline
set autoindent

"show info on in which mode you're in
set showmode

"show partial command
set showcmd

"hide hidden buffers (on :q! for example)
set hidden

"complete commands on tab
set wildmenu
set wildmode=list:longest

"tell vim we have fast terminal - smoother
set ttyfast

"make vim behave nicely with backspace
set backspace=indent,eol,start

"always show status
set laststatus=2

"show both absolute and relative line numbers
set number
set relativenumber

"ignore case on search
set ignorecase

"if all chars are lc, ignore case
set smartcase

"on rewrite put global flag in by default
set gdefault

"on search move behind the occurence (so you can jump with n)
set incsearch

"highlight search match
set showmatch

"highlight all occurrences
set hlsearch

",space will clear search highlights
nnoremap <leader><space> :noh<cr>

",y to yank to system clipboard
map <leader>y "+y

"tab will work for bracket matching
"nmap <tab> %
"vmap <tab> %

"switch between last two files
nnoremap <leader><leader> <C-^>

"write to file requiring sudo
cmap w!! %!sudo tee > /dev/null %

"break long lines
set wrap
set textwidth=60
set formatoptions=qrn1

"set min width of window
set winwidth=80

"left right switch tabs
nnoremap <left> :tabprev<cr>
nnoremap <right> :tabnext<cr>
inoremap <left> <ESC>:tabprev<cr>
inoremap <right> <ESC>:tabnext<cr>

"up down switch buffers
nnoremap <up> :bn<cr>
nnoremap <down> :bp<cr>
inoremap <up> <ESC>:bn<cr>
inoremap <down> <ESC>:bp<cr>

"j k return to their initial column
nnoremap j gj
nnoremap k gk

"don't you hate when you accidentally hit f1?
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

""""""""""""""""""""""""""""""""""""""""""""""""""""""gary bernhardt's rename awesomeness
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <Leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""gary bernhardt's selecta awesomeness
" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    silent let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find_files_exclude_boring", "", ":e")<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""end  gary bernhardt's selecta awesomeness
"""""""""""""""""""""""""""""""""""""""""""""""""start mh's selecta awesomeness
nnoremap <leader>o :call SelectaCommand("cut -d$'\t' -f 1 .git/tags", "", ":tag")<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""end mh's selecta awesomeness
"ignore some files
set wildignore+=*.o,*.obj,.git,.svn,public,tmp,app/assets/images

" This makes RVM work inside Vim. I have no idea why.
set shell=bash

""""""""""""""""""""""""""""""""""""""""""""""""""""""gary bernhardt's rspec awesomeness
map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
map <leader>a :call RunTests('')<cr>
"map <leader>c :w\|:!script/features<cr>
"map <leader>w :w\|:!script/features --profile wip<cr>

function! RunTestFile(...)
    if a:0
        let command_suffix = a:1
    else
        let command_suffix = ""
    endif

    " Run the tests for the previously-marked file.
    let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
    if in_test_file
        call SetTestFile()
    elseif !exists("t:grb_test_file")
        return
    end
    call RunTests(t:grb_test_file . command_suffix)
endfunction

function! RunNearestTest()
    let spec_line_number = line('.')
    call RunTestFile(":" . spec_line_number . " -b")
endfunction

function! SetTestFile()
    " Set the spec file that tests will be run for.
    let t:grb_test_file=@%
endfunction

command StopSpring !spring stop

function! RunTests(filename)
    " Write the file and run tests for the given filename
    :w
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
    if match(a:filename, '\.feature$') != -1
        exec ":!script/features " . a:filename
    else
        if filereadable("/home/m/bin/gbtest")
			exec ":!~/bin/gbtest " . a:filename
        elseif filereadable("Gemfile")
            exec ":!bundle exec rspec --color " . a:filename
        else
            exec ":!rspec --color " . a:filename
        end
    end
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""end of gb awesomeness

"reselect just pasted text
nnoremap <leader>v V`]

"go back to normal mode with kj
inoremap kj <ESC>

"save file :)
nnoremap WW :w<cr>

"windows changing
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

"window resizing
map + <C-W>>
map _ <C-W><
map - <C-W>+

"deselect search
nnoremap <leader><space> :noh<cr>

":edit in file in the same dir as current file shortcuts
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

"better buffer killing
"delete the buffer; keep windows; create a scratch buffer if no buffers left
function s:Kwbd(kwbdStage)
  if(a:kwbdStage == 1)
    if(!buflisted(winbufnr(0)))
      bd
      return
    endif
    let s:kwbdBufNum = bufnr("%")
    let s:kwbdWinNum = winnr()
    windo call s:Kwbd(2)
    execute s:kwbdWinNum . 'wincmd w'
    let s:buflistedLeft = 0
    let s:bufFinalJump = 0
    let l:nBufs = bufnr("$")
    let l:i = 1
    while(l:i <= l:nBufs)
      if(l:i != s:kwbdBufNum)
        if(buflisted(l:i))
          let s:buflistedLeft = s:buflistedLeft + 1
        else
          if(bufexists(l:i) && !strlen(bufname(l:i)) && !s:bufFinalJump)
            let s:bufFinalJump = l:i
          endif
        endif
      endif
      let l:i = l:i + 1
    endwhile
    if(!s:buflistedLeft)
      if(s:bufFinalJump)
        windo if(buflisted(winbufnr(0))) | execute "b! " . s:bufFinalJump | endif
      else
        enew
        let l:newBuf = bufnr("%")
        windo if(buflisted(winbufnr(0))) | execute "b! " . l:newBuf | endif
      endif
      execute s:kwbdWinNum . 'wincmd w'
    endif
    if(buflisted(s:kwbdBufNum) || s:kwbdBufNum == bufnr("%"))
      execute "bd! " . s:kwbdBufNum
    endif
    if(!s:buflistedLeft)
      set buflisted
      set bufhidden=delete
      set buftype=nofile
      setlocal noswapfile
    endif
  else
    if(bufnr("%") == s:kwbdBufNum)
      let prevbufvar = bufnr("#")
      if(prevbufvar > 0 && buflisted(prevbufvar) && prevbufvar != s:kwbdBufNum)
        b #
      else
        bn
      endif
    endif
  endif
endfunction

command! Kwbd call <SID>Kwbd(1)
nnoremap <silent> <Plug>Kwbd :<C-u>Kwbd<CR>
nmap <leader>X <Plug>Kwbd
nmap <leader>x WW,X

"tagbar
let g:tagbar_width=26
nmap <leader>m TagbarToggle<cr>

"cool statusline
if exists("*fugitive#statusline")
	set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
endif

"hide all fugitive buffers so we dont have to close them manually
autocmd BufReadPost fugitive://* set bufhidden=delete

"insert mode tag completion on ctrl ]
inoremap <c-]> <c-x><c-]>

"make ,b call rake
nmap <leader>b :w<cr>:!echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;echo;rake<cr>

"############################### find and replace selected text stuff #####################
" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vmap <leader>z <Esc>:%s/<c-r>=GetVisual()<cr>/
"######################### end of find and replace selected text stuff #####################

" dictionary word autocompletion
set dictionary=/usr/share/dict/words
map <F7> :set complete+=k<CR>
map <S-F7> :set complete-=k<CR>

"ignore whitespace changes in diff
set diffopt+=iwhite
set diffexpr=""

"disable folding for markdown
let g:vim_markdown_folding_disabled=1

"use nerdtree instead of netrw
let NERDTreeHijackNetrw=1

"delete current buffer file
command DeleteCurrentFile call delete(expand('%')) | bdelete!

"enable matchit macros
runtime macros/matchit.vim

"remap Q to leader so we dont go to ed mode accidentally
map Q ,

" open or create spec file
function get_spec:()
	let spec_path=substitute(expand("%:p:h"), "/app/", "/spec/", "")."/"
	let mkdir_command=":!mkdir -p ".spec_path
	silent exec mkdir_command
	let ruby_prog=expand("%:t:r")
	let param_array=split(ruby_prog, '[A-Z][a-z]\+\zs')
	let params=join(param_array, "_")
	let g:spec=spec_path.params."_spec.rb"
	redraw!
	let editcmd="e ".g:spec
	silent exec editcmd
endfunction

nmap <silent> ,A :call get_spec:()<cr><cr>

nnoremap <leader>rap  :RAddParameter<cr>
nnoremap <leader>rcpc :RConvertPostConditional<cr>
nnoremap <leader>rel  :RExtractLet<cr>
vnoremap <leader>rec  :RExtractConstant<cr>
vnoremap <leader>relv :RExtractLocalVariable<cr>
nnoremap <leader>rit  :RInlineTemp<cr>
vnoremap <leader>rrlv :RRenameLocalVariable<cr>
vnoremap <leader>rriv :RRenameInstanceVariable<cr>
vnoremap <leader>rem  :RExtractMethod<cr>

" rcodetools stuff
" plain annotations
map <silent> <F10> !xmpfilter -a<cr>
nmap <silent> <F10> V<F10>
imap <silent> <F10> <ESC><F10>a

" Test::Unit assertions; use -s to generate RSpec expectations instead
map <silent> <S-F10> !xmpfilter -s<cr>
nmap <silent> <S-F10> V<S-F10>
imap <silent> <S-F10> <ESC><S-F10>a

" Annotate the full buffer
" I actually prefer ggVG to %; it's a sort of poor man's visual bell
nmap <silent> <F11> mzggVG!xmpfilter -a<cr>'z
imap <silent> <F11> <ESC><F11>

" assertions
nmap <silent> <S-F11> mzggVG!xmpfilter -u<cr>'z
imap <silent> <S-F11> <ESC><S-F11>a

" Add # => markers
vmap <silent> <F12> !xmpfilter -m<cr>
nmap <silent> <F12> V<F12>
imap <silent> <F12> <ESC><F12>a

" Remove # => markers
vmap <silent> <S-F12> ms:call RemoveRubyEval()<CR>
nmap <silent> <S-F12> V<S-F12>
imap <silent> <S-F12> <ESC><S-F12>a


function! RemoveRubyEval() range
  let begv = a:firstline
  let endv = a:lastline
  normal Hmt
  set lz
  execute ":" . begv . "," . endv . 's/\s*# \(=>\|!!\).*$//e'
  normal 'tzt`s
  set nolz
  redraw
endfunction
