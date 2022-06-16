"---------------------------------------
" Set options
"---------------------------------------
 "{{{
set encoding=utf-8
scriptencoding utf-8

" language settings
language messages en
set helplang=ja,en

syntax enable
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set backspace=indent,eol,start
set whichwrap=b,s,h,l,<,>,[,],~
set virtualedit=block
set nowrap
set foldmethod=marker
set shortmess-=S
" set visualbell

set ignorecase
set smartcase
set hlsearch
set incsearch

set number
" set ruler " use lightline instead
set scrolloff=1
set cursorline
set cursorlineopt=number
" set ambiwidth=single

set laststatus=2
" set cmdheight=1
set wildmenu
set noshowmode

" tried, didn't work
" augroup ag_tc_cursor | au!
"   autocmd WinEnter,InsertLeave,CmdlineLeave * let &t_SI = "\e[2 q"
"   autocmd InsertEnter,CmdlineEnter * let &t_EI = "\e[6 q"
" augroup end
" autocmd WinEnter,InsertLeave,CmdlineLeave * set t_SI='[2'
" autocmd InsertEnter,CmdlineEnter * set t_EI='[2'
 "}}}

"---------------------------------------
" Mapping
"---------------------------------------
" let g:mapleader = ',' "{{{
" Reload vimrc: https://vim-jp.org/vim-users-jp/2009/09/18/Hack-74.html
nnoremap <silent> <Space>rr <Cmd>source $MYVIMRC<CR><Cmd>nohlsearch<CR>

" For more scrolling on K,J "{{{
nnoremap gk H
nnoremap gj L
nnoremap gm M
" nnoremap M m
" nnoremap m <Nop>
nnoremap M `
" Open help from under cursor word
noremap H K
" line Join => Line join
noremap L J
nnoremap K <C-u>
nnoremap J <C-d>
 "}}}

" from Helix "{{{
noremap gh ^
noremap gl $
nnoremap g. `.
nnoremap U <C-r>
nnoremap <Space>w <C-w>
noremap <Space>y "*y
noremap <Space>p "*p
" https://vim-jp.org/vim-users-jp/2009/08/15/Hack-57.html
nnoremap ]<Space> :<C-u>call append(expand('.'), '')<CR>
 "}}}

nnoremap <Space> <Nop>
nnoremap <Space><CR> <Cmd>call append(expand('.'), '')<CR>
nnoremap <Space>s <C-v>
nnoremap <Space>ac <Cmd>%y *<CR>
nnoremap + <C-a>
nnoremap - <C-x>
noremap Y y$
" for operator-replace
nnoremap <C-r> R
" nnoremap R <Nop>
" That is hard to type but can use `dh` or `hx` instead, so
nnoremap X "_x

" nohlsearch for now matching
nnoremap <Esc><Esc> <Cmd>nohlsearch<CR>
" highlighting again: `:h v:hlsearch`
nnoremap <Space>/ <Cmd>let &hlsearch = &hlsearch<CR>
" for sandwich
noremap s <Nop>
noremap S s
" s-prefixed "{{{
" nnoremap sj <C-e>
" nnoremap sk <C-y>

" tags jumping (tags-and-searches)
nnoremap s<Space> <C-]>
nnoremap s<CR> <C-]>
nnoremap sl <Cmd>tag<CR>
nnoremap sh <Cmd>pop<CR>

" Screen Up/Down
" ref: https://zenn.dev/mattn/articles/83c2d4c7645faa
nmap sj <C-e><SID>s
nmap sk <C-y><SID>s
nnoremap <script> <SID>sj <C-e><SID>s
nnoremap <script> <SID>sk <C-y><SID>s
" nmap <SID>s <Nop>
 "}}}

nmap <Space>j <C-e>j<SID><Space>
nmap <Space>k <C-y>k<SID><Space>
nnoremap <script> <SID><Space>j <C-e>j<SID><Space>
nnoremap <script> <SID><Space>k <C-y>k<SID><Space>

" Move line: https://vim.fandom.com/wiki/Moving_lines_up_or_down
" (t9md/vim-textmanip is better, maybe)
nnoremap <C-j> <Cmd>move .+1<CR>
nnoremap <C-k> <Cmd>move .-2<CR>
vnoremap <C-j> :move '>+1<CR>gv
vnoremap <C-k> :move '<-2<CR>gv
" avoid accidental
vnoremap J <Nop>

" old, this approach dirtied unnamed register, see `:h quote_quote` "{{{
" https://qiita.com/itmammoth/items/312246b4b7688875d023
" nnoremap <C-k> "zdd<Up>"zP
" nnoremap <C-j> "zdd"zp "}}}

" Escaping (not much used)
nnoremap <Up> gk
nnoremap <Down> gj

" Todo: 折り畳みについていつか詳しく調べる
" ごまかしマッピング:
noremap ss m`A "{{{<Esc>g``
noremap se m`A "}}}<Esc>g``

" 調べたもののよくわからなかったけど、使えそうなので一応入れとく
" https://leafcage.hateblo.jp/entry/2013/04/24/053113
nnoremap z[ <Cmd>call <SID>put_foldmarker(0)<CR>
nnoremap z] <Cmd>call <SID>put_foldmarker(1)<CR>
function! s:put_foldmarker(foldclose_p) "{{{
  let crrstr = getline('.')
  let padding = crrstr=='' ? '' : crrstr=~'\s$' ? '' : ' '
  let [cms_start, cms_end] = ['', '']
  let outside_a_comment_p = synIDattr(synID(line('.'), col('$')-1, 1), 'name') !~? 'comment'
  if outside_a_comment_p
    let cms_start = matchstr(&cms,'\V\s\*\zs\.\+\ze%s')
    let cms_end = matchstr(&cms,'\V%s\zs\.\+')
  endif
  let fmr = split(&fmr, ',')[a:foldclose_p]. (v:count ? v:count : '')
  exe 'norm! A'. padding. cms_start. fmr. cms_end
endfunction
"}}}

" （noremapとnnoremapは今のところ雰囲気でやってるが自信はない、いちいちvnoremapとかするのめんどくてnoremap多用しちゃってる...）
" :help map-table
 "}}}

"---------------------------------------
" Plugins
"---------------------------------------
call jetpack#begin() "{{{
Jetpack 'vim-jp/vimdoc-ja'
Jetpack 'sainnhe/everforest'
Jetpack 'tyru/caw.vim'
Jetpack 'machakann/vim-sandwich'
Jetpack 'simeji/winresizer'
Jetpack 'cohama/lexima.vim'
Jetpack 'itchyny/lightline.vim'
Jetpack 'rhysd/clever-f.vim'
Jetpack 'tyru/open-browser.vim'
Jetpack 'obcat/vim-highlightedput'
Jetpack 'machakann/vim-highlightedyank'
Jetpack 'kana/vim-operator-user'
Jetpack 'kana/vim-operator-replace'
Jetpack 'kana/vim-textobj-user'
Jetpack 'romainl/vim-cool'
Jetpack 'ntpeters/vim-better-whitespace'
Jetpack 'haya14busa/vim-asterisk'
call jetpack#end()
 "}}}

"---------------------------------------
" Plugin settings
"---------------------------------------
" caw.vim "{{{
map gcc <Plug>(caw:hatpos:toggle)
map <C-c> <Plug>(caw:hatpos:toggle)
map <Space>, <Plug>(caw:hatpos:toggle)

" winresizer
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1
let g:winresizer_start_key = '<Space>e'

" sandwich "{{{
" :help operator-sandwich
" call operator#sandwich#set('delete', 'all', 'hi_duration', 100)

" recipe initialize
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
" To insert single quote by `si`
let g:sandwich#recipes += [{'buns': ['''', ''''], 'input': ['si'],  'quoteescape': 1}]
" markdown link
let g:sandwich#recipes += [{'buns': ['[', ']()'], 'input': ['md'],  'quoteescape': 1}]

" 日本語文章用（どのぐらい使うのかわからないけど一応）
let g:sandwich#recipes += [{'buns': ['（', '）'], 'input': ['mr']}] " fullwidth maru
let g:sandwich#recipes += [{'buns': ['「', '」'], 'input': ['kg']}] " kagi
let g:sandwich#recipes += [{'buns': ['『', '』'], 'input': ['nkg']}] " nijuu kagi
let g:sandwich#recipes += [{'buns': ['【', '】'], 'input': ['sm']}] " sumi
 "}}}

" lightline
" let g:lightline = {'colorscheme': 'everforest'}
let g:lightline = {
  \ 'colorscheme': 'everforest',
  \ 'separator': {'left': "\ue0b8", 'right': "\ue0be"},
  \ 'subseparator': {'left': "\ue0b9", 'right': "\ue0bf"}
  \ }

" lexima "{{{
" `\%#` is cursor place holder, see `:h lexima-rules-at`
call lexima#add_rule({'char': '<', 'input_after': '>'})
call lexima#add_rule({'char': '>', 'at': '\%#>', 'leave': 1})
call lexima#add_rule({'char': '<BS>', 'at': '<\%#>', 'delete': 1})
" single quote is still not easy to type for me (in JIS keyboard), so just in case mapping
call lexima#add_rule({'char': ',', 'at': ',\%#', 'input': '<BS>''', 'input_after': ''''})
" Note: `'leave': 1` doesn't work as expected, so ignored `:h lexima-repeatable-rule`
call lexima#add_rule({'char': ',', 'at': ',\%#''', 'input': '<BS><Right>'})
" markdown link by 'mdl'
call lexima#add_rule({'char': 'l', 'at': 'md\%#', 'input': '<BS><BS>[', 'input_after': ']()', 'filetype': 'markdown'})

" Full width
call lexima#add_rule({'char': '（', 'input_after': '）'})
call lexima#add_rule({'char': '）', 'at': '\%#）', 'leave': 1})
call lexima#add_rule({'char': '<BS>', 'at': '（\%#）', 'delete': 1})
call lexima#add_rule({'char': '「', 'input_after': '」'})
call lexima#add_rule({'char': '」', 'at': '\%#」', 'leave': 1})
call lexima#add_rule({'char': '<BS>', 'at': '「\%#」', 'delete': 1})

" experimental (problem: if use first line, can't put `<<>>` easily so have to use dot-repeat)
" call lexima#add_rule({'char': '<', 'at': '<\%#', 'input': '<BS><', 'input_after': '>'})
" call lexima#add_rule({'char': '>', 'at': '<\%#', 'input': '<BS><', 'input_after': '>'})
 "}}}

" clever-f
let g:clever_f_across_no_line = 1
let g:clever_f_ignore_case = 1
let g:clever_f_smart_case = 1
let g:clever_f_use_migemo = 1
let g:clever_f_chars_match_any_signs = ';'
let g:clever_f_timeout_ms = 2000
let g:clever_f_highlight_timeout_ms = 750 " if setted above, mustly

" open-browser
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
let g:openbrowser_default_search = 'duckduckgo'
" In official, the option name is `-private-window` but Windows-style option is
" too strange, so I don't want to be surprised by that (and `--` is looks work, that is maybe intentional)
if has('win32')
  let g:openbrowser_browser_commands = [
    \ {'name': 'C:\Program Files\Mozilla Firefox\firefox.exe',
    \  'args': ['{browser}', '--private-window', '{uri}']}
    \ ]
endif
let g:openbrowser_search_engines = {
  \ 'ghrepo': 'https://github.com/{query}'
  \ }
" open github repo (user/name)
nmap sp yir:<C-u>OpenBrowser https://github.com/<C-r>"<CR>

" highlighted put
nmap p <Plug>(highlightedput-p)
xmap p <Plug>(highlightedput-p)
nmap P <Plug>(highlightedput-P)
xmap P <Plug>(highlightedput-P)
let g:highlightedput_highlight_duration = 215

" highlighted yank
let g:highlightedyank_highlight_duration = 215
" let g:highlightedyank_highlight_in_visual = 0

" operator-replace
map R <Plug>(operator-replace)

" textobj-user
" https://github.com/kana/vim-textobj-user#complex-text-objects-defined-by-functions "{{{
call textobj#user#plugin('line', {
\   '-': {
\     'select-a-function': 'CurrentLineA',
\     'select-a': 'al',
\     'select-i-function': 'CurrentLineI',
\     'select-i': 'il',
\   },
\ })

function! CurrentLineA()
  normal! 0
  let head_pos = getpos('.')
  normal! $
  let tail_pos = getpos('.')
  return ['v', head_pos, tail_pos]
endfunction

function! CurrentLineI()
  normal! ^
  let head_pos = getpos('.')
  normal! g_
  let tail_pos = getpos('.')
  let non_blank_char_exists_p = getline('.')[head_pos[2] - 1] !~# '\s'
  return
  \ non_blank_char_exists_p
  \ ? ['v', head_pos, tail_pos]
  \ : 0
endfunction "}}}
" makeshift
call textobj#user#plugin('repositoriename', {
  \ 'repo': {
  \   'pattern': '[0-9a-zA-Z-_\.]\+\/[0-9a-zA-Z-_\.]\+',
  \   'select': ['ar', 'ir'],
  \   },
  \ })

" vim-asterisk
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1
 "}}}

"---------------------------------------
" Colorscheme
"---------------------------------------
" Copy-pasted from `:h everforest-usage` "{{{
if has('termguicolors')
  set termguicolors
endif
set termguicolors
set background=dark
let g:everforest_background = 'hard'

colorscheme everforest
 "}}}

"---------------------------------------
" Misc
"---------------------------------------
" Some FAQ for me "{{{
" Q. How do I jump to latest/older changed position?
" A. Can use `g;` and `g,`
" Q. When will update jumplist? (I care that when use ctrl-o)
" A. `:h jump-motions`
" Q. How to learn about helpfile syntax?
" A. `:h help-writing`
" Q. I want to move between folds
" A. Use `zj` and `zk`, can use that for moving to next/preview fold.
"  for close all fold, use `zM`. See also `[z` and `]z`
 "}}}

" Todo "{{{
" - migrate to kana/vim-textobj-line
" - install lsp plugins
" - learn about filetype options
 "}}}

" Scouter: https://vim-jp.org/vim-users-jp/2009/07/10/Hack-39.html "{{{
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
\        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
command! -bar -bang -nargs=? -complete=file GScouter
\        echo Scouter(empty(<q-args>) ? $MYGVIMRC : expand(<q-args>), <bang>0)
 "}}}
