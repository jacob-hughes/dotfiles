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
setopt NO_CASE_GLOB
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
FZFGIT="$ZDOTDIR/fzf-git.sh"


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

[ -d "$FZFGIT" ] || \
    git clone --depth=1 https://github.com/junegunn/fzf-git.sh $FZFGIT

source "$FZFGIT/fzf-git.sh"

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
# apply to all command
zstyle ':fzf-tab:*' popup-min-size 50 8
# only apply to 'diff'
zstyle ':fzf-tab:complete:diff:*' popup-min-size 80 12

zstyle ':completion:*:cat:*:*' ignored-patterns '(*.o|*.so|*.bin|*.pdf|*.png|*.wav)'

# Machine specific environment variables
[ -f ~/.config/zsh/untracked-envs.zsh ] && \
    source ~/.config/zsh/untracked-envs.zsh

# Key bindings
bindkey -e

