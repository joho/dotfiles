# tee hee, i frickin love little chatty shit when i log in
fortune

PATH="~/scripts:~/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/bin:/opt/local/lib/postgresql84/bin/:$PATH"
export PATH

# get nice colours
TERM=xterm-color; export TERM
export CLICOLOR=1
export LSCOLORS=DxFxCxDxDxegedabagacad

# OS specific stuff (like editor)
case $(uname -s) in
  Darwin)
    export EDITOR='mvim -f'
  ;;
  Linux)
    export EDITOR='gvim -f'
  ;;
esac

# git branch in prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "!!"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1)$(parse_git_dirty)/"
}

function plain_git_branch {
  git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///'
}
  
function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local BLINK_GREEN="\[\033[5;32m\]"
  local NO_COLOUR="\[\033[0m\]"
 
PS1="$RED\h$GREEN[\t]$RED:\w$GREEN\$(parse_git_branch)\
\n♺ $NO_COLOUR"
PS2='> '
PS4='+ '
}
proml

# git checkout tab auto completion
source ~/.git-completion.sh

# aliases
alias cowboy='git push && cap deploy'
alias publickey='cat ~/.ssh/id_rsa.pub | pbcopy'
alias mm='cd ~/source/envato/marketplace'
alias mateapp='mate app config db public features spec compass lib vendor/plugins docs Rakefile README Capfile Gemfile'
alias mma='mm && mvim .'
alias restart_nginx='sudo kill -HUP `cat /var/run/nginx.pid`'
alias gp="git push origin $(plain_git_branch)"
alias gpr='git fetch origin && git rebase -p origin/$(plain_git_branch)'
alias gprp="gp && gpr"
alias bb="babushka"
alias remigrate="VERSION=\!^ rake db:migrate:down && VERSION=\!^ rake db:migrate:up"
alias cuke="bundle exec cucumber"

#retarded mac aliases to fix dumb shit
alias restart_expose="killall Dock"
alias fucking_eject="drutil tray eject"
alias fucking_fix_dns="sudo killall mDNSResponder"

#likeaboss
alias fml="open /Applications/Microsoft\ Office\ 2008/Microsoft\ Excel.app"

# project shortcuts with completion
export PROJECTS="$HOME/source"

p() {
  cd "$PROJECTS/$1"
}

_p() {
  COMPREPLY=( $(compgen -W "$(ls $PROJECTS | grep -vE \"^_\")" -- ${COMP_WORDS[COMP_CWORD]} ) )
}

complete -F _p p

# stop ctrl-D logging me out
shopt -s -o ignoreeof

# allow me to ctrl-z, ctrl-f for some retro multitasking
export HISTIGNORE="fg*"
bind '"\C-f": "fg %-\n"'

export ACK_OPTIONS="--nosql --type-set cucumber=.feature --type-set sass=.sass" # Make ack ignore sql dumps, and search cucumber features.

# set up the env variables for the ec2 command line tools
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Home"
if [ -f $HOME/.ec2 ]
then
  export EC2_CERT="$(/bin/ls $HOME/.ec2/cert-*.pem)"
  export EC2_PRIVATE_KEY="$(/bin/ls $HOME/.ec2/pk-*.pem)"
  export EC2_HOME="/usr/local/Cellar/ec2-api-tools/1.3-57419/jars"
fi

export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init -)"

function rmb {
  current_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ "$current_branch" != "master" ]; then
    echo "WARNING: You are on branch $current_branch, NOT master."
  fi
    echo "Fetching merged branches..."
  git remote prune origin
  remote_branches=$(git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$")
  local_branches=$(git branch --merged | grep -v 'master$' | grep -v "$current_branch$")
  if [ -z "$remote_branches" ] && [ -z "$local_branches" ]; then
    echo "No existing branches have been merged into $current_branch."
  else
    echo "This will remove the following branches:"
    if [ -n "$remote_branches" ]; then
      echo "$remote_branches"
    fi
    if [ -n "$local_branches" ]; then
      echo "$local_branches"
    fi
    read -p "Continue? (y/n): " -n 1 choice
    echo
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
      # Remove remote branches
      git push origin `git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$" | sed 's/origin\//:/g' | tr -d '\n'`
      # Remove local branches
      git branch -d `git branch --merged | grep -v 'master$' | grep -v "$current_branch$" | sed 's/origin\///g' | tr -d '\n'`
    else
      echo "No branches removed."
    fi
  fi
}

