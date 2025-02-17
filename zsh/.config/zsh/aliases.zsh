# Common
alias ls="ls -la --color"
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


# Editing config files
alias zc="$EDITOR ~/.config/zsh/.zshrc"
alias za="$EDITOR ~/.config/zsh/aliases.zsh"
alias ze="$EDITOR ~/.config/zsh/.zshenv"
alias zf="$EDITOR ~/.config/zsh/zfuncs"

alias vc="$EDITOR ~/dotfiles/neovim/.config/nvim/init.lua"

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
