# Hack for "bash for windows" to turn into "zsh for windows"
if  uname -r | grep -Eq 'Microsoft'; then
  bash -c zsh
  exit
fi
