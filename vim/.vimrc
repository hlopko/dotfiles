set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

filetype plugin indent on     " required!
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'vim-scripts/AutoTag'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-fugitive'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'tsaleh/vim-matchit'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'puppetlabs/puppet-syntax-vim'
Bundle 'tpope/vim-ragtag'
Bundle 'SirVer/ultisnips'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-bundler'
Bundle 'tpope/vim-endwise'
Bundle 'airblade/vim-gitgutter'
Bundle 'plasticboy/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-surround'

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
  au FileType html,css,lisp,ruby,eruby setlocal ts=2 sts=2 sw=2 expandtab
  au FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  au FileType c,cpp,java setlocal ts=4 sts=4 sw=4 expandtab

  au BufNewFile,BufRead *.rss setfiletype xml
  au BufNewFile,BufRead *.md setfiletype markdown
  au BufNewFile,BufRead *.stx setfiletype st
  au BufNewFile,BufRead *.stx_test setfiletype st
  au BufNewFile,BufRead *.lisp setfiletype lisp
  au BufNewFile,BufRead *.rb setfiletype ruby
  au BufNewFile,BufRead *.task setfiletype ruby
  au BufNewFile,BufRead *.json setfiletype javascript
  au BufNewFile,BufRead *.js setfiletype javascript
  au BufNewFile,BufRead *.prolog setfiletype prolog
  au BufNewFile,BufRead *.pp setfiletype puppet
  au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Guardfile,config.ru}    set ft=ruby
  au BufRead,BufNewFile {*.less}    set ft=css
endif

"we dont need to be compatible with vi
set nocompatible

"write per file commands
set modelines=0

"indent size and stuff
set ts=4 sts=4 sw=4 noexpandtab

",l to show unprintable characters
nmap <leader>l :set list!<CR>

"set nice chars for tabs and eols
set lcs=tab:▸\ ,eol:⤦

"set encoding to utf8
set encoding=utf-8

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

"show relative instead of absolute line numbers
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
nnoremap <tab> %
vnoremap <tab> %

"break long lines
set wrap
set textwidth=60
set formatoptions=qrn1

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

"Command-T
" Open files with <leader>f
map <leader>f :CommandTFlush<cr>\|:CommandT<cr>
let g:CommandTAcceptSelectionSplitMap=['<C-g>']
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

function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

"strip all trailing spaces in file to \W
nnoremap <leader>W :call <SID>StripTrailingWhitespaces()<CR>

"reselect just pasted text
nnoremap <leader>v V`]

"go back to normal mode with kk 
inoremap kk <ESC>

"save file :)
nnoremap WW :w<cr>

"windows changing
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

"window resizing
map + <C-W>+
map - <C-W>>

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
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

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

"disable folding for markdown
let g:vim_markdown_folding_disabled=1

"use nerdtree instead of netrw
let NERDTreeHijackNetrw=1

"delete current buffer file
command DeleteCurrentFile call delete(expand('%')) | bdelete!
