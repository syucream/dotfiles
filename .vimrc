" 各種パラメータ {{{
" ------------------------------------------------------------------------------------------------------------------------
"

" シンタックスハイライト
syntax on
set t_Co=256
highlight LineNr ctermfg=darkyellow 
set cursorline

" 行番号を表示
set number
set showmatch
set smartcase

" タブ、インデント関連
set shiftwidth=2
set tabstop=2
set smartindent
set expandtab

" インデント変更時に選択状態を解除しない
vnoremap < <gv
vnoremap > >gv

" 文字コード
set termencoding=utf-8
set fileencodings=utf-8
set fenc=utf-8
set enc=utf-8

" バックスペースで改行削除
set backspace=2

" 検索
set hlsearch
nnoremap <ESC><ESC> :nohlsearch<CR>

" コマンド履歴表示
" q: はtypo しやすいので無効にする。qq: を使うかq/ を使うこと
nnoremap qq: <Esc>q:
noremap q: <Nop>

" color, highlight
colorscheme desert
if exists('&colorcolumn')
    autocmd FileType po set colorcolumn=+1 | setlocal textwidth=80
endif


" Enable using w!! command to write file as super user
cmap w!! w !sudo tee > /dev/null %

" }}} 

"  折りたたみ設定 {{{
" ------------------------------------------------------------------------------------------------------------------------
set foldmethod=marker
set foldlevel=0

" }}}

"  タブ設定 {{{
" ------------------------------------------------------------------------------------------------------------------------

" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=1 " 複数タブを開いたら、タブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>
" tp 前のタブ
map <silent> [Tag]p :tabprevious<CR>

" }}}

" プラグイン関係 {{{
" ------------------------------------------------------------------------------------------------------------------------
"
" dein.vim
" see also: http://qiita.com/delphinus35/items/00ff2c0ba972c6e41542
"
" load (and setup) dein.vim
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" load plugins via dein.vim
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  let s:nvim_toml = g:rc_dir . '/dein_nvim.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  if has('nvim')
    call dein#load_toml(s:nvim_toml, {})
  endif

  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif

filetype plugin indent on     

" ユーザ定義関数 {{{
" ------------------------------------------------------------------------------------------------------------------------
"
set laststatus=2

" カレントバッファのファイルのフルパスを表示する
function! Fullpath()
  echo expand("%:p")
endfunction
:command! Fullpath :call Fullpath()

" .vimrc.local 読み込み
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" }}}
