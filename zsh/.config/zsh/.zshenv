# Path configurations
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
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
