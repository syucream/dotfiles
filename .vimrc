"
" 各種パラメータ
"

" シンタックスハイライト
syntax on
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
" 検索
set hlsearch
nnoremap <ESC><ESC> :nohlsearch<CR>
" コマンド履歴表示
" q: はtypo しやすいので無効にする。qq: を使うかq/ を使うこと
nnoremap qq: <Esc>q:
noremap q: <Nop>


" ------------------------------------------------------------------------------------------------------------------------
"  折りたたみ設定{{{
set foldmethod=marker
set foldlevel=0
"}}}
"
" ------------------------------------------------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------------------------------------
"
" neobundle.vim
"

filetype off                   

if has('vim_starting')
  set rtp+=~/.vim/bundle/neobundle.vim
endif
call neobundle#rc( expand('~/.vim/bundle') )
NeoBundleFetch 'Shougo/neobundle.vim'

" webapi-vim
NeoBundle 'mattn/webapi-vim'
" vimproc
NeoBundle 'Shougo/vimproc'

" buftabs
NeoBundle 'vim-scripts/buftabs'
let g:buftabs_only_basename = 1
let g:buftabs_in_statusline = 1
let g:buftabs_active_highlight_group = "Visual"
set statusline=%=\ [%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%Y]\[%04l,%04v][%p%%]
set laststatus=2
nmap <c-n> :bn<CR>
nmap <c-n> :bp<CR>

" vim-fugitive
NeoBundle 'tpope/vim-fugitive'

" rails.vim
NeoBundle 'rails.vim'

" sudo
NeoBundle 'sudo.vim'
NeoBundle 'git://github.com/fuenor/im_control.vim.git'
" TODO: IMごとの設定を書く

" vimshell
NeoBundle 'Shougo/vimshell'

" vimfiler
NeoBundle 'Shougo/vimfiler'

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

" shadowmarks
NeoBundle 'vim-scripts/ShowMarks'

" restart.vim
" gVimじゃないと使えない？
" NeoBundle 'tyru/restart.vim'
" let g:restart_sessionoptions = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

" submode
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

" yanktmp
NeoBundle 'vim-scripts/yanktmp.vim'
map <silent> sy :call YanktmpYank()<cr>
map <silent> sp :call YanktmpPaste_p()<cr>
map <silent> sP :call YanktmpPaste_P()<cr> 
let g:yanktmp_file = '~/.vim/yanktmp'

" surround.vim
NeoBundle 'tpope/vim-surround'

" ------------------------------------------------------------------------------------------------------------------------
" unite.vim {{{
" ------------------------------------------------------------------------------------------------------------------------


NeoBundle 'unite.vim'

""unite.vim の各種設定
nnoremap <silent> ,ub :<C-u>Unite buffer<CR> 
nnoremap <silent> ,ud :<C-u>UniteWithBufferDir directory<CR> 
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR> 
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR> 
nnoremap <silent> ,um :<C-u>Unite file_mru<CR> 
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR> 
nnoremap <silent> ,uh :<C-u>Unite help<CR> 
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

"" }}}


"
"" ---------------------------------------------------------------------------------------------------------- 
"" ref.vim {{{
"
NeoBundle 'thinca/vim-ref'

" }}}
"

"
" ---------------------------------------------------------------------------------------------------------- 
"" 使ってないプラグイン {{{
"
" vim-pandoc
" NeoBundle 'vim-pandoc/vim-pandoc'
"
" manpageview
" NeoBundle 'git://github.com/emezeske/manpageview.git'
"
" evervim
" TODO: アカウント設定
" NeoBundle 'kakkyz81/evervim'
"
" "accelerated-smooth-scroll
" "滑らかな加速スクロールを行うプラグイン
" NeoBundle 'yonchu/accelerated-smooth-scroll'
" let g:ac_smooth_scroll_du_sleep_time_msec = 2
" let g:ac_smooth_scroll_fb_sleep_time_msec = 2
"
" }}}
"
"" ---------------------------------------------------------------------------------------------------------- 
"" QFixHowm {{{
"
NeoBundle 'fuenor/qfixhowm'

" キーマップリーダー
let QFixHowm_Key = 'g'
" デフォルトの保存先
" let qfixmemo_dir = $HOME . '/Dropbox/tmp/QFixMemo'
let qfixmemo_dir = $HOME . '/tmp/QFixMemo'
" " デフォルトのファイル名命名規則
let qfixmemo_filename = '%Y/%m/%Y-%m-%d-%H%M%S.txt'
" " メモのエンコーディング
let qfixmemo_fileencoding = 'utf-8'
" " メモの改行コード
let qfixmemo_fileformat = 'unix'
" " シンタックスハイライトにMarkdown のものを使用する
let QFixHown_FileType = 'hown_memo.markdown'
" " QFixHown + Markdown
let QFixHown_HownMode = 0
let QFixHown_Title = '#'
let suffix = 'mkd'
let QFixHown_UserFileType = 'markdown'
let QFixHown_UserFileExt = suffix
let qfixmemo_filename = '%Y/%m/%Y-%m-%d-%H%M%S.'.suffix

"" }}}

filetype plugin indent on     


" 
" 自作プラグインのロード 
"
"
" qiita-vim 
set runtimepath+=~/.vim/my_extention/qiita-vim/



