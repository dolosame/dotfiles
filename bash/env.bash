if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

complete -cf doas

export STARSHIP_CACHE=/tmp/starship
export HISCONTROL=ignoreboth
export HISTIMEFORMAT="%m-%d %H:%M"
export LESS="-R -i -M"
