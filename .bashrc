## History
export HISTCONTROL=ignoreboth
export HISTIGNORE="fg*:bg*:history*:cd*"


## Color
export CLICOLOR=1
export LSCOLORS=DxGxcxdxCxegedabagacad


## Aliases
alias ls='ls -Fh'
alias la='ls -all'

alias g='git'
alias b='bundle'


## Anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"
for D in `ls $HOME/.anyenv/envs`
do
  export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
done


## Git Prompt
source ~/.git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=true
PS1='[\u@\h \W]$(__git_ps1 "[\[\033[32m\]%s\[\033[0m\]]")\$ '

# OPAM configuration
. $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
eval `opam config env`


# Docker
eval "$(docker-machine env default)"

export HAXE_STD_PATH="/usr/local/lib/haxe/std"

# Cabal
export PATH="$PATH:$HOME/Library/Haskell/bin"

# Go
export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:"/usr/local/opt/go/libexec/bin"
