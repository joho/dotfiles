# Neovim configuration

This configuration is shared by terminal Neovim, VimR, and Neovide. It targets
the current Homebrew stable Neovim and bootstraps plugins on first launch.

## Useful commands

- `,t`: find files
- `,f`: search project text
- `,b`: switch buffers
- `,p`: format the current buffer
- `gd`, `gr`, `K`: definition, references, and documentation
- `,rn`, `,ca`: rename and code actions
- `:Lazy`: inspect or update plugins
- `:Mason`: inspect language servers
- `:checkhealth`: diagnose the installation

GUI-specific configuration should be kept small and guarded with `vim.g.neovide`
or the corresponding VimR variable. Normal editing behavior belongs in the
shared configuration.
