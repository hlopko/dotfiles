filetype off                   " required for vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-fugitive'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'scrooloose/nerdcommenter'
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
Bundle 'rking/ag.vim'
Bundle 'Peeja/vim-cdo'
Bundle 'tpope/vim-abolish'
Bundle 'noprompt/vim-yardoc'
Bundle 'Soares/butane.vim'


filetype plugin indent on     " required by vundle

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
  au FileType html,css,lisp,ruby,eruby,coffee,vim setlocal ts=2 sts=2 sw=2 expandtab
  au FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
  au FileType c,cpp,java setlocal ts=4 sts=4 sw=4 expandtab

  au BufNew,BufNewFile *.rss setfiletype xml
  au BufNew,BufNewFile *.txt,*.text,*.md,*.markdown set ft=markdown
  au BufNew,BufNewFile *.stx setfiletype st
  au BufNew,BufNewFile *.stx_test setfiletype st
  au BufNew,BufNewFile *.task setfiletype ruby
  au BufNew,BufNewFile *.json setfiletype javascript
  au BufNew,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Guardfile,config.ru} set ft=ruby
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

" netrw tweaks
let g:netrw_liststyle    = 3

"tab will work for bracket matching
"nmap <tab> %
"vmap <tab> %

"write to file requiring sudo
cmap w!! %!sudo tee > /dev/null %

"break long lines
set wrap
set textwidth=79
set formatoptions=qrn1

"set min width of window
set winwidth=90

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

"""""""""""""""""""""""""""""""""""""""""gary bernhardt's rename awesomeness
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    call RenameFileWithinVim(old_name, new_name)
  endif
endfunction
map <Leader>n :call RenameFile()<cr>

"""""""""""""""""""""""""""""""""""""""""gary bernhardt's selecta awesomeness
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
" Find files using ctags
nnoremap <leader>o :call SelectaCommand("cut -d$'\t' -f 1 .git/tags", "", ":tag")<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""end mh's selecta awesomeness
"ignore some files
set wildignore+=*.o,*.obj,.git,.svn,public,tmp,app/assets/images

""""""""""""""""""""""""""""""""""""""""""""""""""""""gary bernhardt's rspec awesomeness
map <leader>t :call RunTestFile()<cr>
map <leader>T :call RunNearestTest()<cr>
"map <leader>a :call RunTests('')<cr>
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

command SSpring !spring stop

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

":edit in file in the same dir as current file shortcuts
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

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

function! AbolishizePatternForGrep(pattern)
  let result = "("
  let result .= g:Abolish.snakecase(a:pattern)
  let result .= "|"
  let result .= g:Abolish.uppercase(a:pattern)
  let result .= "|"
  let result .= g:Abolish.dashcase(a:pattern)
  let result .= "|"
  let result .= g:Abolish.camelcase(a:pattern)
  let result .= "|"
  let result .= g:Abolish.mixedcase(a:pattern)
  let result .= ")"
  return result
endfunction

function! ProjectWideAbolishSubstitute()
	let selection = g:Abolish.snakecase(GetVisual())
	let replacement = g:Abolish.snakecase(input('Replace with: ', selection))
	let search_in_dirs = input('Search destinations: ', 'app spec')
  let files_to_rename = system("find ".search_in_dirs." -name '*".selection."*'")
  for file_to_rename in split(files_to_rename)
    if input("Do you want to rename ".file_to_rename."? ", "y") == "y"
      let destination_file = substitute(file_to_rename, selection, replacement, '')
      call RenameFileWithinVim(file_to_rename, destination_file)
    endif
  endfor
  exec ":Ag '".AbolishizePatternForGrep(selection)."' ".search_in_dirs
  exec ":Cdo S/".selection."/".replacement."/c"
endfunction

function! RenameFileWithinVim(source, dest)
  exec ":e ".a:source
  exec ":saveas ".a:dest
  exec ":silent !rm ".a:source
  exec ":blast"
  redraw!
endfunction

" Start the find and replace command across the entire file
vmap <leader>z <Esc>:%s/<c-r>=GetVisual()<cr>/
vmap <leader>Z <Esc>:call ProjectWideAbolishSubstitute()<cr>
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

nmap <leader>w :FixWhitespace<cr>

noremap <leader>bd :Bclose<cr>      " Close the buffer.
noremap <leader>bl :ls<cr>          " List buffers.
noremap <leader>bn :bn<cr>          " Next buffer.
noremap <leader>bp :bp<cr>          " Previous buffer.
noremap <leader>bt :b#<cr>          " Toggle to most recently used buffer.
noremap <leader>bx :Bclose!<cr>     " Close the buffer & discard changes.
noremap <leader>x  WW:Bclose<cr>
