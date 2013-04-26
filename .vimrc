"
" 各種パラメータ
"
syntax on
highlight LineNr ctermfg=darkyellow 
set number
set showmatch
set smartcase
" タブ、インデント関連
set shiftwidth=4
set tabstop=4
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


" autocomplpop.vim
"<TAB>で補完
" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
"function! InsertTabWrapper()
"        let col = col('.') - 1
"        if !col || getline('.')[col - 1] !~ '\k'
"                return "\<TAB>"
"        else
"                if pumvisible()
"                        return "\<C-N>"
"                else
"                        return "\<C-N>\<C-P>"
"                end
"        endif
"endfunction

" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }}} Autocompletion using the TAB key


"
" vundle
"
set nocompatible
filetype off                   
set rtp+=~/.vim/vundle.git/   
call vundle#rc()               

" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'rails.vim'
Bundle 'unite.vim'
Bundle 'sudo.vim'
" tcomment
Bundle 'tomtom/tcomment_vim'
" neocomplcache
" autocomplpop と競合するのでそちらは無効にする
Bundle 'Shougo/neocomplcache'
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1
" non github repos
Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on     

"
" QFixMemo
"
set runtimepath+=~/.vim/plugin/qfixapp
" キーマップリーダー
let QFixHowm_Key = 'g'
" デフォルトの保存先
let qfixmemo_dir = $HOME . '/Dropbox/tmp/QFixMemo'
" " デフォルトのファイル名命名規則
let qfixmemo_filename = '%Y/%m/%Y-%m-%d-%H%M%S.txt'
" " メモのエンコーディング
let qfixmemo_fileencoding = 'utf-8'
" " メモの改行コード
let qfixmemo_fileformat = 'unix'

