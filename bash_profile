# tee hee, i frickin love little chatty shit when i log in
fortune /Users/joho/Projects/home/programmers_oblique_strategies | cowsay

eval $(docker-machine env 99dev)

[[ -s ~/.bashrc ]] && source ~/.bashrc

complete -C aws_completer aws
complete -C aws_completer sudo
complete -C aws_completer aws-vault

# project shortcuts with completion
export PROJECTS="$HOME/Projects"

p() {
  cd "$PROJECTS/$1" || exit
}

_p() {
  COMPREPLY=( $(compgen -W "$(ls $PROJECTS | grep -vE \"^_\")" -- ${COMP_WORDS[COMP_CWORD]} ) )
}

complete -F _p p
