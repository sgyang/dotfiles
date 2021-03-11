
# autojump
[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && source $HOME/.autojump/etc/profile.d/autojump.sh

export ZSH=$HOME/.oh-my-zsh

plugins=(
    autojump
    git
    tmux
)

#ZSH_THEME="candy"

source $ZSH/oh-my-zsh.sh

PROMPT=$'%{$fg_bold[green]%}%n@%m %{$fg[blue]%}%D{[%H:%M:%S]} %{$reset_color%}%{$fg[white]%}[%~]%{$reset_color%} $(git_prompt_info)\
$ '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

unsetopt autocd

function register_id_rsa () {
    if [[ -z "$1" ]]; then
        echo "usage: $0 [host]"
        return 1
    fi
    cat ~/.ssh/id_rsa.pub | ssh $1 "cat - > /tmp/hoge && mkdir -p ~/.ssh && cat /tmp/hoge >> ~/.ssh/authorized_keys && chmod 700 ~/.ssh && chmod 600 ~/.ssh/authorized_keys"
}

# Common environment variables
export PATH=$HOME/bin:$HOME/local/bin:$HOME/.local/bin:$PATH
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="FRSX"
export EDITOR="emacs"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64"
export LSCOLORS=Exfxcxdxbxegedabagacad

# Common aliases
alias emacs='emacs -nw'
alias ec='emacsclient'

case "$(uname -s)" in
    Darwin)
        ;;
    *)
        alias ls='ls --color --group-directories-first'
        ;;
esac

# Go
export GOPATH=$HOME/go
export PATH=/usr/local/go/bin:$GOPATH/bin:$PATH
alias goget='go get -v ./...'
alias goins='go install -v $(go list ./... 2> /dev/null | grep -v /vendor/ | grep -v /node_modules/)'

# Rust
export PATH=$HOME/.cargo/bin:$PATH

# Python: pyenv + pipenv
# git clone https://github.com/pyenv/pyenv.git ~/.pyenv
# git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
export PYENV_ROOT=$HOME/.pyenv
export PATH=$PYENV_ROOT/bin:$PATH
if type pyenv > /dev/null; then
    eval "$(pyenv init -)"
fi
if [[ -e $PYENV_ROOT/plugins/pyenv-virtualenv ]]; then
    eval "$(pyenv virtualenv-init -)"
fi
export PIPENV_VENV_IN_PROJECT=true
export PIPENV_SKIP_LOCK=true # Locking is super slow

function init_python_env () {
    if [[ ! -e $PYENV_ROOT ]]; then
        git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
    fi
    if [[ ! -e $PYENV_ROOT/plugins/pyenv-virtualenv ]]; then
        git clone https://github.com/pyenv/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv
    fi
    source $HOME/.zshrc
}

# Node.js
export PATH=$HOME/.yarn/bin:$PATH
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Java
export JAVA_HOME=/usr/lib/jvm/default

# Docker
alias docker-ip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias docker-rm="docker rm -v \$(docker ps -a -q --filter status=exited)"
alias docker-rmi="docker rmi \$(docker images -q --filter dangling=true)"

# Google Cloud
if [[ -e $HOME/.local/google-cloud-sdk ]]; then
    #export CLOUDSDK_PYTHON=/usr/bin/python2.7
    source $HOME/.local/google-cloud-sdk/path.zsh.inc
    source $HOME/.local/google-cloud-sdk/completion.zsh.inc
fi

# Kubernetes
alias ku="kubectl"
alias deploys="kubectl get deployments"
alias pods="kubectl get pods"
alias services="kubectl get services"

# Dart and Flutter (snap)
export PATH=$HOME/snap/flutter/common/flutter/bin:$PATH
export PATH=$HOME/.pub-cache/bin:$PATH

# Local settings
if [[ -e ~/.zshrc_private ]]; then
    source ~/.zshrc_private
fi
