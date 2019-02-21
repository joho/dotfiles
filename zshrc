export GOPATH=$HOME/Projects/go
export GOBIN=$GOPATH/bin

export PATH="$HOME/bin:$GOPATH/bin:$HOME/.rbenv/bin:/usr/lib/go-1.10/bin:/usr/local/bin:/usr/local/sbin:$HOME/.local/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"
DEFAULT_USER="joho"
prompt_context(){}

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
plugins=(git rbenv nvm)

source $ZSH/oh-my-zsh.sh

# User configuration
# IS_LINUX=
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Setting ag as the default source for fzf
export FZF_DEFAULT_COMMAND='ag -g ""'

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION || "$(uname 2> /dev/null)" == "Linux" ]]; then
  export EDITOR='vim'
else
  export EDITOR='mvim -f --nomru -c "au VimLeave * !open -a iTerm2"'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Custom aliases
alias publickey='cat ~/.ssh/id_rsa.pub | pbcopy'
alias gpr='git pull --rebase'
alias cg='cd $(git root)'
if [[ "$(uname 2> /dev/null)" == "Linux" ]]; then
  alias open='xdg-open'
fi

dc() { docker-compose $* }
dcr() { docker-compose run --rm $* }

# Duplicate my projects folder thing from my bashrc
# TODO: make it actually work
PROJECTS=~/Projects
function p() {
  cd $PROJECTS/$1
}

# Windows For Linux hacks
if  uname -r | grep -Eq 'Microsoft'; then
  alias code="cmd.exe \/C code $*"
  export DOCKER_HOST=tcp://localhost:2375
fi

# Linux aws-vault config
if [[ "$(uname 2> /dev/null)" == "Linux" ]]; then
  export AWS_VAULT_BACKEND=secret-service
fi
