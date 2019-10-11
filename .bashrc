# エイリアスの設定
# ls（カラー表示）
alias ls='ls -G'
alias ll='ls -lG'
alias la='ls -laG'
alias l='clear && ll'

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
PS1='\[\e[34m\]\w \[\e[37m\]\$\[\e[0m\] '
