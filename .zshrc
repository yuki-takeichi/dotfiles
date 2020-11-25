eval "$(anyenv init -)"

# opam configuration
test -r /Users/yuki.takeichi/.opam/opam-init/init.zsh && . /Users/yuki.takeichi/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export PATH="/usr/local/opt/swagger-codegen@2/bin:$PATH"

eval "$(direnv hook zsh)"

export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"

# git-prompt
GIT_PS1_SHOWSTASHSTATE=true
source ~/.git-prompt.sh
setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
