syntax on
highlight LineNr ctermfg=darkyellow 
set termencoding=utf-8
set encoding=japan
set fileencodings=utf-8
set fenc=utf-8
set enc=utf-8

set number
set shiftwidth=4
set tabstop=4
"set smartindent
"set showmatch
"set smartcase
"set expandtab

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
function! InsertTabWrapper()
        let col = col('.') - 1
        if !col || getline('.')[col - 1] !~ '\k'
                return "\<TAB>"
        else
                if pumvisible()
                        return "\<C-N>"
                else
                        return "\<C-N>\<C-P>"
                end
        endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }}} Autocompletion using the TAB key


" yamktmp
map <silent> sy :call YanktmpYank()<CR> 
map <silent> sp :call YanktmpPaste_p()<CR> 
map <silent> sP :call YanktmpPaste_P()<CR> 


" vundle
set nocompatible
filetype off                   

set rtp+=~/.vim/vundle.git/   
call vundle#rc()               

" original repos on github
Bundle 'tpope/vim-fugitive'

" vim-scripts repos
Bundle 'rails.vim'
Bundle 'unite.vim'

" non github repos
Bundle 'git://git.wincent.com/command-t.git'

filetype plugin indent on     



