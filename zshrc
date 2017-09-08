# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="essembeh"
#ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    autojump
    git
    tmux
)

# User configuration

# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# Theme settings
ZSH_THEME_COLOR_USER="green"
ZSH_THEME_COLOR_HOST="green"
ZSH_THEME_COLOR_PWD="blue"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

unsetopt autocd

# Common environment variables
export PATH=$HOME/bin:$PATH
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LESS="FRSX"
export EDITOR="emacs"
export LD_LIBRARY_PATH="/usr/local/cuda/lib64"

# Common aliases
alias emacs='emacs -nw'
alias ec='emacsclient'
alias ls='ls --color --group-directories-first'

# Go
export GOPATH=$HOME/go
export PATH=/usr/local/go/bin:$GOPATH/bin:$PATH
alias goget='go get -v ./...'
alias goins='go install -v $(go list ./... | grep -v /vendor/)'

# Rust
export PATH=$HOME/.cargo/bin:$PATH

# Python
if [[ -e /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
fi

# Java
export JAVA_HOME=/usr/lib/jvm/java-8-oracle

# Docker
alias docker-ip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias docker-rm="docker rm -v \$(docker ps -a -q --filter status=exited)"
alias docker-rmi="docker rmi \$(docker images -q --filter dangling=true)"

# Hadoop
export PATH=$HOME/local/hadoop/bin:$PATH
export PATH=$HOME/local/hbase/bin:$PATH

# Google Cloud
if [[ -e $HOME/local/google-cloud-sdk ]]; then
    source $HOME/local/google-cloud-sdk/path.zsh.inc
    source $HOME/local/google-cloud-sdk/completion.zsh.inc
fi

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
