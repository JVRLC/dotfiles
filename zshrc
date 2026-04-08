# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Disable oh-my-zsh theme (Starship handles the prompt)
ZSH_THEME=""

# Auto-update configuration
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 13

# Plugins configuration
plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
  fzf
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Set language environment
export LANG=en_US.UTF-8

# Preferred editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Add Homebrew to PATH
export PATH="/opt/homebrew/bin:$PATH"

# === Modern CLI Aliases ===
alias ls="eza --icons --git"
alias ll="eza -la --icons --git"
alias lt="eza -la --icons --git --tree --level=2"
alias cat="bat"
alias gs="git status"
alias lg="lazygit"
alias zshconfig="nvim ~/.zshrc"

# === Version Manager: asdf (single source of truth) ===
. "$HOME/.asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

# bun
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export GPG_TTY=$(tty)

# === Modern CLI Tools (must be at end) ===
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"
eval "$(starship init zsh)"
