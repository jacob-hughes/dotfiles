fpath=( ~/.config/zsh/zfuncs "${fpath[@]}" )
autoload -z installer && installer

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

setopt no_beep
setopt extended_glob
setopt no_bg_nice
setopt interactive_comments
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt auto_menu
setopt nullglob
unsetopt menu_complete

# History
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

source ~/.config/zsh/p10k/powerlevel10k.zsh-theme || true
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh || true

# Load custom functions
autoload -z edit ineachdir lspath reset_broken_term

# Aliases
source ~/.config/zsh/aliases.zsh

# Machine specific environment variables
[ -f ~/.config/zsh/untracked-envs.zsh ] && source ~/.config/zsh/untracked-envs.zsh

# Key bindings
bindkey -e

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load hooks
autoload -Uz add-zsh-hook
add-zsh-hook -Uz precmd reset_broken_term
