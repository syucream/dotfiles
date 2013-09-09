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
set encoding=japan
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

" プラグイン全般 {{{
" ------------------------------------------------------------------------------------------------------------------------


"
" neobundle.vim
"
if has('vim_starting')
  set rtp+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc( expand('~/.vim/bundle') )
NeoBundleFetch 'Shougo/neobundle.vim'

" webapi-vim
NeoBundle 'mattn/webapi-vim'

" vimproc
NeoBundle 'Shougo/vimproc', {
\ 'build' : {
\     'windows' : 'make -f make_mingw32.mak',
\     'cygwin' : 'make -f make_cygwin.mak',
\     'mac' : 'make -f make_mac.mak',
\     'unix' : 'make -f make_unix.mak',
\    },
\ }

" vim-fugitive
NeoBundle 'tpope/vim-fugitive'

" rails.vim
NeoBundle 'rails.vim'

" sudo
NeoBundle 'sudo.vim'

" vimshell
NeoBundle 'Shougo/vimshell'

" vimfiler
NeoBundle 'Shougo/vimfiler'
"let g:vimfiler_as_default_explorer = 1

" EasyMotion
" カーソル移動補助
NeoBundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key = "'"

" quickrun
NeoBundle 'thinca/vim-quickrun'

" tcomment
" <c-_><c-_> でコメントトグル
NeoBundle 'tomtom/tcomment_vim'

" neocomplcache
NeoBundle 'Shougo/neocomplcache'
" autocomplpop と競合するのでそちらは無効にする
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
" Necoコマンドは無効化
noremap Neco <Nop>

" command-t
NeoBundle 'git://git.wincent.com/command-t.git'

" indent-guides
NeoBundle 'nathanaelkane/vim-indent-guides'
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_color_change_parcent = 30
"let g:indent_guides_guide_size = 1

" gtags.vim
NeoBundle 'vim-scripts/gtags.vim'

" gist-vim
NeoBundle 'mattn/gist-vim'
"" TODO: ローカル設定を入れる

" previm
" pure vim なmarkdownプレビューア
NeoBundle 'kannokanno/previm'

" open-browser
NeoBundle 'tyru/open-browser.vim'

" yanktmp
NeoBundle 'vim-scripts/yanktmp.vim'
map <silent> sy :call YanktmpYank()<cr>
map <silent> sp :call YanktmpPaste_p()<cr>
map <silent> sP :call YanktmpPaste_P()<cr> 
let g:yanktmp_file = '~/.vim/yanktmp'

" surround.vim
NeoBundle 'tpope/vim-surround'

" zen-coding
NeoBundle 'mattn/zencoding-vim'

" switch.vim
NeoBundle 'AndrewRadev/switch.vim'

" markdown
NeoBundle 'tpope/vim-markdown'

" reST
" NeoBundle 'Rykka/riv.vim'

" syntastic
NeoBundle 'scrooloose/syntastic'

" gitv
NeoBundle 'gregsexton/gitv'
" gitv固有の設定
autocmd FileType gitv call s:my_gitv_settings()
function! s:my_gitv_settings()
  " fd でdiffを表示/非表示切り替え
  nnoremap <silent><buffer> fd :<C-u>windo call <SID>toggle_git_folding()<CR>1<C-w>w
endfunction
autocmd FileType git setlocal nofoldenable foldlevel=0
function! s:toggle_git_folding()
  if &filetype ==# 'git'
    setlocal foldenable!
  endif
endfunction

" CCTree
" Depend on ctags, cscope
" 使用前にプロジェクトのルートディレクトリで $ ctags -R && cscope -b -c -R
" TODO: 何故かftplugin以下に置いておくとロードしてくれない。暫定的に~/.vim/plugin にコピーして使う？
NeoBundle 'vim-scripts/CCTree'

" }}}

" submode {{{
"" ---------------------------------------------------------------------------------------------------------- 
NeoBundle 'kana/vim-submode'
" window-control submode
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>-')
call submode#map('winsize', 'n', '', '-', '<C-w>+')
" tab-control submode
call submode#enter_with('changetab', 'n', '', 'gt', 'gt')
call submode#enter_with('changetab', 'n', '', 'gT', 'gT')
call submode#map('changetab', 'n', '', 't', 'gt')
call submode#map('changetab', 'n', '', 'T', 'gT')

" }}}

" neosnippet {{{
"" ---------------------------------------------------------------------------------------------------------- 
NeoBundle 'Shougo/neosnippet'
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" Enable snipMate compatibility feature.
let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

"" }}}

" カラースキーマ {{{
"" ---------------------------------------------------------------------------------------------------------- 

colorscheme desert

"" }}}

" ステータスライン設定 {{{
" ------------------------------------------------------------------------------------------------------------------------
"
set laststatus=2

" powerline
" スペックによってはロードに時間がかかるかも
"NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim' }

