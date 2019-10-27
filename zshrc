export ZSH=$HOME/.oh-my-zsh

plugins=(
    autojump
    dotenv
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

# Python
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/shims:$PATH"
export VIRTUALENVWRAPPER_PYTHON="$PYENV_ROOT/shims/python"

# Java
export JAVA_HOME=/usr/lib/jvm/java-10-openjdk

# Docker
alias docker-ip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias docker-rm="docker rm -v \$(docker ps -a -q --filter status=exited)"
alias docker-rmi="docker rmi \$(docker images -q --filter dangling=true)"

# Google Cloud
if [[ -e $HOME/.local/google-cloud-sdk ]]; then
    export CLOUDSDK_PYTHON=/usr/bin/python2.7
    source $HOME/.local/google-cloud-sdk/path.zsh.inc
    source $HOME/.local/google-cloud-sdk/completion.zsh.inc
fi

# Protobuf
function protocw () {
    set -x
    protoc -I. \
         -I$GOPATH/src \
         -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis/ \
         --go_out=plugins=grpc:$GOPATH/src \
         --grpc-gateway_out=. \
         $@
}

# Kubernetes
alias ku="kubectl"
alias deploys="kubectl get deployments"
alias pods="kubectl get pods"
alias services="kubectl get services"

function forward () {
    name=$(kubectl get pods -o name | grep "^pods/$1" | head -1 | cut -b6-)
    if [ -z "$name" ]; then
        echo "not found $1" 1>&2
        return 1
    fi
    echo $name 1>&2
    shift
    port=30000
    if [ ! -z "$1" ]; then
        port=$1
        shift
    fi
    kubectl port-forward $name $port $@
}

function logs() {
    name=$(kubectl get pods -o name | grep "^pods/$1" | head -1 | cut -b6-)
    if [ -z "$name" ]; then
        echo "not found $1" 1>&2
        return 1
    fi
    echo $name 1>&2
    shift
    kubectl logs $name $@
}

# Local settings
if [[ -e ~/.zshrc_private ]]; then
    source ~/.zshrc_private
fi
