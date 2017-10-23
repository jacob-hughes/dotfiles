source ~/.git-autocomplete
source ~/.git-prompt

alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote(sys.argv[1]);"'
alias b64encode='python -c "import sys, base64; print base64.b64encode(sys.argv[1]);"'
alias b64decode='python -c "import sys, base64; print base64.b64decode(sys.argv[1]);"'
alias prettyjson='python -m json.tool'

export VISUAL=vim
export EDITOR="$VISUAL"

export WORKON_HOME=~/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/bin/virtualenv2

source /usr/bin/virtualenvwrapper.sh
export PS1="\[\e[36m\][\[\e[m\] \u@\H \w \[\e[36m\]]\[\e[m\]: \n\[\e[36m\]\\$\[\e[m\] "

