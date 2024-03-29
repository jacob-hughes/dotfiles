function fish_greeting
end

# Environment Variables
set -gx EDITOR nvim

# Aliases
alias open='xdg-open'
alias pbcopy='xclip -selection c'
alias pbpaste='xclip -selection clipboard -o'
alias ls='ls --color'
alias vim='nvim'

function fish_right_prompt -d "Write out the right prompt"
  set -l exit_code $status

  if set -q SSH_CLIENT || set -q SSH_TTY
    set_color brblack
    echo (whoami)@$hostname" "
    set_color normal
  end
end

