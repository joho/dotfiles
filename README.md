# dotfiles

John Barton's command-line and editor configuration, kept consistent across
personal and work Macs (and the occasional Linux/WSL box).

## Install

```sh
git clone git@github.com:joho/dotfiles.git ~/Source/personal/dotfiles
cd ~/Source/personal/dotfiles
./install.sh          # symlink configs into $HOME
./install.sh --brew   # also install packages from the Brewfile first
```

`install.sh` is **idempotent and conservative**: it re-links files it already
owns, never overwrites a real file (it reports a conflict and leaves it alone),
and resolves paths relative to the repo rather than your working directory. It
also seeds an empty `~/.zshrc.local` for machine-specific and secret config.

## What's in here

| File / dir          | Purpose                                                         |
| ------------------- | --------------------------------------------------------------- |
| `zshrc` / `bashrc`  | Shell config. Zsh (oh-my-zsh, agnoster) is the primary shell.   |
| `gitconfig`         | Git defaults, aliases, colours.                                 |
| `gitconfig.amber`   | Work identity, auto-applied under `~/Source/amber/` (see below).|
| `gitignore_global`  | Global gitignore.                                               |
| `nvim/`             | Primary Neovim config (lazy.nvim). Shared by terminal / VimR / Neovide. |
| `vimrc` / `gvimrc`  | Legacy Vim/MacVim config, retained but frozen.                  |
| `vscode/`           | Shared VS Code user settings and snippets.                      |
| `ackrc` / `gemrc`   | Legacy tool config.                                             |
| `Brewfile`          | Declarative package list for `brew bundle`.                     |
| `install.sh`        | The symlink bootstrapper.                                       |
| `AGENTS.md`         | Conventions for AI agents working in this repo.                 |

## Secrets & machine-specific config

Nothing secret or machine-specific lives in this repo. `zshrc` sources
`~/.zshrc.local` (created empty by `install.sh`, never tracked) as its last
step — put API keys, tokens, and per-machine `PATH` tweaks there.

## Work vs personal git identity

The default identity is personal (`jb@johnbarton.co`). Repositories under
`~/Source/amber/` automatically switch to the Amber email via a conditional
include:

```gitconfig
[includeIf "gitdir:~/Source/amber/"]
	path = ~/.gitconfig.amber
```

If you keep work repos somewhere else, edit that `gitdir:` path in `gitconfig`.

## Editors

Neovim (`nvim/`) is the primary editor. The old dein-based `vimrc` is kept for
muscle memory but is frozen — new editor work goes in `nvim/`.
