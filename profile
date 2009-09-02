PATH="~/scripts:~/.rvm/bin/:~/bin:~/.gem/ruby/1.8/bin:/opt/local/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/bin:$PATH"
export PATH

# get nice colours
TERM=xterm-color; export TERM
export CLICOLOR=1
export LSCOLORS=DxFxCxDxDxegedabagacad

# set textmate as the editor of choice
EDITOR='mate -w'; export EDITOR

# set up
if [ -f ~/.rvm/bin/rvm ] ; then source ~/.rvm/bin/rvm ; fi

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
  local BLINK_GREEN="\[\033[5;32m\]"
 
PS1="$RED\h$GREEN[\t]$RED:\w$GREEN\$(parse_git_branch)\
\n\$ $WHITE"
PS2='> '
PS4='+ '
}
proml

# git checkout tab auto completion
source ~/.git-completion.sh

# aliases
alias la='ls -la'
alias cowboy='git push && cap deploy'
alias publickey='cat ~/.ssh/id_rsa.pub | pbcopy'

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

# give me script/console or irb depending
function sc {
  if [ -x script/console ]; then
script/console
  else
sinatra_rb=`egrep -l "^require.+sinatra.$" *.rb 2>/dev/null`
    if [ -e $sinatra_rb ]; then
irb -r $sinatra_rb
    else
irb
    fi
fi
}

# tee hee, i frickin love little chatty shit when i log in
fortune
