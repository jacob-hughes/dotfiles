fpath=( ~/.config/zsh/zfuncs "${fpath[@]}" )
autoload -z installer && installer

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.config/zsh/p10k/powerlevel10k.zsh-theme || true
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh || true

source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/history.zsh
source ~/.config/zsh/key-bindings.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Load custom functions
autoload -z ineachdir lspath reset_broken_term

# Load hooks
autoload -Uz add-zsh-hook
add-zsh-hook -Uz precmd reset_broken_term
