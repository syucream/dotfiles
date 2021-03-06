# PATH {{{
# ---------------------------------------------------------------------------------------------------- 

# coreutils on MacOS
PATH=$PATH:/usr/local/opt/coreutils/libexec/gnubin
# for golang
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/.go
PATH=$GOPATH/bin/:$PATH

# ~/local/bin
PATH=~/local/bin:$PATH

# }}}

# alias {{{
# ---------------------------------------------------------------------------------------------------- 

alias sc='screen'
alias tmux='tmux -2'
alias gr='grep -R -n -I'
alias ll='ls -l'
alias du="du -h"
alias df="df -h"
alias vim="nvim"
# for git
alias gbr='git branch'
alias gco='git checkout'
alias gst='git status -sb'
alias gdf='git diff --color'
alias glog='git log --color'
alias gitaa='git add .'
alias gitcm='git commit'
alias gitf='git fetch'
alias gitpl='git pull'
alias gitps='git push'

# }}}

# プロンプト設定 {{{
# ---------------------------------------------------------------------------------------------------- 

# ${fg[...]} や $reset_color をロード
autoload -U colors; colors
# git のブランチ名を、statusによって色分けして表示する
function rprompt-git-current-branch {
        local name st color

        if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
                return
        fi
        name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
        if [[ -z $name ]]; then
                return
        fi
        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
                color=${fg[green]}
        elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
                color=${fg[yellow]}
        elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
                color=${fg_bold[red]}
        else
                color=${fg[red]}
        fi

        # %{...%} は囲まれた文字列がエスケープシーケンスであることを明示する
        # これをしないと右プロンプトの位置がずれる
        echo "%{$color%}$name%{$reset_color%} "
}

# プロンプトが表示されるたびにプロンプト文字列を評価、置換する
setopt prompt_subst

case ${UID} in
0)
  PROMPT="[%{${fg[cyan]}%}%n@%m%{${reset_color}%}] %{${fg[cyan]}%}#%{${reset_color}%} "
  PROMPT2="%B%{${fg[cyan]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[cyan]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  RPROMPT='[`rprompt-git-current-branch`%~]'
  ;;
  *)
  PROMPT="[%n@%m] %{${fg[cyan]}%}$%{${reset_color}%} "
  PROMPT2="%B%{${fg[cyan]}%}%_#%{${reset_color}%}%b "
  SPROMPT="%B%{${fg[cyan]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
  RPROMPT='[`rprompt-git-current-branch`%{${fg[cyan]}%}%~%{${reset_color}%}]'
  ;;
esac

# }}}

export LANG=ja_JP.UTF-8
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

# Vi キーバインド
bindkey -v

## コアダンプサイズを制限
limit coredumpsize 102400

## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr

## 色を使う
setopt prompt_subst

## ビープを鳴らさない
setopt nobeep

## 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt long_list_jobs

## 補完候補一覧でファイルの種別をマーク表示
setopt list_types

## サスペンド中のプロセスと同じコマンド名を実行した場合はリジューム
setopt auto_resume

## 補完候補を一覧表示
setopt auto_list

## 補完候補を詰めて表示
setopt list_packed

## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups

## cd 時に自動で push
setopt autopushd

## 同じディレクトリを pushd しない
setopt pushd_ignore_dups

## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob

## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history

## =command を command のパス名に展開する
setopt equals

## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst

## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify

# ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort

## 出力時8ビットを通す
setopt print_eight_bit

## ヒストリを共有
#setopt share_history

## cd後にlsを実行する
# setopt auto_cd
# function chpwd() { ls }

# 補完関連 {{{
# ---------------------------------------------------------------------------------------------------- 

# 補完設定を読み込む
fpath=(~/.zsh/completion $fpath)

## 補完を有効にする
autoload -U compinit
compinit

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1
## 補完候補の色づけ
export ZLS_COLORS=$LS_COLORS
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## TAB で順に補完候補を切り替える
setopt auto_menu

## ディレクトリ名だけで cd
setopt auto_cd

## カッコの対応などを自動的に補完
setopt auto_param_keys

## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash

## スペルチェック
setopt correct

## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash

# }}}

# テキストブラウザ検索設定 {{{
# ---------------------------------------------------------------------------------------------------- 
export TEXT_BROWSER=w3m
function _space2p20
{
	    echo $@ |sed -e "s/ /%20/g"
}
function _space2plus
{
	    echo $@ | sed -e "s/ /+/g"
}
function google
{
	    ${TEXT_BROWSER} "http://www.google.co.jp/search?q="`_space2plus $@`"&hl=ja"
}
function ydic
{
	    ${TEXT_BROWSER} "http://dic.yahoo.co.jp/dsearch?enc=UTF-8&p="`_space2plus $@`"&stype=0&dtyp
		e=2"
}
function technorati
{
	    ${TEXT_BROWSER} http://www.technorati.com/search/`_space2p20 $@`"?language=ja"
}
function wikipedia
{
	    ${TEXT_BROWSER} http://ja.wikipedia.org/wiki/`_space2p20 $@`
}
# }}}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ryo/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/ryo/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ryo/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/ryo/google-cloud-sdk/completion.zsh.inc'; fi

# added by travis gem
[ -f /Users/ryo/.travis/travis.sh ] && source /Users/ryo/.travis/travis.sh

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit snippet PZT::modules/helper/init.zsh
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma/fast-syntax-highlighting
zinit light zdharma/history-search-multi-word
zinit light mollifier/anyframe
