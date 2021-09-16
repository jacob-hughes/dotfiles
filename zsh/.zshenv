# Better Ctrl - R with fzf
export FZF_DEFAULT_OPTS="--height=70% --preview='cat {}' --preview-window=right:50%:wrap"
export FZF_DEFAULT_COMMAND="rg --files --hidden"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

setopt inc_append_history
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_reduce_blanks

HISTSIZE=15000
SAVEHIST=15000
HISTFILE=~/.zsh_history
source "$HOME/.cargo/env"
