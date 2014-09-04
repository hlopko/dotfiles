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
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-endwise'
Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-markdown'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'thoughtbot/vim-rspec'
Plugin 'ecomba/vim-ruby-refactoring'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'rking/ag.vim'
Plugin 'Peeja/vim-cdo'
Plugin 'tpope/vim-abolish'
Plugin 'noprompt/vim-yardoc'
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'tpope/vim-dispatch'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'Soares/butane.vim'
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
set textwidth=85
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%87v', 100)

set formatoptions=qrn1

" Set min width of window
set winwidth=84

" Ignore whitespace changes in diff
set diffopt+=iwhite
set diffexpr=""

" Ignore some files
set wildignore+=*.o,*.obj,.git,.svn,public,tmp,app/assets/images

" Enable matchit macros
runtime macros/matchit.vim

" Disable folding for markdown
let g:vim_markdown_folding_disabled=1

" }}}

" Statusline {{{

if exists("*fugitive#statusline")
	set statusline=%<      " Truncate from here if line is too long
	set statusline+=%f     " Path to the file
	set statusline+=%h     " Show help buffer flag is so
	set statusline+=%m     " Show modified flag is so
	set statusline+=%r     " Show readonly flag is so
	set statusline+=\ -\   " separator
  set statusline+=%y     " filetype
  set statusline+=%{fugitive#statusline()}    " Add fugitive niceties
  set statusline+=%=     " move over to the right
  set statusline+=%-14.(%l/%L,%c%) " Start group, line/total lines, column, end group
  set statusline+=\ %P   " Percentage through file
endif

" }}}

" Autocmds {{{
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal g'\"" | endif

" Syntax of these languages is fussy over tabs Vs spaces
autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

au FileType c,cpp,java,javascript setlocal ts=4 sts=4 sw=4 expandtab
"hide all fugitive buffers so we dont have to close them manually
autocmd BufReadPost fugitive://* set bufhidden=delete
autocmd BufNewFile,BufReadPost *.stx set filetype=st
autocmd BufNewFile,BufReadPost *.stx_test set filetype=st
autocmd BufNewFile,BufReadPost *.task set filetype=ruby
autocmd BufNewFile,BufReadPost *.json set filetype=javascript
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost {Gemfile,Rakefile,Vagrantfile,Thorfile,Guardfile,config.ru} set filetype=ruby

augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup end

autocmd bufwritepost .vimrc source $MYVIMRC

" }}}

" Code {{{

" Gary Bernhardt's rename awesomeness
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    call RenameFileWithinVim(old_name, new_name)
  endif
endfunction

" Gary Bernhardt's selecta awesomeness
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

" Gary Bernhardt's rspec awesomeness
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

function! RunTests(filename)
  " Write the file and run tests for the given filename
  :w
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
  if filereadable("/home/m/bin/gbtest")
    exec ":Dispatch ~/bin/gbtest " . a:filename
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

" Delete current buffer file
command! DeleteCurrentFile call delete(expand('%')) | bdelete!

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

function! MarkTodoDone()
  let line = getline(".")
  let line = substitute(line, ' ([0-9 :-]*)$', '', '')
  if line =~ '\[ \]'
    let line = line.' ('.strftime("%F %T").')'
  endif
  let result_code = setline(".", line)
  exec ':VimwikiToggleListItem'
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

" Write to file requiring sudo
cmap w!! %!sudo tee > /dev/null %

" Left right switch tabs
nnoremap <left> :tabprev<cr>
nnoremap <right> :tabnext<cr>
inoremap <left> <ESC>:tabprev<cr>
inoremap <right> <ESC>:tabnext<cr>

" Up down switch buffers
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

nnoremap <Leader>n :call RenameFile()<cr>

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

" Save file and add it to git index
nnoremap ,w :w<cr>:Gwrite<cr>

" Windows changing
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" Window resizing
nnoremap + <C-W>>
nnoremap _ <C-W><

" :edit in file in the same dir as current file shortcuts
cnoremap %% <C-R>=expand('%:h').'/'<cr>

"insert mode tag completion on ctrl ]
inoremap <c-]> <c-x><c-]>

"make ,b call rake
nnoremap <leader>b :w<cr>:!echo;echo;echo;echo;echo;echo;echo;echo;echo;<cr>:!rake<cr>

"remap Q to leader so we dont go to ed mode accidentally
map Q ,

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

nmap <leader>q :FixWhitespace<cr>

noremap <leader>bd :Bclose<cr>      " Close the buffer.
noremap <leader>bl :ls<cr>          " List buffers.
noremap <leader>bn :bn<cr>          " Next buffer.
noremap <leader>bp :bp<cr>          " Previous buffer.
noremap <leader>bt :b#<cr>          " Toggle to most recently used buffer.
noremap <leader>bx :Bclose!<cr>     " Close the buffer & discard changes.
noremap <leader>x  WW:Bclose<cr>


nmap <leader>w/ <Plug>VimwikiUISelect
nmap <leader>ws :call SearchInDefaultWiki()<cr>
vmap <leader>wi <esc>:silent '<,'>:w !to-wiki-inbox -f '%:p'<cr><cr>
nmap <leader>wx :call MarkTodoDone()<cr>

" Source the vimrc file after saving it
nnoremap <leader>r :Copen!<cr>

" }}}

