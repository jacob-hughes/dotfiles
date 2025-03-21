# Common
alias vim="edit $1"

# Linux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias open="xdg-open"
# MacOS
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias inkscape="/Applications/Inkscape.app/Contents/MacOS/inkscape"
fi

if command -v doas >/dev/null 2>&1; then
  alias sudo="doas"
  alias sudoedit="~/bin/doasedit"
fi

alias du='du -h --max-depth=1'

# Command replacement with fallbacks
fallback_command() {
    if command -v "$1" >/dev/null 2>&1; then
        "$1" "${@:3}"
    else
        command "$2" "${@:3}"
    fi
}

alias cat="fallback_command bat cat"
alias find="fallback_command fd find"

ls() {
    if command -v eza >/dev/null 2>&1; then
        eza -l --octal-permissions $@
    else
        ls -la $@
    fi
}
# Git
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

alias fixssh='eval $(tmux showenv -s SSH_AUTH_SOCK)'

# FZF magic

# Editing config files
alias zc="$EDITOR ~/.config/zsh/.zshrc"
alias za="$EDITOR ~/.config/zsh/aliases.zsh"
alias ze="$EDITOR ~/.config/zsh/.zshenv"
alias zue="$EDITOR ~/.config/zsh/untracked-envs.zsh"
alias zf="$EDITOR ~/.config/zsh/zfuncs"

alias vc="$EDITOR ~/dotfiles/neovim/.config/nvim/init.lua"
alias tmc="$EDITOR ~/.tmux.conf"

reload_fns() {
    for f in $ZDOTDIR/zfuncs/*; do
	unfunction "${f:t}" 2>/dev/null || true
    done
    autoload -Uz "$1"/*
}

alias sz='echo -n "Source $ZDOTDIR/.zshrc? [Y/n]" && \
  read response && [[ -z $response || $response =~ ^[Yy]$ ]] && \
  reload_fns; source $ZDOTDIR/.zshrc && \
  echo "ZSH config and functions reloaded"'
