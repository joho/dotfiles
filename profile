PATH="/opt/local/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
export PATH

# get nice colours
TERM=xterm-color; export TERM
export CLICOLOR=1
export LSCOLORS=DxFxCxDxDxegedabagacad

# git branch in prompt
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
 
function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
 
PS1="$RED\h:\w$GREEN\$(parse_git_branch)$BLUE\
$GREEN\$ $WHITE"
PS2='> '
PS4='+ '
}
proml

# git checkout tab auto completion
source ~/.git-completion.sh

# aliases
alias la='ls -la'

# project shortcuts with completion
export PROJECTS="$HOME/source"

p() {
  cd "$PROJECTS/$1"
}

_p() {
  COMPREPLY=( $(compgen -W "$(ls $PROJECTS | grep -vE \"^_\")" -- ${COMP_WORDS[COMP_CWORD]} ) )
}

complete -F _p p
