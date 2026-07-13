#!/usr/bin/env bash

set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
install_packages=false

usage() {
  cat <<'EOF'
Usage: ./install.sh [--brew]

Link this repository's configuration into the current home directory.
Existing files are never overwritten. Pass --brew to install packages from
the Brewfile before creating links.
EOF
}

while (($#)); do
  case "$1" in
    --brew) install_packages=true ;;
    -h|--help) usage; exit 0 ;;
    *) printf 'Unknown option: %s\n' "$1" >&2; usage >&2; exit 2 ;;
  esac
  shift
done

if $install_packages; then
  if ! command -v brew >/dev/null 2>&1; then
    printf 'Homebrew is required. Install it from https://brew.sh and try again.\n' >&2
    exit 1
  fi
  brew bundle --file "$repo_dir/Brewfile"
fi

links=(
  "ackrc:$HOME/.ackrc"
  "bashrc:$HOME/.bashrc"
  "gemrc:$HOME/.gemrc"
  "gitconfig:$HOME/.gitconfig"
  "gitignore_global:$HOME/.gitignore_global"
  "nvim:$HOME/.config/nvim"
  "vimrc:$HOME/.vimrc"
  "gvimrc:$HOME/.gvimrc"
  "zshrc:$HOME/.zshrc"
)

case "$(uname -s)" in
  Darwin)
    links+=("vscode/settings.json:$HOME/Library/Application Support/Code/User/settings.json")
    ;;
  Linux)
    links+=("vscode/settings.json:$HOME/.config/Code/User/settings.json")
    ;;
  *)
    printf 'Unsupported operating system: %s\n' "$(uname -s)" >&2
    exit 1
    ;;
esac

conflicts=0

for entry in "${links[@]}"; do
  source_path="$repo_dir/${entry%%:*}"
  target_path="${entry#*:}"

  if [[ -L "$target_path" ]] && [[ "$(readlink "$target_path")" == "$source_path" ]]; then
    printf 'ok       %s\n' "$target_path"
    continue
  fi

  if [[ -e "$target_path" || -L "$target_path" ]]; then
    printf 'conflict %s (left unchanged)\n' "$target_path" >&2
    conflicts=$((conflicts + 1))
    continue
  fi

  mkdir -p "$(dirname "$target_path")"
  ln -s "$source_path" "$target_path"
  printf 'linked   %s -> %s\n' "$target_path" "$source_path"
done

if ((conflicts)); then
  printf '\n%d conflict(s) require manual review.\n' "$conflicts" >&2
  exit 1
fi
