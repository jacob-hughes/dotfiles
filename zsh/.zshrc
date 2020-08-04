fpath=( "$HOME/.zfunctions" $fpath )

autoload -U compinit
compinit

autoload -U colors
colors

autoload -U promptinit; promptinit

PURE_GIT_PULL=0
PURE_GIT_UNTRACKED_DIRTY=0
prompt pure

# Use GPG keychain for ssh
GPG_TTY=$(tty)
export GPG_TTY
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

export VISUAL=nvim
export EDITOR="$VISUAL"

# URL-encode strings
alias urlencode='python2.7 -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
alias urldecode='python2.7 -c "import sys, urllib as ul; print ul.unquote(sys.argv[1]);"'
alias b64encode='python2.7 -c "import sys, base64; print base64.b64encode(sys.argv[1]);"'
alias b64decode='python2.7 -c "import sys, base64; print base64.b64decode(sys.argv[1]);"'

alias dec='xargs printf "%d\n"'
alias hex='xargs printf "%x\n"'

# OSX like aliases
alias open='xdg-open'
alias pbcopy='xclip -selection c'
alias pbpaste='xclip -selection clipboard -o'

alias ls='ls --color'
alias mutt='neomutt'
alias vim='nvim'
alias v8gen="$HOME/research/v8/v8/tools/dev/v8gen.py"

# Clangd 11 path
export PATH="/opt/clangd/:$HOME/.local/bin:$PATH"

# Rust bins
export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"

# Depot tools
export PATH="/opt/depot_tools:$PATH"

# restore Ctrl A - E beginning end line
bindkey -e

export FZF_DEFAULT_COMMAND='ag -g ""'

# Ctrl r + fzf support
. ~/.zsh/fzf/key-bindings.zsh
. ~/.zsh/fzf/completion.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
