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
set noshowmode

augroup fileTypeSettings
  autocmd!
  autocmd FileType markdown setlocal noexpandtab
  autocmd FileType markdown setl foldmethod=marker | setl foldmarker=<details>,</details>
augroup END

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
nnoremap gn <Cmd>bnext<CR>
nnoremap gp <Cmd>bprevious<CR>
" https://vim-jp.org/vim-users-jp/2009/08/15/Hack-57.html
nnoremap ]<Space> :<C-u>call append(expand('.'), '')<CR>
 "}}}

nnoremap <Space> <Nop>
nnoremap <Space><CR> <Cmd>call append(expand('.'), '')<CR>
nnoremap <Space>s <C-v>
nnoremap <Space>ac <Cmd>%y *<CR>
nnoremap <Space>as GVgg
noremap + <C-a>
noremap - <C-x>
noremap Y y$
nmap yp yyp
nnoremap <Space>l <Cmd>bnext<CR>
nnoremap <Space>h <Cmd>bprevious<CR>
nmap <Space>0 "0p
nnoremap sr r<C-k>
" for operator-replace
nnoremap <C-r> R
" nnoremap R <Nop>
" That is hard to type but can use `dh` or `hx` instead, so
nnoremap X "_x

vnoremap g+ g<C-a>
vnoremap g- g<C-x>

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

" old, this approach dirtied unnamed register, see `:h quote_quote` "{{{
" https://qiita.com/itmammoth/items/312246b4b7688875d023
" nnoremap <C-k> "zdd<Up>"zP
" nnoremap <C-j> "zdd"zp "}}}

" Escaping
nnoremap <Up> gk
nnoremap <Down> gj
nnoremap <Space>n gn
nnoremap <Space>N gN

" Commands
command! Vimrc edit $MYVIMRC

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
call jetpack#end()
 "}}}

"---------------------------------------
" Plugin settings
"---------------------------------------
" caw.vim "{{{
map gc <Plug>(caw:prefix)
map <C-c> <Plug>(caw:hatpos:toggle)
map <Space>, <Plug>(caw:hatpos:toggle)

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
" When writing specific language, disable that rule
call lexima#add_rule({'char': '<', 'filetype': 'haskell'})

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
let g:openbrowser_search_engines = {
  \ 'ghrepo': 'https://github.com/{query}'
  \ }
" open github repo (user/name)
nmap sgp yir:<C-u>OpenBrowser https://github.com/<C-r>"<CR>

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

" ctrlp
let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}

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
  autocmd VimEnter * FNoreMap ten ・
  autocmd VimEnter * FNoreMap ,   、
  autocmd VimEnter * FNoreMap .   。
  autocmd VimEnter * FNoreMap !   ！
  autocmd VimEnter * FNoreMap ?   ？
  autocmd VimEnter * FNoreMap sq  ''
  autocmd VimEnter * FNoreMap mr  （
  autocmd VimEnter * FNoreMap mre ）
  autocmd VimEnter * FNoreMap kg  「
  autocmd VimEnter * FNoreMap kge 」
  autocmd VimEnter * FNoreMap nkg 『
  autocmd VimEnter * FNoreMap nkge 』
  autocmd VimEnter * FNoreMap sm  【
  autocmd VimEnter * FNoreMap sme 】
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
  autocmd VimEnter * FNoreMap zu  ず
  autocmd VimEnter * FNoreMap ze  ぜ
  autocmd VimEnter * FNoreMap zo  ぞ
  autocmd VimEnter * FNoreMap ji  じ
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
" @a=I\ lsaiwsif'a:$saiwsiA,j
" らりるれろろろ、やゆよ。
"}}}
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
