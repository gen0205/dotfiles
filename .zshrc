# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# mac環境かどうかを判別する
# if [ $isMac -eq q ]; の書式で判別する。
isMac=0
case ${OSTYPE} in
  darwin*)
    # macの場合
    isMac=1
    ;;
  linux*)
    ;;
esac

#############################
# zsh option

# コマンド補完
autoload -U compinit
compinit
_comp_options+=(globdots)
# 大文字小文字に関わらず, 候補が見つからない時のみ文字種を無視した補完をする.
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# 矢印キーのインターフェイスを使って自動補完する
# メニューを有効にするには、タブを二度押し
# select=2: 補完候補を一覧から選択する。補完候補が2つ以上なければすぐに補完する。
zstyle ':completion:*' menu select=2
# 補完候補に色を付ける。
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# 日本語ファイル名を表示可能にする
setopt print_eight_bit
# beep を無効にする
setopt no_beep
# ディレクトリ名だけで移動
setopt auto_cd
setopt auto_list  # 補完候補が複数ある時に、一覧表示
setopt auto_menu  # 補完候補が複数あるときに自動的に一覧表示する
# CTRL + N or CTRL + P で前方または後方に移動する
bindkey '^n' expand-or-complete
bindkey '^p' reverse-menu-complete
#############################

alias fzf='fzf-tmux'

# エイリアスの設定
# ls（カラー表示）
# mac環境とlinux環境でカラーオプションを切り替える
# ezaコマンドが使える場合はそちらを使う
if type eza > /dev/null 2>&1; then
  alias ls='eza -g --time-style=long-iso'
  alias ll='ls -l --header --git'
  alias la='ls -la --header --git'
  alias l='clear && ll'
elif [ $isMac -eq 1 ]; then
  alias ls='ls -hG'
  alias ll='ls -lhG'
  alias la='ls -lhaG'
  alias l='clear && ll'
else
  alias ls='ls -h --color=auto'
  alias ls='ls -h --color=auto'
  alias ll='ls -lh --color=auto'
  alias la='ls -lha --color=auto'
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
alias gp='git pull'
alias gb='git branch'
alias gst='git status'
alias gco='git checkout'
alias gf='git fetch'
alias gc='git commit -m'
alias lg='lazygit'

alias home='cd ~'

alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

alias ff='find . -type f -name'
if !type fd > /dev/null 2>&1; then
  # fdコマンドがインストールされていない場合
  alias fd='find . -type d -name'
fi

alias d='docker'
# Docker起動時に Fatal Error Failed to ping backend API という警告が出た場合の対処法
alias rdocker="killall Docker && cd /Applications;open -a Docker;cd ~"
# show in Finder
alias f='open -a Finder ./'
alias o='open'
alias q='exit'

if type nvim > /dev/null 2>&1; then
  alias v='nvim'
  alias vi='nvim'
  alias vim='nvim'
else
  alias v='vim'
fi

alias relogin='exec $SHELL -l'
alias t='tm'

# ggrks
ggrks(){
  local a="/Applications"
  local u="https://www.google.co.jp/search?q="
  case $1 in
    -c) shift; open "${u}${*// /+}" -a "${a}/Google Chrome.app";;
    -f) shift; open "${u}${*// /+}" -a "${a}/Firefox.app";;
    -s) shift; open "${u}${*// /+}" -a "${a}/Safari.app";;
     *) open "${u}${*// /+}";;
  esac
}

# historyの設定
setopt share_history              # 同時に起動したzshの間でヒストリを共有する
setopt HIST_IGNORE_ALL_DUPS       # 履歴中の重複行をファイル記録前に無くす
setopt HIST_IGNORE_SPACE          # 行頭がスペースのコマンドは記録しない
setopt HIST_FIND_NO_DUPS          # 履歴検索中、(連続してなくとも)重複を飛ばす
setopt HIST_REDUCE_BLANKS         # 余分な空白は詰めて記録
setopt HIST_NO_STORE              # histroyコマンドは記録しない

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

# Bat
export BAT_THEME="Dracula"

# MANPAGER
if type bat > /dev/null 2>&1; then
  # batがある場合はmanコマンドにbatを適応する
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
if type rg > /dev/null 2>&1; then
  #rg(ripgrep)コマンドが使用可能な場合
  #fzfコマンドでripgrepを使用する。また、隠しファイルも結果に含み、リンクの場合はリンク先ファイルを読み、.git/フォルダは無視するようにする。
  #上記はfzf.vimの結果にも反映される
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git"'
fi
# fzf --preview時のオプション
if type bat > /dev/null 2>&1; then
  # batがある場合はbatコマンドを使用
  FZF_PREVIEW="bat --color=always --style=header,grid,numbers --line-range :100 {}"
