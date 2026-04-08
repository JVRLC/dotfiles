# dotfiles

My development environment for macOS. One command setup.

## What's included

- **Shell**: Zsh + Oh My Zsh + Starship prompt
- **CLI tools**: eza, bat, fzf, zoxide, delta, fd, lazygit
- **Version manager**: asdf (Node, Elixir, Erlang, Python)
- **Editor**: VS Code with Catppuccin Mocha + Monaspace Neon
- **Git**: delta for diffs, side-by-side view

## Install

```bash
git clone https://github.com/eliaswalyba/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

## Manual steps after install

1. Install [Monaspace Neon](https://monaspace.githubnext.com) font
2. Update `gitconfig` with your name and email
3. Open a new terminal
4. Restart VS Code

## Structure

```
dotfiles/
  install.sh          # Main setup script
  zshrc               # Shell config (symlinked to ~/.zshrc)
  zshenv              # Non-interactive shell env (VS Code, etc.)
  zprofile            # Login shell (Homebrew)
  gitconfig           # Git config with delta
  tool-versions       # asdf global runtime versions
  vscode/
    settings.json     # VS Code settings
    extensions.txt    # VS Code extensions list
```

## Updating

After changing a config locally, the symlinks mean the dotfiles repo is already updated. Just commit and push.
