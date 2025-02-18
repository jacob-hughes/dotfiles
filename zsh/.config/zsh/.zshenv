# Path configurations
export PATH="$HOME/.local/bin/neovim/bin:$PATH" # Local neovim
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.fzf/bin:$PATH" # FZF
export PATH="$HOME/.cargo/bin:$PATH" # Rust
export PATH="/opt/neovim/bin:$PATH" # Global neovim

# Platform specific
if [[ "$OSTYPE" == "darwin"* ]]; then
	export PATH="/opt/homebrew/bin:$PATH"
	export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
	# Disable telemetry
	export HOMEBREW_NO_ANALYTICS=1
fi


# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Default programs
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export TERM=xterm-256color

if command -v nvim >/dev/null 2>&1; then
	export EDITOR="nvim"
	export VISUAL="nvim"
elif command -v nvim >/dev/null 2>&1; then
	export EDITOR="vim"
	export VISUAL="vim"
else
	export EDITOR="vi"
	export VISUAL="vi"
fi

echo "PATH after .zshenv: $PATH" >> /tmp/path_debug.log

