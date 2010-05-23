# ~/.gem/ruby/1.8/bin:
PATH="~/scripts:~/.rvm/bin/:~/bin:/opt/local/bin:/opt/local/sbin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/bin:/opt/local/lib/postgresql84/bin/:$PATH"
export PATH

# get nice colours
TERM=xterm-color; export TERM
export CLICOLOR=1
export LSCOLORS=DxFxCxDxDxegedabagacad

# set textmate as the editor of choice
EDITOR='mate -w'; export EDITOR

# set up RVM
if [ -s ~/.bash_rc ] ; then source ~/.bash_rc ; fi

# git branch in prompt
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit (working directory clean)" ]] && echo "!!"
}

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1)$(parse_git_dirty)/"
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
alias mm='cd ~/source/envato/marketplace'
alias mma='mm && mate app config db public features spec compass Rakefile README Capfile lib vendor/plugins'
alias restart_nginx='sudo kill -HUP `cat /var/run/nginx.pid`'
alias fucking_eject='drutil tray eject'
alias gp="git push origin master && marketplace-ci update"

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

# tab completion for mategem
_mategem()
{
    local curw
    COMPREPLY=()
    curw=${COMP_WORDS[COMP_CWORD]}
    local gems="$(gem environment gemdir)/gems"
    COMPREPLY=($(compgen -W '$(ls $gems)' -- $curw));
    return 0
}
complete -F _mategem -o dirnames mategem

# tee hee, i frickin love little chatty shit when i log in
fortune

