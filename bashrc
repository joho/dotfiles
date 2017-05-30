WORK_GOPATH=$HOME/Projects/99designs/go
HOME_GOPATH=$HOME/Projects/go
export GOPATH=$HOME_GOPATH:$WORK_GOPATH
export GOBIN=$HOME_GOPATH/bin
export GOROOT=$HOME/Tools/go
export GO15VENDOREXPERIMENT=1

export ANDROID_HOME=/$HOME/Library/Android/sdk/

PATH="$HOME/Projects/home/terminal_stuff/shell-scripts:$HOME/bin:$GOROOT/bin:$HOME_GOPATH/bin:$WORK_GOPATH/bin:/usr/local/share/npm/bin:/opt/local/bin:/opt/local/sbin:/usr/local/heroku/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/bin:/opt/local/lib/postgresql84/bin:$HOME/.rbenv/bin:$ANDROID_HOME/bin:$PATH"
export PATH

# get nice colours
TERM=xterm-color; export TERM
export CLICOLOR=1
export LSCOLORS=DxFxCxDxDxegedabagacad

# git branch in prompt
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
if [[ $(uname) == 'Darwin' ]]; then
  . $(brew --prefix)/opt/git/etc/bash_completion.d/git-prompt.sh

  #retarded mac aliases to fix dumb shit
  alias restart_expose="killall Dock"
  alias fucking_eject="drutil tray eject"
  alias fucking_fix_dns="sudo killall -HUP mDNSResponder"
  alias xcode_licence="sudo xcrun cc" # http://blog.tomhennigan.co.uk/post/62238548037/agreeing-to-the-xcode-license-from-the-command
  alias docker_cleanup="docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v /etc:/etc spotify/docker-gc"

  ### Added by the Heroku Toolbelt
  export PATH="/usr/local/heroku/bin:$PATH"

  export EDITOR='mvim -f'
else
  . /usr/share/git-core/contrib/completion/git-prompt.sh

  export EDITOR='vim -f'
fi

function proml {
  local         RED="\[\033[0;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local NO_COLOUR="\[\033[0m\]"

PS1="$RED\h$GREEN[\t]$RED:\w$GREEN\$(__git_ps1)\
\n👻  $NO_COLOUR"
PS2='> '
PS4='+ '
}
proml

# aliases
alias publickey='cat ~/.ssh/id_rsa.pub | pbcopy'
alias gpr='git pull --rebase'
alias cg='cd $(git root)'
alias webserve="ruby -rwebrick -e'WEBrick::HTTPServer.new(:Port => 8000, :DocumentRoot => Dir.pwd).start'"


# work stuff
alias 99mysql="mysql -h mysql.dockervm -u root -P 49801"

99clone() {
  git clone "git://github.com/99designs/$1" ~/Projects/99designs/"$1"
}

if which rbenv > /dev/null 2>&1; then eval "$(rbenv init -)"; fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/joho/google-cloud-sdk/path.bash.inc' ]; then source '/Users/joho/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/joho/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/joho/google-cloud-sdk/completion.bash.inc'; fi
