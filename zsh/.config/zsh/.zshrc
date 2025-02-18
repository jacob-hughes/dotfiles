fpath=( ~/.config/zsh/zfuncs "${fpath[@]}" )

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
unsetopt menu_complete

# History
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000


# Set the prompt
PROMPT='%{%F{blue}%}%~%{%f%}
%F{%(?.green.red)}›%f '
# Load custom functions
autoload -z edit ineachdir lspath reset_broken_term

# Aliases
source ~/.config/zsh/aliases.zsh

# Auto-suggestions
if [ -f ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
else
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions \
      ~/.config/zsh/zsh-autosuggestions
  source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# fzf
if [ ! -d ~/.fzf ]; then
  git clone --depth=1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --no-bash --no-fish --no-update-rc --completion --key-bindings --xdg
fi

[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# Machine specific environment variables
[ -f ~/.config/zsh/untracked-envs.zsh ] && \
    source ~/.config/zsh/untracked-envs.zsh

# Key bindings
bindkey -e

