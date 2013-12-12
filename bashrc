# tee hee, i frickin love little chatty shit when i log in
fortune | cowsay

# set go workspace
export GOPATH=$HOME/Projects/go

PATH="~/scripts:~/bin:$GOPATH/bin:/usr/local/share/npm/bin:/opt/local/bin:/opt/local/sbin:/usr/local/heroku/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/bin:/opt/local/lib/postgresql84/bin:~/.rbenv/bin:~/.rbenv/plugins/ruby-build/bin:$PATH"
export PATH


# get nice colours
TERM=xterm-color; export TERM
export CLICOLOR=1
export LSCOLORS=DxFxCxDxDxegedabagacad

# OS specific stuff (like editor)
case $(uname -s) in
  Darwin)
    export EDITOR='subl -w'
  ;;
  Linux)
    export EDITOR='gvim -f'
  ;;
esac

# git branch in prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]] && echo "!!"
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
\n👻  $NO_COLOUR"
PS2='> '
PS4='+ '
}
proml

# git checkout tab auto completion
source ~/.git-completion.sh

# aliases
alias publickey='cat ~/.ssh/id_rsa.pub | pbcopy'
alias gp="git push origin $(plain_git_branch)"
alias gpr='git fetch origin && git rebase -p origin/$(plain_git_branch)'
alias spec="bin/rspec"
alias cowboy="git push && bin/cap production deploy"
alias killruby="ps aux | grep [r]uby | awk '{print \$2}' | xargs kill -9"

#retarded mac aliases to fix dumb shit
alias restart_expose="killall Dock"
alias fucking_eject="drutil tray eject"
alias fucking_fix_dns="sudo killall -HUP mDNSResponder"

# work stuff
alias 99vm="cd ~/Projects/99designs/vmconfig && vagrant ssh"
export DEV_VM_MEM_FRACTION=8

# project shortcuts with completion
export PROJECTS="$HOME/Projects"

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

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# use vmware by default for vagrant
export VAGRANT_DEFAULT_PROVIDER=vmware_fusion

# if kernel_task is going weird read http://www.rdoxenham.com/?p=259 (maybe make an alias to help)

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
