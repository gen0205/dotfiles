# mac環境かどうかを判別する
# if [ $isMac -eq q ]; の書式で判別する。
isMac=0
if [ "$(uname)" = 'Darwin' ]; then
  isMac=1
fi

# エイリアスの設定
# ls（カラー表示）
# mac環境とlinux環境でカラーオプションを切り替える
if [ $isMac -eq 1 ]; then
  alias ls='ls -G'
  alias ll='ls -lG'
  alias la='ls -laG'
  alias l='clear && ll'
else
  alias ls='ls --color=auto'
  alias ls='ls --color=auto'
  alias ll='ls -l --color=auto'
  alias la='ls -la --color=auto'
  alias l='clear && ll'
fi
# lsのディレクトリの青字が黒背景だと見づらいので紫に変更(macは効かないかも)
export LS_COLORS='di=01;35'

alias ..='cd ..'
alias ..2='cd ../..'
alias ...="cd ../.."
alias ..3='cd ../../..'
alias ....="cd ../../.."
alias .....="cd ../../../.."

alias g='git'
alias ga='git add'
alias gd='git diff'
alias gs='git status'
alias gp='git push'
alias gb='git branch'
alias gst='git status'
alias gco='git checkout'
alias gf='git fetch'
alias gc='git commit -m'

alias home='cd ~'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias d='docker'
# show in Finder
alias f='open -a Finder ./'
alias o='open'
alias q='exit'
alias v='vim'

# プロンプトの設定
#PS1='\[\e[34m\]\w \[\e[37m\]\$\[\e[0m\] '
# git現在のブランチをプロンプトに表示する
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}
function promps {
  # 色は気分で変えたいかもしれないので変数宣言しておく
  local  BLUE="\[\e[1;34m\]"
  local  RED="\[\e[1;31m\]"
  local  GREEN="\[\e[1;32m\]"
  local  WHITE="\[\e[00m\]"
  local  GRAY="\[\e[1;37m\]"
  # 文字色+背景色
  local  WHITE_ON_GREEN="\[\e[1;37;42m\]"

  case $TERM in
    xterm*) TITLEBAR='\[\e]0;\W\007\]';;
         *) TITLEBAR="";;
  esac
  local BASE="\u@\h"
  #PS1="${TITLEBAR}${GREEN}${BASE}${WHITE}:${GREEN}\w${GREEN}\$(parse_git_branch)${WHITE} \$ "

  if [ $isMac -eq 1 ]; then
    PS1="${BLUE}\w${BLUE}\$(parse_git_branch)${WHITE} \$ "
  else
    PS1="${GREEN}\w${WHITE_ON_GREEN}\$(parse_git_branch)${WHITE} \$ "
  fi
}
promps

# 出力の後に改行を入れる
function add_line {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}
PROMPT_COMMAND='add_line'

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
if type rg > /dev/null 2>&1
then
  #rg(ripgrep)コマンドが使用可能な場合
  #fzfコマンドでripgrepを使用する。また、隠しファイルも結果に含み、リンクの場合はリンク先ファイルを読み、.git/フォルダは無視するようにする。
  #上記はfzf.vimの結果にも反映される
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git"'
fi
#fzfコマンド実行時のデフォルトオプション
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --cycle'
## fvimコマンド-リポジトリ管理のファイルをFZFで開き選択したファイルをvimで開く
fvim() {
  files=$(git ls-files) &&
  selected_files=$(echo "$files" | fzf -m --preview 'head -100 {}') &&
  vim $selected_files
}
## fgaコマンド-ファイルにどんな差分があるのかを見ながら、ステージングするファイルを選択する
fga() {
  modified_files=$(git status --short | awk '{print $2}') &&
  selected_files=$(echo "$modified_files" | fzf -m --preview 'git diff {}') &&
  git add $selected_files
}
