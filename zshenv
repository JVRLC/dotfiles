. "$HOME/.cargo/env" 2>/dev/null

# Ensure asdf shims are available to non-interactive shells (VS Code, etc.)
export PATH="$HOME/.asdf/shims:/opt/homebrew/bin:$PATH"
