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
set hidden

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
set matchpairs+=（:）,「:」,『:』,【:】

set laststatus=2
" set cmdheight=1
set wildmenu
set wildoptions+=pum
set pumheight=15
set noshowmode

augroup FileTypeSettings
  autocmd!
  autocmd FileType markdown setlocal noexpandtab
  autocmd FileType markdown setlocal foldmethod=marker foldmarker=<details>,</details>
  autocmd FileType gitcommit setlocal spell
augroup END

" Startup time
if has('vim_starting') && has('reltime')
  let g:startuptime = reltime()
  augroup vimrc-startuptime
    autocmd! VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
    \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
  augroup END
endif

" if not installed jetpack, install jetpack (ref: https://github.com/tani/vim-jetpack#install-vim-jetpack-if-it-is-unavailable)
let s:jetpackfile = expand(has('win32') ? '~/vimfiles' : '~/.vim') .. '/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif
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
nnoremap ]<Space> <Cmd>call append(expand('.'), '')<CR>
nnoremap [<Space> <Cmd>call append((line('.') - 1), '')<CR>
 "}}}

nnoremap <Space> <Nop>
" https://vim-jp.org/vim-users-jp/2009/08/15/Hack-57.html
nnoremap <Space><CR> <Cmd>call append(expand('.'), '')<CR>
nnoremap <Space>s <C-v>
nnoremap <Space>ac <Cmd>%y *<CR>
nnoremap <Space>as GVgg
noremap + <C-a>
noremap - <C-x>
noremap Y y$
noremap <Space>Y "*y$
nmap yp yyp
nnoremap <Space>l <Cmd>bnext<CR>
nnoremap <Space>h <Cmd>bprevious<CR>
nmap <Space>0 "0p
noremap sc ~
nnoremap @; @:
nnoremap srl r<C-k>
nnoremap srr r<C-k>
" inoremap <C-j> <C-x>
noremap s; :<C-u>q
noremap sw :<C-u>w
" Say thanks to clever-f :-)
nnoremap ; :
" for operator-replace
nnoremap <C-r> R
" nnoremap R <Nop>
" That is hard to type but can use `dh` or `hx` instead, so
nnoremap X "_x

vnoremap g+ g<C-a>
vnoremap g- g<C-x>

noremap ( [(
noremap ) ])

" cnoremap <C-p> <Up>
" cnoremap <C-n> <Down>
" cnoremap <Up> <C-p>
" cnoremap <Down> <C-n>

cnoremap <expr> / getcmdtype() ==# '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() ==# '?' ? '\?' : '?'

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
nnoremap <M-j> <Cmd>move .+1<CR>
nnoremap <M-k> <Cmd>move .-2<CR>
vnoremap <M-j> :move '>+1<CR>gv
vnoremap <M-k> :move '<-2<CR>gv
" avoid accidental
vnoremap J <Nop>
vnoremap K <Nop>

" Escaping
nnoremap <Up> gk
nnoremap <Down> gj

" not a good approach, see these help: `c_<Tab>`, `c_<S-Tab>`, `wc`
" (when search tab character, use '\t')
" cmap <expr> <Tab> getcmdtype() ==# '/' ? '<C-g>' : '<Tab>'
" cmap <expr> <S-Tab> getcmdtype() ==# '/' ? '<C-t>' : '<S-Tab>'
set wildcharm=<C-z>
cnoremap <expr> <Tab> getcmdtype() ==# '/' ? '<C-g>' : '<C-z>'
cnoremap <expr> <S-Tab> getcmdtype() ==# '/' ? '<C-t>' : '<C-z><C-p><C-p>'

noremap ssi m`A "{{{<Esc>g``
noremap sse m`A "}}}<Esc>g``

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

" macros (:h expr-quote)
let @j = "oJetpack '\<Esc>"
let @w = '/ \+$'       " trailing space hunt
let @k = "sa<saab`l~"  " when selected c-w, replace to `<C-w>`
let @r = ":\<C-u>call getline('.') ->matchstr('[0-9a-zA-Z-_\\.]\\+\\/[0-9a-zA-Z-_\\.]\\+') ->substitute('^', 'https://github.com/', '') ->setline('.')\<Esc>"
let @u = "VgU"         " to upper case this line
let @p = ":\<C-u>silent '<,'>s/-\\([-:]\\)|/\\1 |/ge | silent '<,'>s/|\\([-:]\\)-/| \\1/ge\<CR>"  " in markdown table, insert space between dash and pipe

" Commands
command! Vimrc edit $MYVIMRC
command! -nargs=1 -complete=option Toggle call s:toggle_option('<args>')
" toggle options by `:Toggle` "{{{
command! Wrap      Toggle wrap
command! Number    Toggle number
command! ExpandTab Toggle expandtab
command! Spell     Toggle spell
" for testing
command! Hoge Toggle hoge
 "}}}

function! s:toggle_option(optname)
  if exists('&' .. a:optname)
    execute 'setlocal' a:optname .. '!'
    let optstat = eval('&' .. a:optname) ? a:optname : 'no' .. a:optname
    echo "Now:" optstat
  else
    echohl WarningMsg | echo "Error: This option doesn't exist" | echohl None
  endif
endfunction

command! -range -nargs=* MdTable execute executable('mdtable') ? '<line1>,<line2>!mdtable <args>' : 'echohl WarningMsg | echo "Error: ''mdtable'' command is not found" | echohl None'
command! -range          UnMdTable silent <line1>,<line2>s/^| *//ge | silent <line1>,<line2>s/ *|$//ge | silent <line1>,<line2>s/ *| */,/ge | silent <line1>,<line2>s/[-,:]\+\n//ge
" change markdown table direction
command! -range MdTableLeft   silent <line1>,<line2>s/|\( \)\?-/|\1:/ge | silent <line1>,<line2>s/:\( \)\?|/-\1|/ge
command! -range MdTableRight  silent <line1>,<line2>s/-\( \)\?|/:\1|/ge | silent <line1>,<line2>s/|\( \)\?:/|\1-/ge
command! -range MdTableCenter silent <line1>,<line2>s/|\( \)\?-/|\1:/ge | silent <line1>,<line2>s/-\( \)\?|/:\1|/ge

" via https://gist.github.com/tyru/845984 and https://hauleth.dev/post/writing-vim-plugin/
command! -nargs=+ -complete=command Capture call s:cmd_newwin(<q-mods>, <q-args>)
function! s:cmd_newwin(mods, cmd)
  let num = &l:number | setlocal nonumber
  let output = split(execute(a:cmd), '\n')
  let &l:number = num
  execute a:mods . ' new'
  setlocal nobuflisted noswapfile buftype=nofile bufhidden=delete
  call setline(1, output)
endfunction

" :help map-table
 "}}}

"---------------------------------------
" Plugins
"---------------------------------------
packadd vim-jetpack "{{{
call jetpack#begin()
Jetpack 'tani/vim-jetpack', { 'opt': 1 }
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
Jetpack 'kana/vim-textobj-line'
Jetpack 'romainl/vim-cool'
Jetpack 'ntpeters/vim-better-whitespace'
Jetpack 'haya14busa/vim-asterisk'
Jetpack 'vim-denops/denops.vim'
Jetpack 'gamoutatsumi/dps-ghosttext.vim'
" Jetpack 'unblevable/quick-scope'
Jetpack 'ctrlpvim/ctrlp.vim'
Jetpack 'haya14busa/vim-edgemotion'
Jetpack 'mattn/vim-treesitter'
Jetpack 'mattn/ctrlp-matchfuzzy'
Jetpack 'markonm/traces.vim'
Jetpack 'tani/glance-vim'
Jetpack 'aiya000/vim-fmap'
Jetpack 'Shougo/vimproc.vim'
Jetpack 'osyo-manga/vim-vigemo'
Jetpack 'kana/vim-smartword'
Jetpack 'kana/vim-textobj-indent'
Jetpack 'machakann/vim-swap'
Jetpack 'machakann/vim-textobj-delimited'
Jetpack 'zef/vim-cycle'
Jetpack 'vim-skk/skkeleton'
Jetpack 'arthurxavierx/vim-caser'
Jetpack 'lambdalisue/reword.vim'
Jetpack 'kg8m/vim-simple-align'
call jetpack#end()
 "}}}

"---------------------------------------
" Plugin settings
"---------------------------------------
" caw.vim "{{{
map gc <Plug>(caw:prefix)
" nmap <C-c> <Plug>(caw:hatpos:toggle)
map <Space>, <Plug>(caw:hatpos:toggle)
map ,<Space> <Plug>(caw:hatpos:toggle)

" winresizer
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1
let g:winresizer_start_key = '<Space>e'

" sandwich "{{{
" :help operator-sandwich
call operator#sandwich#set('delete', 'all', 'hi_duration', 175)

" recipe initialize
let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
" To insert single quote by `si`
let g:sandwich#recipes += [{'buns': ['''', ''''], 'input': ['si'], 'quoteescape': 1}]
" markdown link
let g:sandwich#recipes += [{'buns': ['[', ']()'], 'input': ['mdl'], 'quoteescape': 1}]
let g:sandwich#recipes += [{'buns': ['[', ']()'], 'input': ['mdp'], 'quoteescape': 1, 'command': ['normal! "*P']}]

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
" When writing specific language, disable that rule
call lexima#add_rule({'char': '<', 'filetype': 'haskell'})
" Easier leaving at `<C-w|>` after `<C-w>`| by `
call lexima#add_rule({'char': '`', 'at': '\%#>`', 'leave': 2})

" single quote is still not easy to type for me (in JIS keyboard), so just in case mapping
call lexima#add_rule({'char': ',', 'at': ',\%#', 'input': '<BS>''', 'input_after': ''''})
" Note: `'leave': 1` doesn't work as expected, see `:h lexima-rules-leave`
call lexima#add_rule({'char': ',', 'at': ',\%#''', 'input': '<BS><C-g>U<Right>'})
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
let g:clever_f_fix_key_direction = 1
let g:clever_f_mark_direct = 1

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
" open github repo (user/name)
nmap gz <Cmd>call <SID>open_repo()<CR>
nmap ,gz <Cmd>call <SID>open_quoted_repo()<CR>
function! s:open_repo()
  let url = matchstr(expand('<cWORD>'), '[0-9a-zA-Z-_\.]\+\/[0-9a-zA-Z-_\.]\+')
  if url !=# ''
    execute 'OpenBrowser https://github.com/' . url
  endif
endfunction

function! s:open_quoted_repo()
  let reg = @z
  normal! "zyi'
  execute 'OpenBrowser https://github.com/' . @z
  let @z = reg
endfunction

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
" makeshift
" call textobj#user#plugin('repositoriename', {
"  \ 'repo': {
"  \   'pattern': '[0-9a-zA-Z-_\.]\+\/[0-9a-zA-Z-_\.]\+',
"  \   'select': ['ar', 'ir'],
"  \   },
"  \ })

" vim-asterisk
map *  <Plug>(asterisk-z*)
map #  <Plug>(asterisk-z#)
map g* <Plug>(asterisk-gz*)
map g# <Plug>(asterisk-gz#)
let g:asterisk#keeppos = 1

" ctrlp
let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
map <Space>f <Plug>(ctrlp)

" vim-edgemotion
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

" glance-vim
let g:glance#markdown_html = v:true
let g:glance#server_port = 1111
command! Prev call s:prev_in_browser()

function! s:prev_in_browser()
  Glance
  OpenBrowser localhost:1111
endfunction

" vim-fmap {{{
let g:fmap_use_default_keymappings = v:false
let g:fmap_use_default_mappings = v:false
nmap sf <Plug>(fmap-forward-f)
nmap sF <Plug>(fmap-backward-f)
nmap st <Plug>(fmap-forward-t)
nmap sT <Plug>(fmap-backward-t)

vmap sf <Plug>(fmap-forward-f)
vmap sF <Plug>(fmap-backward-f)
vmap st <Plug>(fmap-forward-t)
vmap sT <Plug>(fmap-backward-t)

omap sf <Plug>(fmap-forward-f)
omap sF <Plug>(fmap-backward-f)
omap st <Plug>(fmap-forward-t)
omap sT <Plug>(fmap-backward-t)
augroup VimFmap "{{{
  autocmd!
  autocmd VimEnter * FNoreMap /   ・
  autocmd VimEnter * FNoreMap ;ten ・
  autocmd VimEnter * FNoreMap tj  \|
  autocmd VimEnter * FNoreMap sq  ''
  autocmd VimEnter * FNoreMap dq  \"
  autocmd VimEnter * FNoreMap ,   、
  autocmd VimEnter * FNoreMap .   。
  autocmd VimEnter * FNoreMap !   ！
  autocmd VimEnter * FNoreMap ?   ？
  autocmd VimEnter * FNoreMap mr  （
  autocmd VimEnter * FNoreMap fmr ）
  autocmd VimEnter * FNoreMap kg  「
  autocmd VimEnter * FNoreMap fkg 」
  autocmd VimEnter * FNoreMap nkg 『
  autocmd VimEnter * FNoreMap fnkg 』
  autocmd VimEnter * FNoreMap sm  【
  autocmd VimEnter * FNoreMap fsm 】
  autocmd VimEnter * FNoreMap a   あ
  autocmd VimEnter * FNoreMap i   い
  autocmd VimEnter * FNoreMap u   う
  autocmd VimEnter * FNoreMap e   え
  autocmd VimEnter * FNoreMap o   お
  autocmd VimEnter * FNoreMap ka  か
  autocmd VimEnter * FNoreMap ki  き
  autocmd VimEnter * FNoreMap ku  く
  autocmd VimEnter * FNoreMap ke  け
  autocmd VimEnter * FNoreMap ko  こ
  autocmd VimEnter * FNoreMap sa  さ
  autocmd VimEnter * FNoreMap si  し
  autocmd VimEnter * FNoreMap shi し
  autocmd VimEnter * FNoreMap su  す
  autocmd VimEnter * FNoreMap se  せ
  autocmd VimEnter * FNoreMap so  そ
  autocmd VimEnter * FNoreMap ta  た
  autocmd VimEnter * FNoreMap ti  ち
  autocmd VimEnter * FNoreMap tu  つ
  autocmd VimEnter * FNoreMap te  て
  autocmd VimEnter * FNoreMap to  と
  autocmd VimEnter * FNoreMap na  な
  autocmd VimEnter * FNoreMap ni  に
  autocmd VimEnter * FNoreMap nu  ぬ
  autocmd VimEnter * FNoreMap ne  ね
  autocmd VimEnter * FNoreMap no  の
  autocmd VimEnter * FNoreMap ha  は
  autocmd VimEnter * FNoreMap hi  ひ
  autocmd VimEnter * FNoreMap hu  ふ
  autocmd VimEnter * FNoreMap he  へ
  autocmd VimEnter * FNoreMap ho  ほ
  autocmd VimEnter * FNoreMap ma  ま
  autocmd VimEnter * FNoreMap mi  み
  autocmd VimEnter * FNoreMap mu  む
  autocmd VimEnter * FNoreMap me  め
  autocmd VimEnter * FNoreMap mo  も
  autocmd VimEnter * FNoreMap ya  や
  autocmd VimEnter * FNoreMap yu  ゆ
  autocmd VimEnter * FNoreMap yo  よ
  autocmd VimEnter * FNoreMap ra  ら
  autocmd VimEnter * FNoreMap ri  り
  autocmd VimEnter * FNoreMap ru  る
  autocmd VimEnter * FNoreMap re  れ
  autocmd VimEnter * FNoreMap ro  ろ
  autocmd VimEnter * FNoreMap wa  わ
  autocmd VimEnter * FNoreMap wo  を
  autocmd VimEnter * FNoreMap nn  ん
  autocmd VimEnter * FNoreMap ga  が
  autocmd VimEnter * FNoreMap gi  ぎ
  autocmd VimEnter * FNoreMap gu  ぐ
  autocmd VimEnter * FNoreMap ge  げ
  autocmd VimEnter * FNoreMap go  ご
  autocmd VimEnter * FNoreMap za  ざ
  autocmd VimEnter * FNoreMap zi  じ
  autocmd VimEnter * FNoreMap ji  じ
  autocmd VimEnter * FNoreMap zu  ず
  autocmd VimEnter * FNoreMap ze  ぜ
  autocmd VimEnter * FNoreMap zo  ぞ
  autocmd VimEnter * FNoreMap da  だ
  autocmd VimEnter * FNoreMap di  ぢ
  autocmd VimEnter * FNoreMap du  づ
  autocmd VimEnter * FNoreMap de  で
  autocmd VimEnter * FNoreMap do  ど
  autocmd VimEnter * FNoreMap ba  ば
  autocmd VimEnter * FNoreMap bi  び
  autocmd VimEnter * FNoreMap bu  ぶ
  autocmd VimEnter * FNoreMap be  べ
  autocmd VimEnter * FNoreMap bo  ぼ
  autocmd VimEnter * FNoreMap lu  ぅ
  autocmd VimEnter * FNoreMap la  ぁ
  autocmd VimEnter * FNoreMap ltu っ
  autocmd VimEnter * FNoreMap lya ゃ
  autocmd VimEnter * FNoreMap lyu ゅ
  autocmd VimEnter * FNoreMap lyo ょ
  autocmd VimEnter * FNoreMap ja  じゃ
  autocmd VimEnter * FNoreMap ju  じゅ
augroup END "}}}
" fmap_mappings "{{{
" let g:fmap_mappings = {
"  \ 'ten': '・',
"  \ ',':   '、',
"  \ '.':   '。',
"  \ '!':   '！',
"  \ '?':   '？',
"  \ }
"}}}
" @a=I\ lsaiw'f'a:$saiw'A,j
" らりるれろろろ、やゆよ。
"}}}

" migemo
nmap <Space>mi <Plug>(vigemo-search)

" smartword
nmap w <Plug>(smartword-w)
nmap b <Plug>(smartword-b)
nmap e <Plug>(smartword-e)
nmap ge <Plug>(smartword-ge)
xmap w <Plug>(smartword-w)
xmap b <Plug>(smartword-b)
xmap e <Plug>(smartword-e)
xmap ge <Plug>(smartword-ge)
noremap ,w w
noremap ,b b
noremap ,e e
noremap ,ge ge

" vim-swap
nmap s< <Plug>(swap-prev)
nmap s> <Plug>(swap-next)
omap i, <Plug>(swap-textobject-i)
xmap i, <Plug>(swap-textobject-i)
omap a, <Plug>(swap-textobject-a)
xmap a, <Plug>(swap-textobject-a)

" vim-cycle
nmap + <Plug>CycleNext
nmap - <Plug>CyclePrevious

" skkeleton
imap <C-j> <Plug>(skkeleton-toggle)
cmap <C-j> <Plug>(skkeleton-toggle)
call skkeleton#config({
  \ 'globalJisyo': '~/.skk/SKK-JISYO.L',
  \ 'keepState': v:true,
  \ 'setUndoPoint': v:false,
  \ 'markerHenkan': ';',
  \ 'markerHenkanSelect': '',
  \ })

" vim-caser
" via readme, and few custom:
" |                Case                 |    Mapping    |
" | ----------------------------------- | ------------- |
" | MixedCase or PascalCase             | ,sm  ,sp  ,sC |
" | camelCase                           | ,sc           |
" | snake_case                          | ,s_  ,ss      |
" | UPPER_CASE                          | ,su  ,sU      |
" | Title Case                          | ,st           |
" | Sentence case                       | ,s<Space>     |
" | dash-case or kebab-case             | ,s-  ,sk      |
" | Title-Dash-Case or Title-Kebab-Case | ,sK           |
" | dot.case                            | ,s.           |
" | tOGGLE cASE                         | ,sT           |
" | normal lower case                   | ,sn           |
" | NORMAL UPPER CASE                   | ,sN           |

" let g:caser_prefix = ',s'
let g:caser_no_mappings = 1
" from defaults {{{
nmap ,sm <Plug>CaserMixedCase
xmap ,sm <Plug>CaserVMixedCase
nmap ,sp <Plug>CaserMixedCase
xmap ,sp <Plug>CaserVMixedCase
nmap ,sc <Plug>CaserCamelCase
xmap ,sc <Plug>CaserVCamelCase
nmap ,s_ <Plug>CaserSnakeCase
xmap ,s_ <Plug>CaserVSnakeCase
nmap ,su <Plug>CaserUpperCase
xmap ,su <Plug>CaserVUpperCase
nmap ,sU <Plug>CaserUpperCase
xmap ,sU <Plug>CaserVUpperCase
nmap ,st <Plug>CaserTitleCase
xmap ,st <Plug>CaserVTitleCase
nmap ,s- <Plug>CaserKebabCase
xmap ,s- <Plug>CaserVKebabCase
nmap ,sk <Plug>CaserKebabCase
xmap ,sk <Plug>CaserVKebabCase
nmap ,sK <Plug>CaserTitleKebabCase
xmap ,sK <Plug>CaserVTitleKebabCase
nmap ,s. <Plug>CaserDotCase
xmap ,s. <Plug>CaserVDotCase
" }}}
nmap ,sC <Plug>CaserMixedCase
xmap ,sC <Plug>CaserVMixedCase
nmap ,ss <Plug>CaserSnakeCase
xmap ,ss <Plug>CaserVSnakeCase
nmap ,s<Space> <Plug>CaserSentenceCase
xmap ,s<Space> <Plug>CaserVSentenceCase
" native commands
noremap ,sT g~
noremap ,sn gu
noremap ,sN gU
 "}}}

"---------------------------------------
" Colorscheme
"---------------------------------------
" Copy-pasted from `:h everforest-usage` "{{{
if has('termguicolors')
  set termguicolors
endif
set background=dark
let g:everforest_background = 'hard'
let g:everforest_disable_italic_comment = 1

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
" Q. Can't input specific symbols like ・, →, ←, etc
" A. Use digraph. Input <C-k> in insert mode, and type `.6`, `->`, `<-`.
"  See `digraph.txt`, and for learning digraph keys, `ga` is usefull
" Q. I want default key-mappings list (with simply description)
" A. See `index.txt`, that is mappings overview
 "}}}

" Todo "{{{
" - install lsp plugins
" - install snippet plugin & configuring them
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