" vim-airline
NeoBundle 'bling/vim-airline'
" powerline symbols
"let g:airline_left_sep = ''
"let g:airline_left_alt_sep = ''
"let g:airline_right_sep = ''
"let g:airline_right_alt_sep = ''
"let g:airline_fugitive_prefix = ' '
"let g:airline_readonly_symbol = ''
"let g:airline_linecolumn_prefix = ' '

" }}}

" for Haskell {{{
" ------------------------------------------------------------------------------------------------------------------------
"
" ハイライト強化
NeoBundle 'dag/vim2hs'

" ghcmod 連携
NeoBundle 'eagletmt/ghcmod-vim'

" yesod のhtmlテンプレートのハイライト強化
NeoBundle 'pbrisbin/html-template-syntax'

" Haskell 向けneocomplcache 強化
NeoBundle 'ujihisa/neco-ghc'

" unite のhaddockソース
NeoBundle 'eagletmt/unite-haddock'

" }}}

" unite.vim {{{
" ------------------------------------------------------------------------------------------------------------------------


NeoBundle 'unite.vim'

""unite.vim の各種設定
nnoremap <silent> ,ub :<C-u>Unite buffer -auto-preview<CR> 
nnoremap <silent> ,uU :<C-u>Unite buffer file_mru<CR> 
nnoremap <silent> ,ud :<C-u>UniteWithBufferDir directory<CR> 
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR> 
nnoremap <silent> ,uF :<C-u>Unite file_mru<CR> 
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR> 
nnoremap <silent> ,uh :<C-u>Unite help<CR> 
nnoremap <silent> ,um :<C-u>Unite mark -auto-preview<CR> 
nnoremap <silent> ,uj :<C-u>Unite jump -auto-preview<CR> 
nnoremap <silent> ,uo :<C-u>Unite outline<CR> 
nnoremap <silent> ,uH :<C-u>Unite history/command history/search<CR>
nnoremap <silent> ,uy :<C-u>Unite history/yank<CR>
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file directory<CR>

"ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')

"ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')

"ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

" unite-help.vim
NeoBundle 'tsukkee/unite-help'

" unite-history
" コマンド、検索処理の履歴を表示
NeoBundle 'thinca/vim-unite-history'
" パラメータ
let g:unite_source_history_yank_enable =1

" unite-outline
" Shougo さんのforkした方が最新リポジトリなので注意
NeoBundle 'Shougo/unite-outline'

" unite-gtags
NeoBundle 'hewes/unite-gtags'

" unite-quickfix
NeoBundle 'osyo-manga/unite-quickfix'

" unite-qfixhowm
NeoBundle 'osyo-manga/unite-qfixhowm'

" Unite-colorscheme
NeoBundle 'ujihisa/unite-colorscheme'

" unite-mark
NeoBundle 'tacroe/unite-mark'

"" }}}

" ref.vim {{{
"" ---------------------------------------------------------------------------------------------------------- 
"
NeoBundle 'thinca/vim-ref'

" }}}

" 使ってないプラグイン {{{
" ---------------------------------------------------------------------------------------------------------- 
"
" "accelerated-smooth-scroll
" "滑らかな加速スクロールを行うプラグイン
" NeoBundle 'yonchu/accelerated-smooth-scroll'
" let g:ac_smooth_scroll_du_sleep_time_msec = 2
" let g:ac_smooth_scroll_fb_sleep_time_msec = 2
"
" }}}

" QFixHowm {{{
"" ---------------------------------------------------------------------------------------------------------- 
"
NeoBundle 'fuenor/qfixhowm'

" キーマップリーダー
let QFixHowm_Key = 'g'
" デフォルトの保存先
" let qfixmemo_dir = $HOME . '/Dropbox/tmp/QFixMemo'
let howm_dir = $HOME . '/tmp/QFixMemo'
" メモのエンコーディング
let howm_fileencoding = 'utf-8'
" メモの改行コード
let howm_fileformat = 'unix'
" シンタックスハイライトにMarkdown のものを使用する
let QFixHowm_FileType = 'hown_memo.markdown'
" QFixHown + Markdown
let QFixHowm_HownMode = 0
let QFixHowm_Title = '#'
let suffix = 'mkd'
let QFixHowm_UserFileType = 'markdown'
let QFixHowm_UserFileExt = suffix
let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.'.suffix
" howm折り畳みを無効にする
" let QFixHowm_Folding = 0

"" }}}

" org-mode {{{
"" ---------------------------------------------------------------------------------------------------------- 
NeoBundle 'jceb/vim-orgmode'
NeoBundle 'tpope/vim-speeddating'
"" }}}


filetype plugin indent on     

" 
" 自作プラグインのロード 
"
"
" qiita-vim 
set runtimepath+=~/.vim/my_extention/qiita-vim/


"
" ユーザ定義関数
"

" カレントバッファのファイルのフルパスを表示する
function! Fullpath()
  echo expand("%:p")
endfunction
:command! Fullpath :call Fullpath()

