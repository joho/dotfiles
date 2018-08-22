# Hack for "bash for windows" to turn into "zsh for windows"
if  uname -r | grep -Eq 'Microsoft'; then
  bash -c zsh
  exit
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
