alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# URL-encode strings
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1]);"'
alias urldecode='python -c "import sys, urllib as ul; print ul.unquote(sys.argv[1]);"'
alias b64encode='python -c "import sys, base64; print base64.b64encode(sys.argv[1]);"'
alias b64decode='python -c "import sys, base64; print base64.b64decode(sys.argv[1]);"'
alias prettyjson='python -m json.tool'

# Only load Liquid Prompt in interactive shells, not from a script or from scp
[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt

export VISUAL=vim
export EDITOR="$VISUAL"
