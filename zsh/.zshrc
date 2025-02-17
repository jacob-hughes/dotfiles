# Options
setopt no_beep
setopt extended_glob
setopt no_bg_nice
setopt interactive_comments
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt auto_menu
setopt nullglob
setopt PROMPT_SUBST
setopt SHARE_HISTORY
setopt NO_CASE_GLOB
unsetopt menu_complete
unsetopt flow_control

# Initialize completion system
autoload -Uz compinit && compinit

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Set the prompt
PROMPT='%{%F{blue}%}%~%{%f%}
%F{%(?.green.red)}›%f '

# Load custom functions
autoload -z edit ineachdir lspath reset_broken_term

# Path configurations
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.fzf/bin:$PATH" # FZF
export PATH="$HOME/.cargo/bin:$PATH" # Rust

# Platform specific
if [[ "$OSTYPE" == "darwin"* ]]; then
	export PATH="/opt/homebrew/bin:$PATH"
	if command -v op >/dev/null 2>&1; then
		export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
	fi
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

export FZF_DEFAULT_COMMAND='rg --files'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# auto-suggestions
if [[ ! -d "$HOME/.zsh/zsh-autosuggestions" ]]; then
    mkdir -p "$HOME/.zsh"
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
fi

if [[ -f "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" ]]; then
    source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# fzf
if [[ ! -d "$HOME"/.fzf ]]; then
    git clone --depth=1 https://github.com/junegunn/fzf.git "$HOME"/.fzf
    "$HOME"/.fzf/install --all --no-bash --no-fish --no-update-rc
fi
source ~/.fzf.zsh 2>/dev/null

# Completion Styles (zstyle)
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:cat:*:*' ignored-patterns '(*.o|*.so|*.bin|*.pdf|*.png|*.wav)'

# Linux alias
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias open="xdg-open"
  alias du='du -h --max-depth=1'
# MacOS
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias du='du -h -d 1'
fi

# Git aliases
alias g="git status"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'
alias gcoall='git checkout -- .'
alias gr='git remote'
alias grbi='git rebase --interactive'
alias grbc='git rebase --continue'
alias gre='git reset'
alias grt='cd $(git rev-parse --show-toplevel)'
# Editing config files
alias zc="$EDITOR ~/.config/zsh/.zshrc"

# Key bindings
bindkey -e
bindkey -s '^F' "tmux-sessionizer --local\n"