else
  FZF_PREVIEW="head -100 {}"
fi
#fzfコマンド実行時のデフォルトオプション
export FZF_DEFAULT_OPTS="--height 40% --reverse --border --cycle"
# FZF-cd
fcd() {
  local dir
  dir=$(fd -t d | fzf +m --preview 'ls -la {}') &&
  cd "$dir"
}
# FZF-open
fo() {
  local target
  target=$(fd| fzf +m) &&
  open "$target"
}
# FZF-vim
alias fv='vim $(fzf-tmux -m --preview "$FZF_PREVIEW")'
alias fvi='vim $(fzf-tmux -m --preview "$FZF_PREVIEW")'

# FZF-git
## fvimコマンド-リポジトリ管理のファイルをFZFで開き選択したファイルをvimで開く
fvim() {
  files=$(git ls-files) &&
  selected_files=$(echo "$files" | fzf-tmux -m --preview "$FZF_PREVIEW") &&
  vim $selected_files
}
## fgaコマンド-ファイルにどんな差分があるのかを見ながら、ステージングするファイルを選択する
fga() {
  modified_files=$(git status --short | awk '{print $2}') &&
  selected_files=$(echo "$modified_files" | fzf-tmux -m --preview 'git diff --color=always {}') &&
  git add $selected_files
}
# from https://github.com/junegunn/fzf/wiki/examples
## fbr - checkout git branch (including remote branches)
fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
## fco_preview - checkout git branch/tag, with a preview showing the commits between the tag/branch and HEAD
fco_preview() {
  local tags branches target
  branches=$(
    git --no-pager branch --all \
      --format="%(if)%(HEAD)%(then)%(else)%(if:equals=HEAD)%(refname:strip=3)%(then)%(else)%1B[0;34;1mbranch%09%1B[m%(refname:short)%(end)%(end)" \
    | sed '/^$/d') || return
  tags=$(
    git --no-pager tag | awk '{print "\x1b[35;1mtag\x1b[m\t" $1}') || return
  target=$(
    (echo "$branches"; echo "$tags") |
    fzf-tmux --no-hscroll --no-multi -n 2 \
        --ansi --preview="git --no-pager log -150 --pretty=format:%s '..{2}'") || return
  git checkout $(awk '{print $2}' <<<"$target" )
}

# FZF-tmux
# fzfを使ってtmuxセッションを作成/切り替える
# tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
# `tm` will allow you to select your tmux session via fzf.
# `tm irc` will attach to the irc session (if it exists), else it will create it.
tm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}
# 選択したtmuxセッションを削除する
tmuxkillsession () {
  local sessions session
  sessions="$(tmux ls -F "#{session_name}" 2>/dev/null | fzf --exit-0 --multi | xargs)"  || return $?
  for session in $sessions
  do
    echo "Killing $session"
    tmux kill-session -t "$session"
  done
}

# FZF-asdf
# Install one or more versions of specified language
# e.g. `vmi rust` # => fzf multimode, tab to mark, enter to install
# if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [I]nstall
vmi() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions=$(asdf list-all $lang | fzf -m)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do asdf install $lang $version; done;
    fi
  fi
}
# Remove one or more versions of specified language
# e.g. `vmi rust` # => fzf multimode, tab to mark, enter to remove
# if no plugin is supplied (e.g. `vmi<CR>`), fzf will list them for you
# Mnemonic [V]ersion [M]anager [C]lean
vmc() {
  local lang=${1}

  if [[ ! $lang ]]; then
    lang=$(asdf plugin-list | fzf)
  fi

  if [[ $lang ]]; then
    local versions=$(asdf list $lang | fzf -m)
    if [[ $versions ]]; then
      for version in $(echo $versions);
      do asdf uninstall $lang $version; done;
    fi
  fi
}

# tmux
# ターミナル起動時に自動でtmuxにアタッチする
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t default || tmux new -s default
fi

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

# 出力の後に改行を入れる
function add_line {
  if [[ -z "${PS1_NEWLINE_LOGIN}" ]]; then
    PS1_NEWLINE_LOGIN=true
  else
    printf '\n'
  fi
}

# thefuck settings

eval $(thefuck --alias)

# プロンプト設定反映 zshrcの最後で実行する
if type starship > /dev/null 2>&1; then
  #starshipコマンドが使用可能な場合はプロンプトにstarshipを使用する
  eval "$(starship init zsh)"
else
  promps
  PROMPT_COMMAND='add_line'
fi

# zoxide settings

eval "$(zoxide init zsh)"

# zsh-syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# 色を変更する。デフォルトは8
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=5'
# powerlevel10k プロンプトのテーマ
source /usr/local/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
