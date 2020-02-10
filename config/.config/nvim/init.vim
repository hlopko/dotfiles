call plug#begin('~/.config/nvim/bundle')
Plug 'tpope/vim-sensible'
Plug 'benekastah/neomake'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'SirVer/ultisnips'
Plug 'Soares/butane.vim'
Plug 'vimwiki/vimwiki'
Plug 'vim-ruby/vim-ruby'
Plug 'peeja/vim-cdo'
Plug 'vim-scripts/restore_view.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'jremmen/vim-ripgrep'
Plug 'AndrewRadev/splitjoin.vim', { 'for': ['ruby', 'eruby', 'coffees'] }
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'radenling/vim-dispatch-neovim'
Plug 'dense-analysis/ale'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
call plug#end()

set tags=TAGS;tags;
set cscopequickfix=s-,c-,d-,i-,t-,e-
let mapleader = ","
set backupdir=~/.nvim-tmp
set directory=~/.nvim-tmp
set history=10000
set undofile
set undodir=~/.nvim-tmp
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" au BufWinEnter *.cc,*.h,*.py let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
" map <C-I> :pyf clang-format.py<CR>
let c_space_errors = 1
set background=dark
colorscheme solarized
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
if has("multi_byte")
  set listchars=tab:▸\ ,eol:⤦
endif
set encoding=utf-8
set scrolloff=6
set number
set norelativenumber
set nocursorline
set ignorecase
set wrap
set splitbelow
set splitright
set textwidth=80
set winwidth=80
set diffopt+=iwhite
set diffexpr=""
set diffopt+=vertical
set autowrite
let g:c_no_comment_fold = 1
let g:vim_markdown_folding_disabled=1
let g:markdown_fenced_languages = [ 'ruby', 'st', 'c', 'scheme' ]

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

augroup filetype_muttrc
  au!
  au FileType muttrc setlocal foldmethod=marker
augroup end

augroup filetype_java
  au!
  au FileType java set makeprg=javac\ %
  au FileType java set errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
augroup end

augroup filetype_vim
  au!
  au FileType vim setlocal foldmethod=marker
augroup end

augroup filetype_scm
  au!
  au FileType scheme nnoremap <buffer> <leader>t :!./fmsc < %<cr>
augroup end

augroup filetype_cpp
  au!
  au FileType cpp nnoremap <buffer> <leader>t :!g++ -g % && ./a.out < input<cr>
augroup end

augroup filetype_c
  au!
  au FileType c setlocal foldmethod=syntax
  au FileType c setlocal foldnestmax=1
augroup end

augroup filetype_mail
  au!
augroup end

augroup erb_embedded_languages
  au!
  au BufNewFile,BufReadPre *.ajax_html.erb let b:eruby_subtype = 'html'
  " au BufNewFile,BufReadPre *.md.erb let b:eruby_subtype = 'markdown'
augroup end

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

let g:vimwiki_list = [{'path': '~/vimwiki/',
   \ 'syntax': 'markdown',
   \ 'nested_syntaxes': {'ruby': 'ruby', 'bash': 'bash', 'java': 'java', 'c': 'c', 'js': 'javascript', 'html': 'html'},
   \ 'ext': '.md'}]
let g:vimwiki_global_ext = 0

",l to show unprintable characters
nnoremap <leader>l :set list!<CR>

" leader + space will clear search highlights
nnoremap <leader><space> :noh<cr>

" Tab will work for bracket matching nnoremap <tab> %
vnoremap <tab> %

" Windows changing
nnoremap <C-h> <C-W>h
nnoremap <bs> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" Window resizing
nnoremap + <C-W>>
nnoremap _ <C-W><

let c_space_errors = 1

"j k return to their initial column
nnoremap j gj
nnoremap k gk

"don't you hate when you accidentally hit f1?
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"go back to normal mode with kj
inoremap kj <ESC>
inoremap Kj <ESC>
inoremap kJ <ESC>
inoremap KJ <ESC>

"windows changing
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call fzf#run({'source': 'find_files_exclude_boring .', 'sink': 'e'})<cr>

nnoremap <leader>Q :call ToggleQuickfix()<cr>

" :edit in file in the same dir as current file shortcuts
cnoremap %% <C-R>=expand('%:h').'/'<cr>

"insert mode tag completion on ctrl ]
inoremap <c-]> <c-x><c-]>

"make ,b call rake
nnoremap <leader>b :w<cr>:Dispatch rake<cr>

"remap Q to esc so we dont go to ed mode accidentally
noremap Q <ESC>

" Create spec file for current file
nnoremap <silent> ,A :call GetSpec()<cr><cr>

nmap <leader>q :StripWhitespace<cr>

nmap <leader>q :StripWhitespace<cr>

noremap <leader>x  WW:Bclose<cr>

set gdefault

let g:rustfmt_autosave = 1

" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'cpp': ['clangd'],
    \ }

" LanguageClient
let g:LanguageClient_autoStart = 1

nnoremap <leader>a :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> R :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> <leader>r :call LanguageClient#textDocument_rename()<CR>

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" ALE
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'cpp': ['clangtidy'],
\}

let g:ale_linters = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'cpp': ['clangtidy'],
\}

" deoplete
let g:deoplete#enable_at_startup = 1

