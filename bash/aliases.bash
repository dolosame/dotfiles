alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias diff='diff --color=auto'

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias mkdir='mkdir -pv'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias ln='ln -i'

alias df='df -h'
alias du='du -sh'
alias free='free -h'

alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

alias c='clear'
alias h='history'
alias q='exit'

alias ip='ip -c'
alias ports='ss -tulanp'
alias ping='ping -c 3'
alias localip='ip -br a'

alias reload='source ~/.bashrc'
alias path='echo -e ${PATH//:/\\n}'

alias icat='kitten icat'
alias lskernel='vkpurge list'
alias clrkernel='doas vkpurge rm all'
alias fuck='doas $(fc -ln -1)'

alias cfg='cd ~/.config'
alias minifetch='~/.config/scripts/mini_fetch.sh'
alias nvidia-on='doas ~/.config/scripts/nvidia_toggle.sh -e'
alias nvidia-off='doas ~/.config/scripts/nvidia_toggle.sh -d'
