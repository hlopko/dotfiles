"we dont need to be compatible with vi
set nocompatible

" Plugins declarations {{{
filetype off " required for vundle

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'kchmck/vim-coffee-script'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-endwise'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-rsi'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-projectionist'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'rking/ag.vim'
Plugin 'Peeja/vim-cdo'
Plugin 'noprompt/vim-yardoc'
Plugin 'SirVer/ultisnips'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'Soares/butane.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'mhlopko/witness_protection'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" }}}

" Basic config {{{
let mapleader = ","
set backupdir=~/.vim-tmp
set directory=~/.vim-tmp
set history=10000
set undofile
set undodir=~/.vim-tmp
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

syntax on
" Set number of colors
set t_Co=16
set background=dark
colorscheme solarized
"colorscheme Tomorrow

" Write per file commands
set modelines=0

" Indent size and stuff
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab

" Set encoding to utf8
set encoding=utf-8

" Set nice chars for tabs and eols
if has("multi_byte")
	set listchars=tab:▸\ ,eol:⤦
endif

" Show at least 6 lines before and after cursor pos
set scrolloff=6

" Automatically indent on newline
set autoindent

" Show info on in which mode you're in
set showmode

" Show partial command
set showcmd

" Hide hidden buffers (on :q! for example)
set hidden

" Complete commands on tab
set wildmenu
set wildmode=list:longest

" Tell vim we have fast terminal - smoother
set ttyfast

" Make vim behave nicely with backspace
set backspace=indent,eol,start

" Always show status
set laststatus=2

" Show both absolute and relative line numbers
set number
set relativenumber

" Ignore case on search
set ignorecase

" If all chars are in lowercase, ignore case
set smartcase

" On rewrite put global flag in by default
set gdefault

" On search move behind the occurence (so you can jump with n)
set incsearch

" Highlight search match
set showmatch

" Highlight all occurrences
set hlsearch

" Open splits to the right or below current window
set splitbelow
set splitright

" Break long lines
set wrap
set textwidth=72
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%85v', 100)

set formatoptions=qrn1

" Set min width of window
set winwidth=90

" Ignore whitespace changes in diff
set diffopt+=iwhite

" Use vertical split on vimdiff
set diffopt+=vertical

set diffexpr=""

" Ignore some files
set wildignore+=*.o,*.obj,.git,.svn,public,tmp,app/assets/images

" Automatically save before commands like next or make
set autowrite

" Do not redraw while in macros
set lazyredraw

" Enable matchit macros
runtime macros/matchit.vim

" Disable folding for markdown
let g:vim_markdown_folding_disabled=1

" Embedded languages in markdown
let g:markdown_fenced_languages = [ 'ruby', 'st', 'c' ]

" }}}

" Statusline {{{

set statusline=%<      " Truncate from here if line is too long
set statusline+=%f     " Path to the file
set statusline+=%h     " Show help buffer flag is so
set statusline+=%m     " Show modified flag is so
set statusline+=%r     " Show readonly flag is so
set statusline+=\ -\   " separator
set statusline+=%y     " filetype

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}    " Add fugitive niceties
endif

set statusline+=%=     " move over to the right
set statusline+=%-14.(%l/%L,%c%) " Start group, line/total lines, column, end group
set statusline+=\ %P   " Percentage through file

" }}}

" Autocmds {{{
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal g'\"" | endif

" Syntax of these languages is fussy over tabs Vs spaces
au FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

au FileType c,cpp,java,javascript setlocal ts=4 sts=4 sw=4 expandtab
"hide all fugitive buffers so we dont have to close them manually
au BufReadPost fugitive://* set bufhidden=delete
au BufNewFile,BufReadPost *.stx set filetype=st
au BufNewFile,BufReadPost *.stx_test set filetype=st
au BufNewFile,BufReadPost *.task set filetype=ruby
au BufNewFile,BufReadPost *.json set filetype=javascript
au BufNewFile,BufReadPost *.md set filetype=markdown
au BufNewFile,BufReadPost {Gemfile,Rakefile,Vagrantfile,Thorfile,Guardfile,config.ru} set filetype=ruby

augroup filetype_vim
  au!
  au FileType vim setlocal foldmethod=marker
augroup end

augroup filetype_muttrc
  au!
  au FileType muttrc setlocal foldmethod=marker
augroup end

augroup erb_embedded_languages
  au!
  au BufNewFile,BufReadPre *.ajax_html.erb let b:eruby_subtype = 'html'
  " au BufNewFile,BufReadPre *.md.erb let b:eruby_subtype = 'markdown'
augroup end

autocmd bufwritepost .vimrc source $MYVIMRC

autocmd FileType ruby
  \ if expand("%") =~# '_spec\.rb$' |
  \   compiler gbtest | setlocal makeprg=gbtest\ $*|
  \ endif
