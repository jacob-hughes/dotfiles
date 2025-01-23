# Common
alias ls="ls -la --color"
alias vim="nvim"

# Linux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  alias sudo="doas "
  alias open="xdg-open"
# MacOS
elif [[ "$OSTYPE" == "darwin"* ]]; then
  alias inkscape="/Applications/Inkscape.app/Contents/MacOS/inkscape"
fi
