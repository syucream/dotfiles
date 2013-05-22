"
" 各種パラメータ
"
syntax on
highlight LineNr ctermfg=darkyellow 
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
" original repos on github
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'rails.vim'
NeoBundle 'unite.vim'
NeoBundle 'sudo.vim'
" vimshell
NeoBundle 'Shougo/vimshell'
" quickrun
NeoBundle 'thinca/vim-quickrun'
" tcomment
NeoBundle 'tomtom/tcomment_vim'
" Qiita
" NeoBundle 'mattn/qiita-vim'
" neocomplcache
" autocomplpop と競合するのでそちらは無効にする
NeoBundle 'Shougo/neocomplcache'
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
" non github repos
NeoBundle 'git://git.wincent.com/command-t.git'
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
