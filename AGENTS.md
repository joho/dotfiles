# AGENTS.md

## Purpose

This repository keeps John Barton's command-line and editor configuration consistent across personal and work Macs. Changes should remain portable, understandable, and safe to apply repeatedly on an existing machine.

## Repository map

- `zshrc`, `bashrc`: shell configuration. Zsh is the primary interactive shell.
- `gitconfig`, `gitignore_global`: Git defaults and global ignore rules.
- `gitconfig.amber`: work identity, applied under `~/Source/amber/` via a conditional include.
- `nvim/`: primary Neovim configuration, shared by terminal Neovim, VimR, and Neovide.
- `vimrc`, `gvimrc`: retained legacy Vim/MacVim configuration.
- `vscode/settings.json`: shared VS Code user settings.
- `ackrc`, `gemrc`: legacy tool configuration; preserve unless deliberately retiring the associated tool.
- `install.sh`: conservative, idempotent linker. Pass `--brew` to install the `Brewfile` first.
- `hecate.yml`: configuration for an older project/tool, not part of machine bootstrap.

## Working guidelines

- Target macOS first. Keep work/personal differences explicit rather than embedding machine-specific absolute paths or credentials in shared files.
- Preserve existing user files. Bootstrap code must not silently overwrite a real file; detect it and either back it up or report a clear conflict.
- Make setup idempotent: running it twice should produce the same result without duplicate lines, repeated installs, or broken links.
- Resolve paths relative to the repository, not the caller's current working directory.
- Prefer small, composable config files and a manifest-driven linker over a long sequence of ad hoc `ln` commands.
- Keep secrets, tokens, cookies, private work settings, and machine-generated state out of the repository. Use optional local files for values that should not be shared.
- Do not add a dependency merely to manage a few symlinks. If adopting a dotfile manager, document why its benefits justify the bootstrap dependency.
- Retain familiar editor behavior where practical, but prefer maintained plugins and built-in capabilities over abandoned packages.

## Editing conventions

- Shell scripts should use `#!/usr/bin/env bash`, quote path expansions, and enable strict handling where appropriate (`set -euo pipefail`).
- Use `command -v` for dependency checks and `case "$(uname -s)"` for operating-system branching.
- Keep comments focused on intent or non-obvious compatibility constraints.
- Avoid broad formatting or cleanup changes mixed into a functional change.
- Update this file and any user-facing documentation when the bootstrap process or repository layout changes.

## Verification

Use the checks relevant to the files changed:

- Bash: `bash -n install.sh` (and `shellcheck install.sh` when ShellCheck is available).
- Zsh: `zsh -n zshrc`.
- Vim: launch the supported editor with the repository config and check startup for errors; for legacy Vim, `vim -Nu "$PWD/vimrc" -n` is a useful smoke test.
- Neovim, once added: run a headless startup check and the plugin manager's health/check command.
- Bootstrap/linking changes: test against a temporary `HOME` before using them on a real account.
- Always inspect `git diff` and ensure no personal or work credentials were introduced.

## Current known issues

- The legacy `vimrc` still uses dein and several obsolete or unmaintained plugins. Do not expand that stack; new editor work belongs in `nvim/`.
- Work/personal git identity is split via a conditional include (`gitconfig.amber` under `~/Source/amber/`); machine-local and secret shell config lives in an untracked `~/.zshrc.local` sourced by `zshrc`. Keep new machine/work-specific values in those seams rather than the shared files.
