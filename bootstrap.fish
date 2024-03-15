#!/usr/bin/fish
function success
	echo [(set_color --bold green) ' OK ' (set_color normal)] $argv
end

function abort
	echo [(set_color --bold yellow) ABRT (set_color normal)] $argv
	exit 1
end

curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher
	and success 'fisher'
	or abort 'fisher'

git checkout -- fish/.config/fish/fish_plugins
	and success 'restore plugins'
	or abort 'restore plugins'

fisher update
	and success 'plugins'
	or abort 'plugins'

success 'fish plugins installed/updated!'
