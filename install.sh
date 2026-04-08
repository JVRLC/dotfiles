#!/usr/bin/env bash
set -e

echo "================================="
echo "  Elias's Dev Environment Setup"
echo "================================="
echo ""

# --- Detect OS ---
OS="$(uname -s)"
ARCH="$(uname -m)"

if [ "$OS" != "Darwin" ]; then
  echo "This script is built for macOS. Exiting."
  exit 1
fi

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# --- Homebrew ---
echo "==> Installing Homebrew (if needed)..."
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- Brewfile (CLI tools, fonts, build deps) ---
echo "==> Installing from Brewfile..."
brew bundle --file="$DOTFILES_DIR/Brewfile" --no-lock

# --- Oh My Zsh ---
echo "==> Installing Oh My Zsh (if needed)..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[ -d "$ZSH_CUSTOM/plugins/zsh-completions" ] || \
  git clone https://github.com/zsh-users/zsh-completions "$ZSH_CUSTOM/plugins/zsh-completions"

# --- asdf ---
echo "==> Installing asdf (if needed)..."
if [ ! -d "$HOME/.asdf" ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.15.0
fi
source "$HOME/.asdf/asdf.sh"

echo "==> Installing asdf plugins..."
asdf plugin add nodejs 2>/dev/null || true
asdf plugin add elixir 2>/dev/null || true
asdf plugin add erlang 2>/dev/null || true
asdf plugin add python 2>/dev/null || true
asdf plugin add k6 2>/dev/null || true

# --- Bun ---
echo "==> Installing Bun (if needed)..."
if ! command -v bun &>/dev/null; then
  curl -fsSL https://bun.sh/install | bash
fi

# --- Symlink dotfiles ---
echo "==> Linking dotfiles..."
link_file() {
  local src="$1" dst="$2"
  if [ -f "$dst" ] || [ -L "$dst" ]; then
    local backup="$dst.backup.$(date +%s)"
    echo "    Backing up $dst -> $backup"
    mv "$dst" "$backup"
  fi
  ln -sf "$src" "$dst"
  echo "    $src -> $dst"
}

link_file "$DOTFILES_DIR/zshrc"          "$HOME/.zshrc"
link_file "$DOTFILES_DIR/zshenv"         "$HOME/.zshenv"
link_file "$DOTFILES_DIR/zprofile"       "$HOME/.zprofile"
link_file "$DOTFILES_DIR/gitconfig"      "$HOME/.gitconfig"
link_file "$DOTFILES_DIR/tool-versions"  "$HOME/.tool-versions"

mkdir -p "$HOME/.config"
link_file "$DOTFILES_DIR/starship.toml"  "$HOME/.config/starship.toml"

# --- VS Code ---
VSCODE_DIR="$HOME/Library/Application Support/Code/User"
if [ -d "/Applications/Visual Studio Code.app" ]; then
  echo "==> Configuring VS Code..."
  mkdir -p "$VSCODE_DIR"
  link_file "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_DIR/settings.json"

  echo "==> Installing VS Code extensions..."
  while IFS= read -r ext; do
    code --install-extension "$ext" 2>/dev/null || true
  done < "$DOTFILES_DIR/vscode/extensions.txt"
else
  echo "    VS Code not found, skipping."
fi

# --- Install runtime versions ---
echo "==> Installing runtime versions from .tool-versions..."
echo "    This may take a while (Erlang compiles from source)..."
cd "$HOME"
asdf install 2>/dev/null || true

# --- Font reminder ---
echo ""
echo "================================="
echo "  Setup complete!"
echo "================================="
echo ""
echo "Manual steps remaining:"
echo "  1. Update gitconfig with your name and email"
echo "  2. Open a new terminal to activate the shell"
echo "  3. Restart VS Code (Cmd+Q, then 'code .')"
echo ""
