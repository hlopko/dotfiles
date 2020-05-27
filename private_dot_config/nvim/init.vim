call plug#begin('~/.config/nvim/bundle')
Plug 'tpope/vim-sensible'
Plug 'benekastah/neomake'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'SirVer/ultisnips'
Plug 'Soares/butane.vim'
Plug 'vimwiki/vimwiki'
Plug 'peeja/vim-cdo'
Plug 'vim-scripts/restore_view.vim'
Plug 'bronson/vim-visual-star-search'
Plug 'jremmen/vim-ripgrep'
Plug 'AndrewRadev/splitjoin.vim', { 'for': ['ruby', 'eruby', 'coffees'] }
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'radenling/vim-dispatch-neovim'
Plug 'dense-analysis/ale'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'mhinz/vim-signify'
Plug 'rhysd/vim-clang-format'
Plug 'kana/vim-operator-user'


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
colorscheme gruvbox
set termguicolors

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

augroup bzl_tpl
  au!
  autocmd BufNewFile,BufRead *.bzl.tpl set ft=bzl
augroup end

augroup filetype_swift
  au!
  au FileType swift set textwidth=0
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

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
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



"""""""""""""""""""""""""""""" COC

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" if has('patch8.1.1068')
"   " Use `complete_info` if your (Neo)Vim version supports it.
"   inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
" else
"   imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
" nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
" xmap if <Plug>(coc-funcobj-i)
" xmap af <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-i)
" omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
" nmap <silent> <TAB> <Plug>(coc-range-select)
" xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

vnoremap <leader>z :<C-u>call VisualStarSearchSet('/')<CR>:%s/<C-R>=@/<CR>/

"Now :SignifyBaseline HEAD^ shows you change markers for the thing you've already committed
let g:signify_vcs_cmds = {'git':'git diff --no-color --no-ext-diff -U0 $SY_GIT_BASELINE -- %f'}
let g:signify_vcs_cmds_diffmode = { 'git':'git show ${SY_GIT_BASELINE-HEAD}:./%f' }
command! -nargs=1 SignifyBaseline call setenv("SY_GIT_BASELINE", <q-args>) | SignifyRefresh

let g:clang_format#detect_style_file = 1
autocmd FileType c,cpp,objc map <buffer> = <Plug>(operator-clang-format)
autocmd FileType swift map <buffer> = :!swift-format % --in-place<cr><cr>

" copy to attached terminal using the yank(1) script:
" https://github.com/sunaku/home/blob/master/bin/yank
function! Yank(text) abort
  let escape = system('yank', a:text)
  if v:shell_error
    echoerr escape
  else
    call writefile([escape], '/dev/tty', 'b')
  endif
endfunction
noremap <silent> <Leader>y y:<C-U>call Yank(@0)<CR>

" automatically run yank(1) whenever yanking in Vim
" (this snippet was contributed by Larry Sanderson)
function! CopyYank() abort
  call Yank(join(v:event.regcontents, "\n"))
endfunction
autocmd TextYankPost * call CopyYank()
