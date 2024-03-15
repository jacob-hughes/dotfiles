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

function fish_right_prompt -d "Write out the right prompt"
  set -l exit_code $status

  if set -q $SSH_CLIENT || set -q $SSH_TTY
    set_color brblack
    echo (whoami)@$hostname
    set_color normal
  end

  # Print a red dot for failed commands.
  if test $exit_code -ne 0
    set_color red
    echo -n "• "
    set_color normal
  end
end

