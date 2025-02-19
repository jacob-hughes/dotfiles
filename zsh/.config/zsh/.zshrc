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

# Initialize completion system
autoload -Uz compinit && compinit

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

ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"
ASDIR="$ZDOTDIR/zsh-autosuggestions"
FZFDIR="$HOME/.fzf"
FTABDIR="$ZDOTDIR/fzf-tab"

# auto-suggestions
[ -d $ASDIR ] || \
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions $ASDIR

# fzf
[ -d $FZFDIR ] || \
  (git clone --depth=1 https://github.com/junegunn/fzf.git $FZFDIR && \
  $FZFDIR/install --no-bash --no-fish --no-update-rc --completion --key-bindings)

# fzf-tab (tab autocompletions using fzf)
[ -d $FTABDIR ] || \
    git clone --depth=1 https://github.com/Aloxaf/fzf-tab.git $FTABDIR

[ -f "$ASDIR"/zsh-autosuggestions.zsh ] && \
    source "$ASDIR"/zsh-autosuggestions.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f "$FTABDIR"/fzf-tab.plugin.zsh ] && \
    source "$FTABDIR"/fzf-tab.plugin.zsh

# Machine specific environment variables
[ -f ~/.config/zsh/untracked-envs.zsh ] && \
    source ~/.config/zsh/untracked-envs.zsh

# Key bindings
bindkey -e

