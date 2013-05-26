"
" 各種パラメータ
"

" シンタックスハイライト
syntax on
highlight LineNr ctermfg=darkyellow 
"ウィンドウタイトルにファイル名表示
set title
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
" yamktmp
map <silent> sy :call YanktmpYank()<cr>
map <silent> sp :call YanktmpPaste_p()<cr>
map <silent> sP :call YanktmpPaste_P()<cr> 
let g:yanktmp_file = '/Users/ryo/tmp/yanktmp'


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
" buftabs
NeoBundle 'vim-scripts/buftabs'
let g:buftabs_only_basename = 1
let g:buftabs_in_statusline = 1
let g:buftabs_active_highlight_group = "Visual"
set statusline=%=\ [%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%Y]\[%04l,%04v][%p%%]
set laststatus=2
nmap <c-n> :bn<CR>
nmap <c-n> :bp<CR>
" original repos on github
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'rails.vim'
NeoBundle 'unite.vim'
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
" Qiita
" NeoBundle 'mattn/qiita-vim'
" neocomplcache
" autocomplpop と競合するのでそちらは無効にする
NeoBundle 'Shougo/neocomplcache'
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
" command-t
NeoBundle 'git://git.wincent.com/command-t.git'
" accelerated-smooth-scroll
" 滑らかな加速スクロールを行うプラグイン
NeoBundle 'yonchu/accelerated-smooth-scroll'
let g:ac_smooth_scroll_du_sleep_time_msec = 5
let g:ac_smooth_scroll_fb_sleep_time_msec = 5

filetype plugin indent on     


" ------------------------------------------------------------------------------------------------------------------------

"
" QFixMemo
"
" vundle でインストールできない。Google Site からダウンロードすること
" https://sites.google.com/site/fudist/files/qfixhowm.zip?attredirects=0
"
" qfixapp ディレクトリにパスを通す
set runtimepath+=~/.vim/additional/qfixapp/
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


" 
" 自作プラグインのロード 
"
"
" qiita-vim 
set runtimepath+=~/.vim/my_extention/qiita-vim/


"
" 自作関数
"


