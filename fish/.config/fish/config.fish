function fish_greeting
    echo Logged in as (whoami)@$hostname at (set_color yellow; date +%T; set_color normal)
end

# Environment Variables
set -gx EDITOR nvim

# Aliases
alias open='xdg-open'
alias pbcopy='xclip -selection c'
alias pbpaste='xclip -selection clipboard -o'
alias ls='ls --color'
alias vim='nvim'