" autocmd FileType ruby
"       \ let b:start = executable('pry') ? 'pry -r "%:p"' : 'irb -r "%:p"' |
"       \ if expand('%') =~# '_test\.rb$' |
"       \   let b:dispatch = 'testrb %' |
"       \ elseif expand('%') =~# '_spec\.rb$' |
"       \   let b:dispatch = 'gbtest %' |
"       \ elseif !exists('b:dispatch') |
"       \   let b:dispatch = 'ruby -wc %' |
"       \ endif

" }}}

" Code {{{

" Gary Bernhardt's selecta awesomeness
" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Gary Bernhardt's rspec awesomeness
function! RunTestFile(...)
  if a:0
    let command_suffix = a:1
  else
    let command_suffix = ""
  endif

  " Run the tests for the previously-marked file.
  let in_test_file = match(expand("%"), '_spec.rb$') != -1
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

function! RunTests(filename)
  " Write the file and run tests for the given filename
  :w
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  if filereadable("/home/m/bin/gbtest")
    exec ":Dispatch gbtest " . a:filename
  else
    exec ":!rspec --color " . a:filename
  end
endfunction

" Drew Neil's hide quickfix awesomeness
function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! BufferIsOpen(bufname)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      return 1
    endif
  endfor
  return 0
endfunction

function! ToggleQuickfix()
  if BufferIsOpen("Quickfix List")
    cclose
  else
    call OpenQuickfix()
  endif
endfunction

function! OpenQuickfix()
  cgetfile tmp/quickfix
  topleft cwindow
  if &ft == "qf"
      cc
  endif
endfunction

command! SSpring !spring stop

" Open or create spec file
function! get_spec:()
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

" }}}

" VimWiki stuff {{{
let g:vimwiki_list = [{'path': '/home/m/vimwiki/',
   \ 'syntax': 'markdown',
   \ 'nested_syntaxes': {'ruby': 'ruby', 'bash': 'bash', 'java': 'java', 'c': 'c', 'js': 'javascript', 'html': 'html'},
   \ 'ext': '.md'}]
let g:vimwiki_global_ext = 0

function! SearchInDefaultWiki()
  let pattern = input("Search pattern in default wiki: ", '')
  exec ":VimwikiIndex"
  exec "VimwikiSearch ".pattern
endfunction

" }}}

" Mappings {{{

",l to show unprintable characters
nnoremap <leader>l :set list!<CR>

" leader + space will clear search highlights
nnoremap <leader><space> :noh<cr>

" Tab will work for bracket matching
nnoremap <tab> %
vnoremap <tab> %

" Windows changing
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" Window resizing
nnoremap + <C-W>>
nnoremap _ <C-W><

" Switch tabs
nnoremap [T :tabprev<cr>
nnoremap ]T :tabnext<cr>

"j k return to their initial column
nnoremap j gj
nnoremap k gk

"don't you hate when you accidentally hit f1?
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find_files_exclude_boring", "", ":e")<cr>
" Find files using ctags
nnoremap <leader>o :call SelectaCommand("cut -d$'\t' -f 1 .git/tags", "", ":tag")<cr>

" redraw vim
nnoremap <leader>R :redraw!<cr>

nnoremap <leader>t :call RunTestFile()<cr>
nnoremap <leader>T :call RunNearestTest()<cr>
nnoremap <leader>a :call RunTests('')<cr>

nnoremap <leader>Q :call ToggleQuickfix()<cr>

"reselect just pasted text
nnoremap <leader>v V`]

"go back to normal mode with kj
inoremap kj <ESC>
inoremap Kj <ESC>
inoremap kJ <ESC>
inoremap KJ <ESC>

" Save file :)
nnoremap WW :w<cr>

" :edit in file in the same dir as current file shortcuts
cnoremap %% <C-R>=expand('%:h').'/'<cr>

"insert mode tag completion on ctrl ]
inoremap <c-]> <c-x><c-]>

"make ,b call rake
nnoremap <leader>b :w<cr>:!echo;echo;echo;echo;echo;echo;echo;echo;echo;<cr>:!rake<cr>

"remap Q to esc so we dont go to ed mode accidentally
noremap Q <ESC>

nnoremap <silent> ,A :call get_spec:()<cr><cr>

nnoremap <leader>rap  :RAddParameter<cr>
nnoremap <leader>rcpc :RConvertPostConditional<cr>
nnoremap <leader>rel  :RExtractLet<cr>
vnoremap <leader>rec  :RExtractConstant<cr>
vnoremap <leader>relv :RExtractLocalVariable<cr>
nnoremap <leader>rit  :RInlineTemp<cr>
vnoremap <leader>rrlv :RRenameLocalVariable<cr>
vnoremap <leader>rriv :RRenameInstanceVariable<cr>
vnoremap <leader>rem  :RExtractMethod<cr>

nmap <leader>q :StripWhitespace<cr>

noremap <leader>x  WW:Bclose<cr>

nmap <leader>w/ <Plug>VimwikiUISelect
nmap <leader>ws :call SearchInDefaultWiki()<cr>
vmap <leader>wi <esc>:silent '<,'>:w !to-wiki-inbox -f '%:p'<cr><cr>

" Open raw quick fix window
nnoremap <leader>r :Copen!<cr>

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" }}}

